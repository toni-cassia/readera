import 'package:flutter/material.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import 'package:provider/provider.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookListItem({
    Key? key,
    required this.book,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: book.imageUrl.isNotEmpty
          ? Image.network(
        book.imageUrl,
        width: 50,
        height: 75,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.book, size: 50);
        },
      )
          : Icon(Icons.book, size: 50),
      title: Text(book.title),
      subtitle: Text(book.author),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Colors.yellow),
          Text(book.rating.toStringAsFixed(1)),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(
              book.isRead ? Icons.check_circle : Icons.check_circle_outline,
              color: book.isRead ? Colors.purple : Colors.grey,
            ),
            onPressed: () {
              Provider.of<BookProvider>(context, listen: false)
                  .updateBook(book.copyWith(isRead: !book.isRead));
            },
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}