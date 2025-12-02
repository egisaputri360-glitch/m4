// lib/screens/product_stock_screen.dart
import 'package:flutter/material.dart';

class ProductStockScreen extends StatelessWidget {
  const ProductStockScreen({super.key});

  // Data stok (nanti bisa diganti dari database)
  final List<Map<String, dynamic>> products = const [
    {'name': 'Star core bracelet', 'stock': 34},
    {'name': 'Mermaid core bracelet', 'stock': 20},
    {'name': 'Photo Keychain', 'stock': 25},
    {'name': 'Bag Charm', 'stock': 30},
    {'name': 'PopMart Hacipupu', 'stock': 35},
    {'name': 'PopMart Crybaby', 'stock': 33},
    {'name': 'Gantungan Labubu Soymilk', 'stock': 22},
    {'name': 'Gantungan Labubu Toffee', 'stock': 25},
    {'name': 'Anting-anting Lumidrop', 'stock': 28},
    {'name': 'Anting-anting Starlet', 'stock': 14},
    {'name': 'Anting-anting Butterfly', 'stock': 12},
    {'name': 'Hairclip Starlet', 'stock': 17},
    {'name': 'Hairclip Starlet Rainbow', 'stock': 23},
    {'name': 'Silverbow necklace', 'stock': 21},
    {'name': 'Silverstar necklace', 'stock': 26},
    {'name': 'Blackspider necklace', 'stock': 24},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Produk Stok',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD7E4), // pink persis sama gambar
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade200.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            itemCount: products.length,
            separatorBuilder: (context, index) => const Divider(
              height: 32,
              thickness: 1.2,
              color: Colors.white,
            ),
            itemBuilder: (context, index) {
              final item = products[index];
              return Row(
                children: [
                  // Nama Produk (kiri)
                  Expanded(
                    flex: 7,
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // Garis pemisah tengah
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 40,
                      child: VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                      ),
                    ),
                  ),

                  // Jumlah Stok (kanan)
                  Expanded(
                    flex: 2,
                    child: Text(
                      item['stock'].toString(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}