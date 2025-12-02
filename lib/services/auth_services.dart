import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // LOGIN
  Future<AuthResponse> login(String email, String password) async {
    final result = await _supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
    return result;
  }

  // REGISTER
  Future<AuthResponse> register(String email, String password, {required String phone}) async {
    final result = await _supabase.auth.signUp(
      email: email.trim(),
      password: password.trim(),
      // emailRedirectTo: null --> opsional, boleh dihapus
    );
    return result;
  }

  // LOGOUT
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
