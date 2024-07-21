class Book {
  final int? id;
  final String title;
  final String author;
  final double rating;
  final bool isRead;
  final String imageUrl;  // New field for image URL

  Book({
    this.id,
    required this.title,
    required this.author,
    this.rating = 0.0,
    this.isRead = false,
    this.imageUrl = '',  // Default empty string for image URL
  });

  Book copyWith({
    int? id,
    String? title,
    String? author,
    double? rating,
    bool? isRead,
    String? imageUrl,  // Added to copyWith
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,  // Include in copyWith
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'isRead': isRead ? 1 : 0,
      'imageUrl': imageUrl,  // Include in toMap
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      rating: map['rating'],
      isRead: map['isRead'] == 1,
      imageUrl: map['imageUrl'] ?? '',  // Include in fromMap with default value
    );
  }
}