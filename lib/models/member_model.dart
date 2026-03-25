enum UserRole { visitor, member, admin }

class Member {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String profilePicUrl;
  final UserRole role;

  Member({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.profilePicUrl = '',
    this.role = UserRole.visitor,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'profilePicUrl': profilePicUrl,
      'role': role.name,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map, String documentId) {
    return Member(
      id: documentId,
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      profilePicUrl: map['profilePicUrl'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.name == (map['role'] ?? 'visitor'),
        orElse: () => UserRole.visitor,
      ),
    );
  }
}
