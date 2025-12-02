// lib/screens/product_list_screen.dart → FINAL + POPUP HAPUS + SUDAH DI-FIX ERROR!
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String selectedCategory = 'Hairclip';
  int? deletingIndex;

  // HAPUS "const" DI SINI BIAR BISA DI-EDIT/HAPUS!
  List<Map<String, dynamic>> allProducts = [
    {'image': 'assets/products/hacipupu_aries.png',  'name': 'Hacipupu Aries',    'price': 200000, 'stock': 12, 'category': 'Popmart'},
    {'image': 'assets/products/labubu.png',         'name': 'Labubu Soymilk',    'price': 245000, 'stock': 15, 'category': 'Popmart'},

    {'image': 'assets/products/bracelet_blacklove.png', 'name': 'Bracelet Blacklove', 'price': 25000, 'stock': 22, 'category': 'Bracelet'},
    {'image': 'assets/products/bracelet_butterfly.png', 'name': 'Bracelet Butterfly', 'price': 34000, 'stock': 12, 'category': 'Bracelet'},
    {'image': 'assets/products/bracelet_straw.png',     'name': 'Bracelet Straw',     'price': 45000, 'stock': 2,  'category': 'Bracelet'},

    {'image': 'assets/products/hairclip_cherry.png',    'name': 'Hairclip Cherry',    'price': 25000, 'stock': 10, 'category': 'Hairclip'},
    {'image': 'assets/products/hairclip_flowers.png',  'name': 'Hairclip Flowers',   'price': 32000, 'stock': 11, 'category': 'Hairclip'},
    {'image': 'assets/products/hairclip_starlet.png',  'name': 'Hairclip Starlet',   'price': 24000, 'stock': 15, 'category': 'Hairclip'},
    {'image': 'assets/products/hairclip_straw.png',    'name': 'Hairclip Straw',     'price': 33000, 'stock': 14, 'category': 'Hairclip'},

    {'image': 'assets/products/necklace.png',  'name': 'Blackspider Necklace', 'price': 55000, 'stock': 10, 'category': 'Necklace'},
    {'image': 'assets/products/keychain.png',  'name': 'Photo Keychain',       'price': 65000, 'stock': 15, 'category': 'Keychain'},
  ];

  List<Map<String, dynamic>> get filteredProducts {
    if (selectedCategory == 'Semua') return allProducts;
    return allProducts.where((p) => p['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black54),
        actions: [
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.notifications_outlined, size: 28), onPressed: () {}),
              Positioned(right: 9, top: 9, child: Container(width: 9, height: 9, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
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

          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _categoryButton('Semua',     'assets/categories/all.png'),
                _categoryButton('Popmart',   'assets/categories/popmart.png'),
                _categoryButton('Bracelet',  'assets/categories/bracelet.png'),
                _categoryButton('Hairclip',  'assets/categories/hairclip.png'),
                _categoryButton('Keychain',  'assets/categories/keychain.png'),
                _categoryButton('Necklace',  'assets/categories/necklace.png'),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Stack(
              children: [
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.76,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, i) {
                    final p = filteredProducts[i];
                    if (p['category'] == 'Popmart') {
                      return _popmartCard(p, i);
                    } else {
                      return _accessoryCard(p, i);
                    }
                  },
                ),

                if (deletingIndex != null)
                  _deleteConfirmationDialog(filteredProducts[deletingIndex!]),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF8A9B),
        child: const Icon(Icons.add, size: 32),
        onPressed: () {},
      ),
    );
  }

  Widget _categoryButton(String label, String icon) {
    bool active = selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => setState(() => selectedCategory = label),
        child: Column(
          children: [
            Container(
              width: 66, height: 66,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? const Color(0xFFFFD6E8) : Colors.white,
                border: Border.all(color: active ? const Color(0xFFFF8A9B) : const Color(0xFFE5E5E5), width: active ? 3.5 : 2),
                image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 14, fontWeight: active ? FontWeight.bold : FontWeight.w600, color: active ? const Color(0xFFFF8A9B) : Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _popmartCard(Map<String, dynamic> p, int index) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(26), border: Border.all(color: const Color(0xFFE5E5E5))),
      child: Column(children: [
        const SizedBox(height: 20),
        CircleAvatar(radius: 58, backgroundColor: Colors.white, child: ClipOval(child: Image.asset(p['image'], width: 110, height: 110, fit: BoxFit.cover))),
        const SizedBox(height: 16),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(p['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis)),
        const SizedBox(height: 6),
        Text('Rp ${p['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},-', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Stok: ${p['stock']}', style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(width: 20),
          const Icon(Icons.edit_outlined, size: 20),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => setState(() => deletingIndex = index),
            child: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
          ),
        ]),
        const SizedBox(height: 10),
      ]),
    );
  }

  Widget _accessoryCard(Map<String, dynamic> p, int index) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE5E5E5), width: 1)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(p['image'], height: 130, width: 130, fit: BoxFit.cover))),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(p['name'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 6),
            Text('Rp ${p['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},-', style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            Row(children: [
              Text('Stok: ${p['stock']}', style: const TextStyle(color: Colors.black54, fontSize: 13)),
              const Spacer(),
              const Icon(Icons.edit_outlined, size: 20, color: Colors.black54),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => setState(() => deletingIndex = index),
                child: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
              ),
            ]),
          ]),
        ),
        const SizedBox(height: 12),
      ]),
    );
  }

  // POPUP HAPUS – SUDAH DIPERBAIKI BIAR BISA HAPUS DARI allProducts!
  Widget _deleteConfirmationDialog(Map<String, dynamic> product) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD6E8),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(product['image'], height: 130, width: 130, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Text(product['name'], style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              Text('Rp ${product['price'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')},-', style: const TextStyle(fontSize: 16, color: Colors.black54)),
              const SizedBox(height: 20),
              const Text('Kamu yakin mau menghapus produk ini?', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setState(() => deletingIndex = null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Batal', style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        allProducts.removeAt(deletingIndex!);  // INI YANG DIPERBAIKI!
                        deletingIndex = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Produk berhasil dihapus!'), backgroundColor: Colors.green),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Ya', style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}