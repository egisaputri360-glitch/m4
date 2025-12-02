// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:krpl/providers/auth_provider.dart';
import 'package:krpl/screen/customer_screen.dart';
import 'package:krpl/screen/login_screen.dart';
import 'package:krpl/screen/produk_stok_screen.dart';
import 'package:krpl/screen/transaksi_screen.dart';          // penting buat logout

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authServiceProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black54),
          onPressed: () {},
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // CARD PROFIL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD6E7),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: const AssetImage('assets/images/profil_kasir.png'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ajeng nabila', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                      Text('Admin', style: TextStyle(color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                  const Spacer(),
                  const Column(
                    children: [
                      Text('300', style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                      Text('Pelanggan', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // MENU UTAMA
            _menuItem(context, Icons.dashboard, 'Dashboard', isActive: true),
            _menuItem(context, Icons.inventory_2_outlined, 'Produk', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductStockScreen()));
            }),
            _menuItem(context, Icons.point_of_sale, 'Kasir'), // nanti diganti kalau sudah ada halaman Kasir
            _menuItem(context, Icons.people_alt_outlined, 'Pelanggan', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerScreen()));
            }),
            _menuItem(context, Icons.bar_chart, 'Laporan'),
            _menuItem(context, Icons.inventory, 'Stok', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductStockScreen()));
            }),
            _menuItem(context, Icons.receipt_long, 'Transaksi', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionScreen()));
            }),
            _menuItem(context, Icons.logout, 'Keluar', textColor: Colors.red.shade400, onTap: () async {
              await auth.logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false,
                );
              }
            }),

            const SizedBox(height: 30),

            // GRAFIK PLACEHOLDER
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 20)],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.trending_up, size: 60, color: Color(0xFFFF8A9B)),
                    SizedBox(height: 12),
                    Text('Grafik Penjualan Mingguan', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                    Text('coming soon', style: TextStyle(color: Color(0xFFFF8A9B), fontSize: 15)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // WIDGET MENU ITEM
  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title, {
    bool isActive = false,
    Color? textColor,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : const Color(0xFFFFD6E7),
            borderRadius: BorderRadius.circular(30),
            border: isActive ? Border.all(color: const Color(0xFFFF8A9B), width: 3) : null,
            boxShadow: isActive
                ? [BoxShadow(color: Colors.pink.shade200.withOpacity(0.4), blurRadius: 12)]
                : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: isActive ? const Color(0xFFFF8A9B) : Colors.black54, size: 26),
              const SizedBox(width: 18),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                  color: textColor ?? (isActive ? const Color(0xFFFF8A9B) : Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}