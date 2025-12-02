// lib/screens/kasir_screen.dart → HALAMAN KASIR CANTIK + TAMBAH/KURANG + KERANJANG OTOMATIS
import 'package:flutter/material.dart';

class KasirScreen extends StatefulWidget {
  const KasirScreen({super.key});

  @override
  State<KasirScreen> createState() => _KasirScreenState();
}

class _KasirScreenState extends State<KasirScreen> {
  String selectedCategory = 'Semua';
  int cartCount = 0;

  final List<Map<String, dynamic>> allProducts = [
    // POPMART
    {'image': 'assets/products/labubu.png', 'name': 'Labubu Soymilk', 'price': 245000, 'category': 'Popmart'},
    {'image': 'assets/products/hacipupu_aries.png', 'name': 'Hacipupu Aries', 'price': 200000, 'category': 'Popmart'},
    {'image': 'assets/products/hacipupu_cancer.png', 'name': 'Hacipupu Cancer', 'price': 199000, 'category': 'Popmart'},
    {'image': 'assets/products/hacipupu_leo.png', 'name': 'Hacipupu Leo', 'price': 244000, 'category': 'Popmart'},
    {'image': 'assets/products/hacipupu_gemini.png', 'name': 'Hacipupu Gemini', 'price': 220000, 'category': 'Popmart'},

    // BRACELET
    {'image': 'assets/products/bracelet_blacklove.png', 'name': 'Bracelet Blacklove', 'price': 25000, 'category': 'Bracelet'},
    {'image': 'assets/products/bracelet_butterfly.png', 'name': 'Bracelet Butterfly', 'price': 34000, 'category': 'Bracelet'},
    {'image': 'assets/products/bracelet_straw.png', 'name': 'Bracelet Straw', 'price': 45000, 'category': 'Bracelet'},
    {'image': 'assets/products/bracelet_flowers.png', 'name': 'Bracelet Flowers', 'price': 30000, 'category': 'Bracelet'},

    // HAIRCLIP
    {'image': 'assets/products/hairclip_cherry.png', 'name': 'Hairclip Cherry', 'price': 25000, 'category': 'Hairclip'},
    {'image': 'assets/products/hairclip_flowers.png', 'name': 'Hairclip Flowers', 'price': 32000, 'category': 'Hairclip'},
    {'image': 'assets/products/hairclip_starlet.png', 'name': 'Hairclip Starlet', 'price': 24000, 'category': 'Hairclip'},
    {'image': 'assets/products/hairclip_straw.png', 'name': 'Hairclip Straw', 'price': 33000, 'category': 'Hairclip'},

    // LAINNYA
    {'image': 'assets/products/necklace.png', 'name': 'Blackspider Necklace', 'price': 55000, 'category': 'Necklace'},
    {'image': 'assets/products/keychain.png', 'name': 'Photo Keychain', 'price': 65000, 'category': 'Keychain'},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'Semua') return allProducts;
    return allProducts.where((p) => p['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.menu, color: Colors.black54), onPressed: () {}),
        title: const Text('Kasir', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 30),
                onPressed: () {},
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text(cartCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search, color: Colors.black54),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),

          // KATEGORI
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _categoryChip('Semua'),
                _categoryChip('Popmart'),
                _categoryChip('Bracelet'),
                _categoryChip('Hairclip'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // GRID PRODUK KASIR
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.78,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (_, i) {
                final p = filteredProducts[i];
                return _kasirCard(p);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoryChip(String label) {
    bool active = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        label: Text(label, style: TextStyle(fontWeight: active ? FontWeight.bold : FontWeight.w600)),
        selected: active,
        onSelected: (_) => setState(() => selectedCategory = label),
        selectedColor: const Color(0xFFFFD6E8),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: BorderSide(color: active ? const Color(0xFFFF8A9B) : Colors.transparent, width: 2),
      ),
    );
  }

  Widget _kasirCard(Map<String, dynamic> p) {
    int qty = 0;

    return StatefulBuilder(
      builder: (context, setCardState) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(p['image'], height: 100, width: 100, fit: BoxFit.cover),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  p['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'Rp ${p['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},-',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              const SizedBox(height: 12),

              // TOMBOL + 0 -
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _qtyButton(Icons.remove_circle_outline, () {
                    if (qty > 0) {
                      setCardState(() => qty--);
                      if (qty == 0) cartCount = (cartCount > 0) ? cartCount - 1 : 0;
                      setState(() {});
                    }
                  }),
                  Container(
                    width: 36,
                    alignment: Alignment.center,
                    child: Text(qty.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  _qtyButton(Icons.add_circle_outline, () {
                    setCardState(() => qty++);
                    if (qty == 1) setState(() => cartCount++);
                  }),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 28, color: const Color(0xFFFF8A9B)),
      ),
    );
  }
}