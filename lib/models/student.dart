class Student {
  final int? id;
  final String nim;
  final String name;

  Student({this.id, required this.nim, required this.name});

  factory Student.fromMap(Map<String, dynamic> m) => Student(
    id: m['id'] as int?,
    nim: m['nim'] as String,
    name: m['name'] as String,
  );

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'nim': nim, 'name': name};
    if (id != null) map['id'] = id;
    return map;
  }
}
