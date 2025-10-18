import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'user.dart';

// Fungsi main diubah menjadi async untuk menunggu inisialisasi database
void main() async {
  // Memastikan semua widget Flutter siap sebelum menjalankan kode async
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi database dan tambahkan data awal
  // Kita panggil initDb untuk memastikan database sudah ada
  await DatabaseHelper.instance.db; 
  await DatabaseHelper.instance.initializeUsers();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite User Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  // State untuk menyimpan daftar pengguna
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data saat widget pertama kali dibuat
    _fetchUsers();
  }

  // Fungsi untuk mengambil data dari database dan memperbarui state
  Future<void> _fetchUsers() async {
    // Ambil data dalam bentuk List<Map>
    final userMaps = await DatabaseHelper.instance.queryAllUsers();
    
    // Perbarui state dengan data baru yang sudah diubah menjadi List<User>
    setState(() {
      _users = userMaps.map((userMap) => User.fromMap(userMap)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GFG User List'),
        backgroundColor: Colors.lightGreen,
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          return Card( // Menggunakan Card untuk tampilan yang lebih baik
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.lightGreen,
                child: Text(_users[index].username[0]), // Inisial nama
              ),
              title: Text(_users[index].username),
              subtitle: Text(_users[index].email),
            ),
          );
        },
      ),
    );
  }
}