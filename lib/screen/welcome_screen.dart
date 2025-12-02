// lib/screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart';      // ← pastikan import ini ada
import 'signin_screen.dart'; // ← kalau sudah dibuat, kalau belum bisa di-comment dulu

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // LOGO + LINGKARAN
                Container(
                  width: 240,
                  height: 240,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFF2F2),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_kasir.png',
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // JUDUL MINIMARTIE
                const Text(
                  'MINIMARTIE',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF333333),
                    letterSpacing: 4,
                  ),
                ),

                const SizedBox(height: 50),

                // WELCOME TEXT
                const Text(
                  'Welcome to MiniMartie!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3436),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Kelola jualanmu dengan mudah dan penuh warna bersama MiniMartie, teman lucu untuk setiap transaksi yang manis.',
                    style: TextStyle(
                      fontSize: 15.5,
                      height: 1.6,
                      color: Color(0xFF636E72),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 70),

                // TOMBOL SIGN UP → ke RegisterScreen
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC1CC),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // TOMBOL LOG IN → ke LoginScreen
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE5E5E5),
                      foregroundColor: const Color(0xFF2D3436),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}