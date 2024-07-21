import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import 'add_edit_screen.dart';

class BookDetailScreen extends StatefulWidget {
  final int bookId;

  BookDetailScreen({required this.bookId});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  Book? _book;

  @override
  void initState() {
    super.initState();
    _fetchBookDetails();
  }

  Future<void> _fetchBookDetails() async {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    final book = await bookProvider.getBookById(widget.bookId);
    setState(() {
      _book = book;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _book != null ? Text(_book!.title) : Text('Loading...'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditBookScreen(book: _book),
                ),
              ).then((_) => _fetchBookDetails());
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Delete Book'),
                  content: Text('Are you sure you want to delete this book?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: Text('Delete'),
                      onPressed: () {
                        Provider.of<BookProvider>(context, listen: false)
                            .deleteBook(widget.bookId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _book != null
          ? SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _book!.imageUrl.isNotEmpty
                    ? Image.network(
                  _book!.imageUrl,
                  height: 200,
                  fit: BoxFit.cover,
                )
                    : Container(
                  height: 200,
                  width: 150,
                  color: Colors.grey,
                  child: Icon(Icons.book, size: 50),
                ),
              ),
              SizedBox(height: 16),
              Text('Title: ${_book!.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Author: ${_book!.author}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Rating: ${_book!.rating.toStringAsFixed(1)}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              Text('Status: ${_book!.isRead ? 'Read' : 'Unread'}', style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}