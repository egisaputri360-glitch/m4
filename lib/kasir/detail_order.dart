import 'dart:ui';
import 'package:flutter/material.dart';

class DetailOrderPage extends StatefulWidget {
  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  String customerName = "Helena";

  int subtotal = 444000;
  int diskon = 50000;
  int total = 349000;

  int selectedPayment = 0; // 0 Tunai, 1 Qris, 2 Debit
  bool showConfirmDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDECEC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFDECEC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text("Detail Order",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameField(),

                  const SizedBox(height: 20),
                  const Text("Barang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),

                  productCard("Hacipupu Cancer", 199000,
                      "https://i.ibb.co/THJZt0C/1.png"),
                  const SizedBox(height: 10),

                  productCard("Labubu Soymilk", 245000,
                      "https://i.ibb.co/T0S06ZP/2.png"),

                  const SizedBox(height: 20),
                  paymentSummary(),

                  const SizedBox(height: 20),
                  paymentMethod(),

                  const SizedBox(height: 30),
                  payButton(),
                ],
              ),
            ),
          ),

          if (showConfirmDialog) confirmDialog(),
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // NAMA PEMBELI
  // --------------------------------------------------------
  Widget nameField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade400, width: 2),
      ),
      child: TextField(
        controller: TextEditingController(text: customerName),
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: "Nama :",
        ),
        onChanged: (v) => setState(() => customerName = v),
      ),
    );
  }

  // --------------------------------------------------------
  // CARD PRODUK
  // --------------------------------------------------------
  Widget productCard(String title, int price, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  "Rp ${price.toString().replaceAll(",", ".")}",
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),

          const Text("1",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // RINGKASAN PEMBAYARAN
  // --------------------------------------------------------
  Widget paymentSummary() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          summaryRow("Subtotal", subtotal),
          summaryRow("Diskon", diskon),
          const Divider(thickness: 1),
          summaryRow("Total", total, bold: true),
        ],
      ),
    );
  }

  Widget summaryRow(String label, int value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text("Rp. $value",
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  // --------------------------------------------------------
  // PILIH METODE PEMBAYARAN
  // --------------------------------------------------------
  Widget paymentMethod() {
    final icons = [
      Icons.money,
      Icons.qr_code_2,
      Icons.credit_card,
    ];

    final names = ["Tunai", "Qris", "Debit"];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (i) {
        return GestureDetector(
          onTap: () => setState(() => selectedPayment = i),
          child: Container(
            width: 90,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: selectedPayment == i ? Colors.pink.shade300 : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Icon(icons[i],
                    color: selectedPayment == i ? Colors.white : Colors.black87),
                const SizedBox(height: 5),
                Text(
                  names[i],
                  style: TextStyle(
                    color: selectedPayment == i
                        ? Colors.white
                        : Colors.black87,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  // --------------------------------------------------------
  // TOMBOL PEMBAYARAN
  // --------------------------------------------------------
  Widget payButton() {
    return GestureDetector(
      onTap: () => setState(() => showConfirmDialog = true),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.pink.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            "Pembayaran",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  // POPUP KONFIRMASI PEMBAYARAN
  // --------------------------------------------------------
  Widget confirmDialog() {
    return Stack(
      children: [
        // Blur Background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(color: Colors.black26),
        ),

        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.pink.shade100.withOpacity(0.95),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Konfirmasi Pembayaran",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),

                Text("Nama : $customerName"),
                const SizedBox(height: 6),
                const Text("Barang : 2 produk"),
                const SizedBox(height: 6),
                Text("Total : Rp. $total"),
                const SizedBox(height: 6),
                Text("Metode Pembayaran : ${["Tunai", "Qris", "Debit"][selectedPayment]}"),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dialogButton("Batal", Colors.red, () {
                      setState(() => showConfirmDialog = false);
                    }),
                    dialogButton("Konfirmasi", Colors.green, () {
                      // aksi pembayaran selesai
                      setState(() => showConfirmDialog = false);
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dialogButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
