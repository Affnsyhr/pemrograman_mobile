import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper {
  // Membuat instance tunggal (singleton) dari DatabaseHelper.
  // Ini memastikan kita hanya memiliki satu koneksi database di seluruh aplikasi.
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  // Getter untuk database. Jika database belum diinisialisasi,
  // maka akan diinisialisasi terlebih dahulu.
  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  // Fungsi untuk menginisialisasi database.
  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'geeksforgeeks.db');

    // Buka database. Jika belum ada, maka _onCreate akan dijalankan.
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Fungsi ini dijalankan HANYA SEKALI saat database pertama kali dibuat.
  // Di sinilah kita mendefinisikan skema tabel.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE gfg_users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL,
      email TEXT NOT NULL
    )
    ''');
  }

  // --- OPERASI CRUD ---

  // 1. Create: Menambahkan user baru
  Future<int> insertUser(User user) async {
    Database db = await instance.db;
    return await db.insert('gfg_users', user.toMap());
  }

  // 2. Read: Mengambil semua user
  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await instance.db;
    return await db.query('gfg_users');
  }

  // 3. Update: Memperbarui user berdasarkan id
  Future<int> updateUser(User user) async {
    Database db = await instance.db;
    int id = user.id!;
    return await db.update('gfg_users', user.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  // 4. Delete: Menghapus user berdasarkan id
  Future<int> deleteUser(int id) async {
    Database db = await instance.db;
    return await db.delete('gfg_users', where: 'id = ?', whereArgs: [id]);
  }

  // Fungsi helper untuk menambahkan data awal (untuk demo)
  Future<void> initializeUsers() async {
    // Cek dulu apakah sudah ada data, jika sudah ada jangan ditambah lagi
    List<Map<String, dynamic>> users = await queryAllUsers();
    if (users.isNotEmpty) {
        return; // Data sudah ada, tidak perlu inisialisasi
    }

    List<User> usersToAdd = [
      User(username: 'John Doe', email: 'john.doe@example.com'),
      User(username: 'Jane Smith', email: 'jane.smith@example.com'),
      User(username: 'Alice Johnson', email: 'alice.j@example.com'),
      User(username: 'Bob Brown', email: 'bob.brown@example.com'),
    ];

    for (User user in usersToAdd) {
      await insertUser(user);
    }
  }
}