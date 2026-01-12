import 'package:flutter/material.dart';
import '../models/student.dart';
import '../pages/generate_page.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const StudentCard({
    super.key,
    required this.student,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text('${student.nim}'),
        subtitle: Text(student.name),
        trailing: Wrap(
          spacing: 8,
          children: [
            TextButton.icon(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GeneratePage(student: student),
                  ),
                );
              },
              icon: const Icon(Icons.qr_code, color: Colors.black54),
              label: const Text('QR', style: TextStyle(color: Colors.black87)),
            ),
            TextButton.icon(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              label: const Text(
                'Hapus',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
