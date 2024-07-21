import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;

  AddEditBookScreen({this.book});

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _author;
  late double _rating;
  late bool _isRead;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _title = widget.book?.title ?? '';
    _author = widget.book?.author ?? '';
    _rating = widget.book?.rating ?? 0;
    _isRead = widget.book?.isRead ?? false;
    _imageUrl = widget.book?.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Add Book' : 'Edit Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author';
                  }
                  return null;
                },
                onSaved: (value) => _author = value!,
              ),
              TextFormField(
                initialValue: _imageUrl,
                decoration: InputDecoration(labelText: 'Image URL'),
                onSaved: (value) => _imageUrl = value ?? '',
              ),
              Slider(
                value: _rating,
                min: 0,
                max: 5,
                divisions: 5,
                label: _rating.toString(),
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Read'),
                value: _isRead,
                onChanged: (value) {
                  setState(() {
                    _isRead = value!;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final book = Book(
                      id: widget.book?.id,
                      title: _title,
                      author: _author,
                      rating: _rating,
                      isRead: _isRead,
                      imageUrl: _imageUrl,
                    );
                    if (widget.book == null) {
                      Provider.of<BookProvider>(context, listen: false).addBook(book);
                    } else {
                      Provider.of<BookProvider>(context, listen: false).updateBook(book);
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}