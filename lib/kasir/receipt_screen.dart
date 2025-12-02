import 'package:flutter/material.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7A8B8), // Background pink
      body: Center(
        child: Container(
          width: 330,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xffE7E7E7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ICON CHECK
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 10),

              const Text(
                "Pembayaran Berhasil",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),

              const Text(
                "Rp. 349.000",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              _dashedDivider(),

              _detailRow("Tanggal", "17 Okt 2025"),
              _detailRow("Pelanggan", "Helena"),
              _detailRow("Metode Pembayaran", "Tunai"),

              _dashedDivider(),

              _itemRow("Hacipupu Cancer", "1 x 199.000", "199.000"),
              const SizedBox(height: 6),
              _itemRow("Labubu Soymilk", "1 x 245.000", "245.000"),

              _dashedDivider(),

              _summaryRow("Diskon", "50.000"),
              _summaryRow("Subtotal", "444.000"),
              _summaryRow("Total", "349.000", bold: true),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionButton(context, "Keluar", Colors.red, () {
                    Navigator.pop(context);
                  }),
                  _actionButton(context, "Cetak", Colors.green, () {
                    // implement print logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fungsi Cetak belum diimplementasikan')),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Garis putus-putus yang aman (tidak menyebabkan layout overflow)
  Widget _dashedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LayoutBuilder(builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final boxWidth = constraints.maxWidth;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(dashCount, (index) {
            return Container(
              width: dashWidth,
              height: 1,
              margin: const EdgeInsets.only(right: dashSpace),
              color: Colors.grey,
            );
          }),
        );
      }),
    );
  }

  // Baris detail kiri - kanan
  Widget _detailRow(String left, String right) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: const TextStyle(fontSize: 14)),
          Text(right, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  // Baris item produk
  Widget _itemRow(String title, String sub, String price) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  // Baris ringkasan
  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style:
                  TextStyle(fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // Tombol aksi
  Widget _actionButton(BuildContext context, String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
