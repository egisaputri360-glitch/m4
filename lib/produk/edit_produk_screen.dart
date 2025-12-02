
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final int index;
  final Function(Map<String, dynamic>, int) onUpdateProduct;

  const EditProductScreen({
    super.key,
    required this.product,
    required this.index,
    required this.onUpdateProduct,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late String _selectedCategory;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Popmart', 'Bracelet', 'Hairclip', 'Necklace', 'Keychain'
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product['name']);
    _priceController = TextEditingController(text: widget.product['price'].toString());
    _stockController = TextEditingController(text: widget.product['stock'].toString());
    _selectedCategory = widget.product['category'];
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
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
        title: const Text(
          'Edit Produk',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // GAMBAR PRODUK + TOMBOL GANTI
            Row(
              children: [
                // Gambar produk
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.pink.shade100, blurRadius: 12, offset: const Offset(0, 6)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _imageFile != null
                        ? Image.file(_imageFile!, fit: BoxFit.cover)
                        : (widget.product['image'].startsWith('assets/')
                            ? Image.asset(widget.product['image'], fit: BoxFit.cover)
                            : Image.file(File(widget.product['image']), fit: BoxFit.cover)),
                  ),
                ),
                const SizedBox(width: 16),

                // Tombol Perbarui Gambar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Perbarui Gambar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: const Icon(Icons.camera_alt, size: 20),
                        label: const Text('Pilih Foto'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // NAMA
            _buildTextField('Nama :', _nameController),
            const SizedBox(height: 20),

            // HARGA
            _buildTextField('Harga :', _priceController, keyboardType: TextInputType.number),
            const SizedBox(height: 20),

            // STOK
            _buildTextField('Stok :', _stockController, keyboardType: TextInputType.number),
            const SizedBox(height: 50),

            // TOMBOL SIMPAN
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty &&
                    _stockController.text.isNotEmpty) {
                  final updatedProduct = {
                    'image': _imageFile?.path ?? widget.product['image'],
                    'name': _nameController.text,
                    'price': int.tryParse(_priceController.text) ?? 0,
                    'stock': int.tryParse(_stockController.text) ?? 0,
                    'category': _selectedCategory,
                  };

                  widget.onUpdateProduct(updatedProduct, widget.index);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Produk berhasil diperbarui!'), backgroundColor: Colors.green),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF8A9B),
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 18),
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