class User {
  final int? id; // id bisa null saat membuat user baru
  final String username;
  final String email;

  // Konstruktor
  User({this.id, required this.username, required this.email});

  // Method untuk mengubah objek User menjadi Map.
  // Ini berguna saat memasukkan data ke database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  // Factory constructor untuk membuat objek User dari Map.
  // Ini berguna saat membaca data dari database.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      email: map['email'],
    );
  }
}