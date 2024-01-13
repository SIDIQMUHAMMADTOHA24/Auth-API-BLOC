import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static String mainUrl = 'https://reqres.in';
  var loginUrl = '$mainUrl/api/login';
  var registerUrl = '$mainUrl/api/register';

  ///```flutter_secure_storage adalah sebuah paket dalam Flutter yang menyediakan API untuk menyimpan data dalam penyimpanan yang aman1. Fungsi utamanya adalah untuk menyimpan data-data sensitif seperti token akses, username, password, dan lainnya dalam format enkripsi```
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  ///```Metode ini memeriksa apakah token pengguna ada di penyimpanan atau tidak.```
  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  ///```Metode ini menyimpan token pengguna ke dalam penyimpanan.```
  Future<void> persisToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  ///```Metode ini menghapus token pengguna dari penyimpanan.```
  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }

  Future<void> persistEmail(String email) async {
    await storage.write(key: 'email', value: email);
  }

  // Mengambil email pengguna
  Future<String> getEmail() async {
    var value = await storage.read(key: 'email');
    return value ?? '';
  }

  ///```Metode ini mengirim permintaan POST ke API untuk login dan mengembalikan token pengguna.```
  Future<String> login(String email, String password) async {
    Response response =
        await _dio.post(loginUrl, data: {"email": email, "password": password});
    await persistEmail(email);
    return response.data['token'];
  }

  Future<String> register(String email, String password) async {
    Response response = await _dio
        .post(registerUrl, data: {"email": email, "password": password});
    await persistEmail(email);
    return response.data['token'];
  }
}
