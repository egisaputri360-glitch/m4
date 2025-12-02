import 'package:flutter/material.dart';

class PelangganPage extends StatelessWidget {
  const PelangganPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5), // abu muda seperti desain
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // JUDUL + TOMBOL TAMBAH
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pelanggan",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Tombol Tambah
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.person_add, color: Colors.pink),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SEARCH BOX
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search...",
                    icon: Icon(Icons.search),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // LIST PELANGGAN
              Expanded(
                child: ListView(
                  children: [
                    _customerCard(
                      name: "Aretha",
                      image: "https://i.ibb.co/5FSk8bT/anime-girl-1.png",
                    ),
                    const SizedBox(height: 12),
                    _customerCard(
                      name: "Karina",
                      image: "https://i.ibb.co/PM6XBn1/anime-girl-2.png",
                    ),
                    const SizedBox(height: 12),
                    _customerCard(
                      name: "Angie",
                      image: "https://i.ibb.co/5YHg0yv/anime-girl-3.png",
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ========================= CARD PELANGGAN =============================
  Widget _customerCard({required String name, required String image}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.pink.shade200,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // FOTO PROFIL BULAT
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: 15),

          // NAMA
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // ICON EDIT
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.edit,
              size: 18,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
