import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/student.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final db = DBHelper.instance;
  final ctrl = TextEditingController();

  Future _process(String raw) async {
    String nim = raw;
    String? name;
    if (raw.contains('|')) {
      final parts = raw.split('|');
      nim = parts[0];
      name = parts.sublist(1).join('|');
    }
    final s = await db.getStudentByNim(nim);
    if (s != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ditemukan: ${s.nim} - ${s.name}')),
      );
    } else {
      final add = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Data tidak terdaftar'),
          content: Text(
            'Hasil: $nim${name != null ? ' - $name' : ''}\nTambahkan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Tambah'),
            ),
          ],
        ),
      );
      if (add == true) {
        await db.insertStudent(Student(nim: nim, name: name ?? 'Unknown'));
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Data ditambahkan')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Scan QR (Web)')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                'Tidak tersedia kamera di web build. Tempel payload QR (nim|name) di bawah untuk menguji parsing.',
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ctrl,
                decoration: const InputDecoration(labelText: 'Payload QR'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => _process(ctrl.text.trim()),
                child: const Text('Proses'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
