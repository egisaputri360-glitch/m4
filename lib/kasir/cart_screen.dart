import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int qty1 = 1;
  int qty2 = 1;

  int price1 = 199000;
  int price2 = 245000;

  int selectedPayment = 0; // 0 = Tunai, 1 = QRIS, 2 = Debit

  bool showDeleteDialog = false;

  @override
  Widget build(BuildContext context) {
    int total = (price1 * qty1) + (price2 * qty2);

    return Scaffold(
      backgroundColor: const Color(0xffFDECEC),
      appBar: AppBar(
        backgroundColor: const Color(0xffFDECEC),
        elevation: 0,
        title: const Text(
          "Keranjang",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productCard(
                  image: "https://i.ibb.co/THJZt0C/1.png",
                  title: "Hacipupu Cancer",
                  price: price1,
                  qty: qty1,
                  onAdd: () => setState(() => qty1++),
                  onMin: () => setState(() => qty1 = qty1 == 1 ? 1 : qty1 - 1),
                  onDelete: () => setState(() => showDeleteDialog = true),
                ),

                const SizedBox(height: 10),

                productCard(
                  image: "https://i.ibb.co/T0S06ZP/2.png",
                  title: "Labubu Soymilk",
                  price: price2,
                  qty: qty2,
                  onAdd: () => setState(() => qty2++),
                  onMin: () => setState(() => qty2 = qty2 == 1 ? 1 : qty2 - 1),
                  onDelete: () => setState(() => showDeleteDialog = true),
                ),

                const SizedBox(height: 20),
                const Text(
                  "Metode Pembayaran",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                paymentSelector(),

                const SizedBox(height: 20),
                const Text("Selected accessories",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),

                summaryRow("Hacipupu Cancer", price1),
                summaryRow("Labubu Soymilk", price2),
                summaryRow("Diskon", 0),

                const Divider(),

                summaryRow("Total", total, bold: true),

                const SizedBox(height: 40),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                      child: Text(
                    "Beli Sekarang",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
                ),
              ],
            ),
          ),

          if (showDeleteDialog) deleteDialog()
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // PRODUCT CARD
  // ----------------------------------------------------------
  Widget productCard({
    required String image,
    required String title,
    required int price,
    required int qty,
    required VoidCallback onAdd,
    required VoidCallback onMin,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    quantityButton("-", onMin),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text("$qty",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    quantityButton("+", onAdd),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Text(
                "Rp. ${price.toString().replaceAll(",", ".")},-",
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget quantityButton(String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          shape: BoxShape.circle,
        ),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  // ----------------------------------------------------------
  // PAYMENT SELECTOR
  // ----------------------------------------------------------
  Widget paymentSelector() {
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
                    color:
                        selectedPayment == i ? Colors.white : Colors.black87,
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  // ----------------------------------------------------------
  // SUMMARY ROW
  // ----------------------------------------------------------
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

  // ----------------------------------------------------------
  // DELETE DIALOG
  // ----------------------------------------------------------
  Widget deleteDialog() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 270,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                blurRadius: 8, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Kamu yakin mau menghapus produk ini?",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                deleteButton("Batal", Colors.red, () {
                  setState(() => showDeleteDialog = false);
                }),
                deleteButton("Ya", Colors.green, () {
                  setState(() => showDeleteDialog = false);
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget deleteButton(String text, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
