import 'package:cloud_firestore/cloud_firestore.dart';

enum BorrowingStatus { active, returned, overdue, reserved }

class Borrowing {
  final String id;
  final String bookId;
  final String memberId;
  final DateTime borrowDate;
  final DateTime dueDate;
  final DateTime? returnDate;
  final BorrowingStatus status;

  Borrowing({
    required this.id,
    required this.bookId,
    required this.memberId,
    required this.borrowDate,
    required this.dueDate,
    this.returnDate,
    this.status = BorrowingStatus.active,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookId': bookId,
      'memberId': memberId,
      'borrowDate': Timestamp.fromDate(borrowDate),
      'dueDate': Timestamp.fromDate(dueDate),
      'returnDate': returnDate != null ? Timestamp.fromDate(returnDate!) : null,
      'status': status.name,
    };
  }

  factory Borrowing.fromMap(Map<String, dynamic> map, String documentId) {
    return Borrowing(
      id: documentId,
      bookId: map['bookId'] ?? '',
      memberId: map['memberId'] ?? '',
      borrowDate: (map['borrowDate'] as Timestamp).toDate(),
      dueDate: (map['dueDate'] as Timestamp).toDate(),
      returnDate: (map['returnDate'] as Timestamp?)?.toDate(),
      status: BorrowingStatus.values.firstWhere(
        (e) => e.name == (map['status'] ?? 'active'),
        orElse: () => BorrowingStatus.active,
      ),
    );
  }
}
