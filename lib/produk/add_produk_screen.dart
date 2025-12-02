// lib/screens/add_product_screen.dart → VERSI FINAL + BISA UPLOAD GAMBAR!
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddProduct;

  const AddProductScreen({super.key, required this.onAddProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  String _selectedCategory = 'Bracelet';

  File? _imageFile; // simpan gambar yang dipilih
  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Popmart', 'Bracelet', 'Hairclip', 'Necklace', 'Keychain'
  ];

  // FUNGSI PILIH GAMBAR DARI GALERI
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Tambah Produk Baru', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        centerTitle: true,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black54), onPressed: () => Navigator.pop(context)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // KOTAK GAMBAR (bisa diklik untuk upload)
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 12, offset: const Offset(0, 6))],
                ),
                child: _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.file(_imageFile!, fit: BoxFit.cover),
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 50, color: Colors.pink),
                          SizedBox(height: 8),
                          Text('Ketuk untuk tambah gambar', style: TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 40),

            _buildTextField('Nama :', _nameController),
            const SizedBox(height: 20),

            // Dropdown Jenis
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD6E8),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 8, offset: const Offset(0, 4))],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  dropdownColor: const Color(0xFFFFF0F5),
                  borderRadius: BorderRadius.circular(20),
                  items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                  onChanged: (value) => setState(() => _selectedCategory = value!),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildTextField('Harga :', _priceController, keyboardType: TextInputType.number),
            const SizedBox(height: 20),

            _buildTextField('Stok :', _stockController, keyboardType: TextInputType.number),
            const SizedBox(height: 50),

            // TOMBOL SIMPAN
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    _stockController.text.isNotEmpty &&
                    _imageFile != null) {
                  final newProduct = {
                    'image': _imageFile!.path, // simpan path gambar
                    'name': _nameController.text,
                    'price': int.tryParse(_priceController.text) ?? 0,
                    'stock': int.tryParse(_stockController.text) ?? 0,
                    'category': _selectedCategory,
                  };

                  widget.onAddProduct(newProduct);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lengkapi semua data & pilih gambar!'), backgroundColor: Colors.red),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A9B),
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 10,
              ),
              child: const Text('Simpan', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD6E8),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}