// lib/screens/dashboard_screen.dart → DASHBOARD CANTIK + GANTI HALAMAN OTOMATIS!
import 'package:flutter/material.dart';
import 'package:krpl/produk/produk_list_screen.dart';
// import 'kasir_screen.dart';     // nanti kalau sudah dibuat
// import 'pelanggan_screen.dart';
// import 'laporan_screen.dart';
// import 'stok_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // DAFTAR HALAMAN YANG AKAN DITAMPILKAN DI KANAN
  static const List<Widget> _pages = [
    DashboardContent(),        // 0 - Dashboard (grafik)
    ProductListScreen(),       // 1 - Produk ← SUDAH ADA & LANGSUNG JALAN!
    Center(child: Text('Halaman Kasir (segera hadir!)', style: TextStyle(fontSize: 24))),
    Center(child: Text('Halaman Pelanggan', style: TextStyle(fontSize: 24))),
    Center(child: Text('Halaman Laporan', style: TextStyle(fontSize: 24))),
    Center(child: Text('Halaman Stok', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: Row(
        children: [
          // === SIDEBAR KIRI ===
          Container(
            width: 280,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFFFFD6E8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                // PROFILE
                Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundImage: const AssetImage('assets/avatar/ajeng.png'),
                      child: Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 4))),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Ajeng nabila', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Admin', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),

                // MENU OTOMATIS GANTI HALAMAN
                _menuItem(icon: Icons.dashboard, label: 'Dashboard', index: 0),
                _menuItem(icon: Icons.inventory_2, label: 'Produk', index: 1),
                _menuItem(icon: Icons.point_of_sale, label: 'Kasir', index: 2),
                _menuItem(icon: Icons.people, label: 'Pelanggan', index: 3),
                _menuItem(icon: Icons.bar_chart, label: 'Laporan', index: 4),
                _menuItem(icon: Icons.storage, label: 'Stok', index: 5),
                const Spacer(),
                _menuItem(icon: Icons.logout, label: 'Keluar', index: 6, isLogout: true),
              ],
            ),
          ),

          // === KONTEN UTAMA (OTOMATIS GANTI SESUAI MENU) ===
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required int index,
    bool isLogout = false,
  }) {
    bool selected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          setState(() => _selectedIndex = index);

          if (isLogout) {
            // Nanti tambahin logout logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Berhasil keluar!')),
            );
          }
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: selected ? [BoxShadow(color: Colors.pink.shade200, blurRadius: 10)] : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected ? const Color(0xFFFF8A9B) : Colors.black54,
                size: 28,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w600,
                  color: selected ? const Color(0xFFFF8A9B) : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// HALAMAN DASHBOARD UTAMA (yang ada grafik)
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Dashboard', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 10)],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.person_outline, size: 32),
                    SizedBox(width: 12),
                    Text('00 Pelanggan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/chart_placeholder.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Senin'), Text('Selasa'), Text('Rabu'), Text('Kamis'),
                      Text('Jumat'), Text('Sabtu'), Text('Minggu'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}