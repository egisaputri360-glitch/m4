import 'package:flutter/material.dart';

class PelangganPage extends StatelessWidget {
  const PelangganPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> pelanggan = [
      {
        "nama": "Aretha",
        "telp": "0812341111",
        "image": "https://i.ibb.co/5FSk8bT/anime-girl-1.png"
      },
      {
        "nama": "Karina",
        "telp": "0812342222",
        "image": "https://i.ibb.co/PM6XBn1/anime-girl-2.png"
      },
      {
        "nama": "Angie",
        "telp": "0812343333",
        "image": "https://i.ibb.co/5YHg0yv/anime-girl-3.png"
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(Icons.person_add, color: Colors.pink),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // SEARCH BAR
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
                child: ListView.builder(
                  itemCount: pelanggan.length,
                  itemBuilder: (context, index) {
                    final data = pelanggan[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _customerCard(
                        context: context,
                        name: data["nama"],
                        telp: data["telp"],
                        image: data["image"],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD PELANGGAN ===================
  Widget _customerCard({
    required BuildContext context,
    required String name,
    required String telp,
    required String image,
  }) {
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
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: 15),

          // NAMA PELANGGAN
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // EDIT BUTTON
          InkWell(
            onTap: () {
              showEditPelanggan(
                context,
                imageUrl: image,
                nama: name,
                telp: telp,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, size: 18, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// ================== POPUP EDIT PELANGGAN =================
// =========================================================

void showEditPelanggan(
  BuildContext context, {
  required String imageUrl,
  required String nama,
  required String telp,
}) {
  TextEditingController namaC = TextEditingController(text: nama);
  TextEditingController telpC = TextEditingController(text: telp);

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.2),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Pelanggan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(imageUrl),
                ),

                const SizedBox(height: 20),

                _pinkInput(controller: namaC, hint: "Nama :"),

                const SizedBox(height: 15),

                _pinkInput(controller: telpC, hint: "No Telp :"),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 130,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade300,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          offset: const Offset(0, 4),
                          color: Colors.black.withOpacity(0.2),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Simpan",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

// ======================= INPUT FIELD PINK =======================
Widget _pinkInput({
  required TextEditingController controller,
  required String hint,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.pink.shade200,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 4,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
  );
}
