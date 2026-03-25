class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String description;
  final String coverUrl;
  final int quantity;
  final int availableQuantity;
  final String isbn;
  final bool isFeatured;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.coverUrl,
    required this.quantity,
    required this.availableQuantity,
    required this.isbn,
    this.isFeatured = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'description': description,
      'coverUrl': coverUrl,
      'quantity': quantity,
      'availableQuantity': availableQuantity,
      'isbn': isbn,
      'isFeatured': isFeatured,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      id: documentId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      genre: map['genre'] ?? '',
      description: map['description'] ?? '',
      coverUrl: map['coverUrl'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      availableQuantity: map['availableQuantity']?.toInt() ?? 0,
      isbn: map['isbn'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
    );
  }

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? genre,
    String? description,
    String? coverUrl,
    int? quantity,
    int? availableQuantity,
    String? isbn,
    bool? isFeatured,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      quantity: quantity ?? this.quantity,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      isbn: isbn ?? this.isbn,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
