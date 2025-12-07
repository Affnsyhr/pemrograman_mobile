import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/location_model.dart';

class ApiService {
  static const String _baseURL =
      'https://692e6ee091e00bafccd3d946.mockapi.io/locations/Kelas'; //Ganti Dengan URL MOCKAPI KELAS

  // GET : Ambil daftar tempat makan
  Future<List<LocationModel>> getLocations() async {
    final response = await http.get(Uri.parse(_baseURL));

    if (response.statusCode == 200) {
      List<dynamic> jsonlist = json.decode(response.body);
      return jsonlist.map((json) => LocationModel.fromJson(json)).toList();
    } else {
      throw Exception('Gagal Mengambil data Kuliner');
    }
  }

  // POST: Kirim rekomendasi baru
  Future<bool> addLocation(LocationModel model) async {
    final response = await http.post(
      Uri.parse(_baseURL),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(model.toJson()),
    );

    return response.statusCode == 201;
  }
}
