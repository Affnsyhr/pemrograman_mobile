import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/student.dart';
import '../widgets/student_card.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final db = DBHelper.instance;
  List<Student> students = [];
  final searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future _load([String? q]) async {
    final list = await db.getStudents(query: q);
    setState(() => students = list);
  }

  Future _showAddDialog() async {
    final nimCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Tambah Mahasiswa'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nimCtrl,
              decoration: const InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            label: const Text('Batal'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              final nim = nimCtrl.text.trim();
              final name = nameCtrl.text.trim();
              if (nim.isEmpty || name.isEmpty) return;
              try {
                await db.insertStudent(Student(nim: nim, name: name));
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Data tersimpan')));
                _load();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Gagal menyimpan (mungkin NIM sudah ada)'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future _confirmDelete(Student s) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Hapus data'),
        content: Text('Hapus ${s.nim} - ${s.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await db.deleteStudent(s.id!);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data dihapus')));
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Data Mahasiswa'),
          actions: [
            TextButton.icon(
              onPressed: () => _load(),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: const Text(
                'Refresh',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: searchCtrl,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Cari NIM atau nama',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      searchCtrl.clear();
                      _load();
                    },
                  ),
                ),
                onChanged: (v) => _load(v),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: students.isEmpty
                    ? const Center(child: Text('Belum ada data'))
                    : ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (_, i) {
                          final s = students[i];
                          return StudentCard(
                            student: s,
                            onDelete: () => _confirmDelete(s),
                            onEdit: () async {
                              // future: edit support
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showAddDialog,
          icon: const Icon(Icons.add),
          label: const Text('Tambah'),
        ),
      ),
    );
  }
}
