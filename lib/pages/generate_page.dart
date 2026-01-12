import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/student.dart';
import '../db/db_helper.dart';

class GeneratePage extends StatefulWidget {
  final Student? student;
  const GeneratePage({super.key, this.student});

  @override
  State<GeneratePage> createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  Student? selected;
  List<Student> list = [];
  final db = DBHelper.instance;

  @override
  void initState() {
    super.initState();
    selected = widget.student;
    _load();
  }

  Future _load() async {
    final l = await db.getStudents();
    setState(() => list = l);
  }

  String _payloadFor(Student s) {
    // Use nim|name format to keep it simple and parseable
    return '${s.nim}|${s.name}';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Generate QR')),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              if (selected == null) ...[
                const Text(
                  'Pilih mahasiswa untuk generate QR kode',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: list.isEmpty
                      ? const Center(
                          child: Text(
                            'Belum ada data, tambahkan di tab Data Mahasiswa',
                          ),
                        )
                      : ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (_, i) {
                            final s = list[i];
                            return Card(
                              child: ListTile(
                                title: Text(s.nim),
                                subtitle: Text(s.name),
                                onTap: () => setState(() => selected = s),
                              ),
                            );
                          },
                        ),
                ),
              ] else ...[
                Text(
                  '${selected!.nim}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(selected!.name, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: QrImageView(
                        data: _payloadFor(selected!),
                        size: 220,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => setState(() => selected = null),
                  child: const Text('Pilih Mahasiswa Lain'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
