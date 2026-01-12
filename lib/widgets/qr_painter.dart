import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SimpleQr extends StatelessWidget {
  final String data;
  final double size;

  const SimpleQr({super.key, required this.data, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: QrImageView(data: data, size: size),
    );
  }
}
