import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:intl/intl.dart';
import '../models/product_model.dart';

class POSPage extends StatefulWidget {
  const POSPage({super.key});

  @override
  State<POSPage> createState() => _POSPageState();
}

class _POSPageState extends State<POSPage> {
  // Keranjang Belanja
  List<CartItem> cart = [];

  final currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // Fungsi Menghitung Total
  double get totalTransaction {
    return cart.fold(0, (sum, item) => sum + item.totalPrice);
  }

  // Fungsi Scan
  void _openScanner() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text("Scan Barcode Produk")),
          body: MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.noDuplicates,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  _processCode(barcode.rawValue!);
                  Navigator.pop(
                    context,
                  ); // Tutup scanner setelah dapat 1 barang
                  break;
                }
              }
            },
          ),
        ),
      ),
    );
  }

  // Logika Mencari Barang
  void _processCode(String code) {
    try {
      // Cari produk di database (storeProducts)
      final product = storeProducts.firstWhere((p) => p.code == code);

      setState(() {
        // Cek apakah produk sudah ada di keranjang
        final existingItem = cart.firstWhere(
          (item) => item.product.code == code,
          orElse: () => CartItem(product: product, quantity: 0),
        );

        if (existingItem.quantity > 0) {
          // Jika sudah ada, tambahkan quantity
          existingItem.quantity++;
        } else {
          // Jika belum ada, tambahkan item baru
          cart.add(CartItem(product: product));
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Berhasil menambah: ${product.name}")),
      );
    } catch (e) {
      // Jika produk tidak ditemukan
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Produk Tidak Dikenal"),
          content: Text("Kode barang '$code' tidak ada di database."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // Proses Pembayaran
  void _processPayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Pembayaran"),
          content: Text(
            "Total belanja ${currency.format(totalTransaction)}. Proses pembayaran?",
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                setState(() {
                  cart.clear(); // Kosongkan keranjang
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Transaksi Berhasil!"),
                    backgroundColor: Color(0xFF4CAF50), // Green
                    duration: Duration(seconds: 3),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4CAF50), // Green
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("💳 KasirKita"),
        centerTitle: true,
        actions: [
          // Tombol Reset Keranjang
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  cart.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Keranjang telah dikosongkan"),
                    backgroundColor: Color(0xFFFFC107),
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline, size: 18),
              label: const Text("Reset"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF8BBD9), // Light pink
                foregroundColor: Colors.black87,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFBFE), // Light background
              Color(0xFFFCE4EC), // Very light pink
            ],
          ),
        ),
        child: Column(
          children: [
            // Bagian Total Harga
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFC107), Color(0xFFFFD54F)], // Gold gradient
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              width: double.infinity,
              child: Column(
                children: [
                  const Icon(
                    Icons.attach_money,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Total Transaksi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    currency.format(totalTransaction),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Bagian List Keranjang
            Expanded(
              child: cart.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 80,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Keranjang Kosong",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Scan produk untuk memulai",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final cartItem = cart[index];
                        return Dismissible(
                          key: Key(cartItem.product.code),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Hapus Barang"),
                                  content: Text(
                                    "Apakah Anda yakin ingin menghapus ${cartItem.product.name} dari keranjang?"
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text("Batal"),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                      ),
                                      child: const Text("Hapus"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onDismissed: (direction) {
                            setState(() {
                              cart.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("${cartItem.product.name} dihapus dari keranjang"),
                                action: SnackBarAction(
                                  label: "Undo",
                                  onPressed: () {
                                    setState(() {
                                      cart.insert(index, cartItem);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8BBD9).withOpacity(0.2), // Light pink background
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.shopping_bag,
                                  color: Color(0xFFFFC107), // Gold
                                ),
                              ),
                              title: Text(
                                "${cartItem.quantity}x ${cartItem.product.name}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.product.code,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "${currency.format(cartItem.product.price)} × ${cartItem.quantity}",
                                    style: const TextStyle(
                                      color: Color(0xFFFFC107), // Gold
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                currency.format(cartItem.totalPrice),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4CAF50), // Green for price
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            // Tombol Bayar Sekarang
            if (cart.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton.icon(
                    onPressed: _processPayment,
                    icon: const Icon(Icons.payment, size: 28),
                    label: const Text(
                      "Bayar Sekarang",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50), // Green
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.green.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openScanner,
        icon: const Icon(Icons.qr_code_scanner, size: 24),
        label: const Text(
          "Scan Produk",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
