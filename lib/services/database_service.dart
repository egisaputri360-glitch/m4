import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final _db = Supabase.instance.client;

  // GET semua data (read)
  Future<List<Map<String, dynamic>>> getData() async {
    final response = await _db.from('students').select();
    return response;
  }

  // INSERT data
  Future<void> insertData(Map<String, dynamic> data) async {
    await _db.from('students').insert(data);
  }

  // UPDATE data berdasarkan id
  Future<void> updateData(int id, Map<String, dynamic> data) async {
    await _db.from('students').update(data).eq('id', id);
  }

  // DELETE data berdasarkan id
  Future<void> deleteData(int id) async {
    await _db.from('students').delete().eq('id', id);
  }
}
