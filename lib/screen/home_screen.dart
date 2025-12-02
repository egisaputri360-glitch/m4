import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F3), // pink pastel persis
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black54),
          onPressed: () {},
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black54),
            onPressed: () {},
          ),
        ],
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
                color: const Color(0xFFFFD1DC),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/profil_kasir.png'), // ganti foto Ajeng di sini
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ajeng nabila', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('Admin', style: TextStyle(color: Colors.black54, fontSize: 15)),
                    ],
                  ),
                  const Spacer(),
                  const Column(
                    children: [
                      Text('200', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      Text('Pelanggan', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // MENU UTAMA (kapsul pink)
            _menuItem(context, Icons.dashboard, 'Dashboard', isActive: true),
            _menuItem(context, Icons.inventory_2_outlined, 'Produk'),
            _menuItem(context, Icons.point_of_sale, 'Kasir'),
            _menuItem(context, Icons.people_alt_outlined, 'Pelanggan'),
            _menuItem(context, Icons.bar_chart, 'Laporan'),
            _menuItem(context, Icons.inventory_outlined, 'Stok'),
            _menuItem(context, Icons.logout, 'Keluar', textColor: Colors.red.shade400, iconColor: Colors.red.shade400),

            const SizedBox(height: 32),

            // GRAFIK (placeholder cantik)
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.pink.shade100.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8)),
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.trending_up, size: 50, color: Colors.pink),
                    SizedBox(height: 12),
                    Text('Grafik Penjualan Mingguan', style: TextStyle(fontSize: 16, color: Colors.pink)),
                    Text('coming soon ♡', style: TextStyle(color: Colors.pinkAccent)),
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

  Widget _menuItem(BuildContext context, IconData icon, String title,
      {bool isActive = false, Color? textColor, Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : const Color(0xFFFFD1DC),
          borderRadius: BorderRadius.circular(30),
          border: isActive ? Border.all(color: const Color(0xFFFF8A9B), width: 2.5) : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? (isActive ? const Color(0xFFFF8A9B) : Colors.black54)),
            const SizedBox(width: 16),
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
    );
  }
}