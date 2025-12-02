// lib/screens/splash_page.dart  (atau tetap di file kamu sekarang)
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _nextPage();
  }

  Future<void> _nextPage() async {
    // 2–3 detik aja biar kelihatan splash-nya (bisa diganti 2 atau 3)
    await Future.delayed(const Duration(seconds: 3));

    final session = Supabase.instance.client.auth.currentSession;

    if (!mounted) return;

    if (session != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF888485), // abu-abu sesuai desain kamu
      body: SafeArea(
        child: Center(
          child: Container(
            width: 340,
            height: 640,
            decoration: BoxDecoration(
              color: const Color(0xFFF2D8DB), // pink card
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LOGO BUNDAR LANGSUNG (tanpa lapisan lagi)
                Container(
                  width: 230,
                  height: 230,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF7E6E6), // cream lembut
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0), // biar ada sedikit ruang di pinggir
                      child: Image.asset(
                        'images/logo_kasir.png', // pastikan path-nya benar
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Teks MINIMARTIE
                const Text(
                  'MINIMARTIE',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 5,
                    color: Color(0xFFD9A79F),
                    // fontFamily: 'Georgia', // uncomment kalau sudah ada font-nya
                  ),
                ),

                const SizedBox(height: 80), // biar nggak nempel ke bawah

                // Optional: loading kecil biar kelihatan hidup
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Color(0xFFD9A79F)),
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}