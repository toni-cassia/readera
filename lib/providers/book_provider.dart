import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../services/database_service.dart';
import '../services/preference_service.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> get books => _books;

  final DatabaseService _databaseService = DatabaseService();
  final PreferencesService _preferencesService = PreferencesService();

  String _sortOrder = 'title';
  String get sortOrder => _sortOrder;

  Future<void> fetchBooks() async {
    _books = await _databaseService.getBooks();
    _sortOrder = await _preferencesService.getSortOrder();
    _sortBooks();
    notifyListeners();
  }

  Future<Book?> getBookById(int id) async {
    return await _databaseService.getBookById(id);
  }

  Future<void> addBook(Book book) async {
    final id = await _databaseService.insertBook(book);
    book = book.copyWith(id: id);
    _books.add(book);
    _sortBooks();
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    await _databaseService.updateBook(book);
    int index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      _sortBooks();
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    await _databaseService.deleteBook(id);
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  List<Book> searchBooks(String query) {
    return _books.where((book) =>
    book.title.toLowerCase().contains(query.toLowerCase()) ||
        book.author.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<void> setSortOrder(String order) async {
    await _preferencesService.setSortOrder(order);
    _sortOrder = order;
    _sortBooks();
    notifyListeners();
  }

  void _sortBooks() {
    switch (_sortOrder) {
      case 'title':
        _books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'author':
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'rating':
        _books.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
  }
}