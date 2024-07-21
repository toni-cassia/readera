import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'book_library.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE books(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            rating REAL,
            isRead INTEGER,
            imageUrl TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE books ADD COLUMN imageUrl TEXT');
        }
      },
    );
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    return await db.insert('books', book.toMap());
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('books');
    return List.generate(maps.length, (i) => Book.fromMap(maps[i]));
  }

  Future<Book?> getBookById(int id) async {
    final db = await database;
    final maps = await db.query('books', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Book.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}