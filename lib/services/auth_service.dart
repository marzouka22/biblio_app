import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/member_model.dart';
import '../utils/constants.dart';

class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  // Stream of auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign Up
  Future<User?> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // Create Member in Firestore
        final member = Member(
          id: user.uid,
          email: email,
          firstName: firstName,
          lastName: lastName,
          role: UserRole.member, // Default role
        );

        await _firestore
            .collection(AppConstants.membersCollection)
            .doc(user.uid)
            .set(member.toMap());

        return user;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
    return null;
  }

  // Sign In
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get Member Details
  Future<Member?> getMemberDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection(AppConstants.membersCollection)
          .doc(uid)
          .get();

      if (doc.exists) {
        return Member.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      print("Error getting member details: $e");
    }
    return null;
  }
}
