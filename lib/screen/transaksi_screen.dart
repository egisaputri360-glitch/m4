// lib/screens/transaction_screen.dart
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  // Data dummy (nanti bisa diganti dari Supabase/Firestore)
  final List<Map<String, dynamic>> transactions = const [
    {
      'name': 'Annalise Constance',
      'time': '10:12 AM',
      'status': 'Berhasil',
    },
    {
      'name': 'Aurora Kayden',
      'time': '11:50 AM',
      'status': 'Berhasil',
    },
    {
      'name': 'Hilda Donabella',
      'time': '12:00 AM',
      'status': 'Berhasil',
    },
    {
      'name': 'Kaelia Alyaya',
      'time': '12:11 AM',
      'status': 'Berhasil',
    },
    {
      'name': 'Lily Gabriella',
      'time': '12:21 AM',
      'status': 'Berhasil',
    },
    {
      'name': 'Aurora Ellara',
      'time': '12:30 AM',
      'status': 'Berhasil',
    },
    {
      'name': 'Lily Gabriella',
      'time': '12:21 AM',
      'status': 'Berhasil',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Transaksi',
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
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final item = transactions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD7E4), // pink lembut persis
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade100.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Nama + Jam
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['time'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Badge "Berhasil"
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ADE80), // hijau mint
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Berhasil',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}