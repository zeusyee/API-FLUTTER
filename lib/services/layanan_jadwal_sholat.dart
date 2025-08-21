import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_jadwal_sholat.dart';

class LayananJadwalSholat {
  static const String urlDasar = 'https://api.aladhan.com/v1/timings';
  static const double lintang = -7.8014;
  static const double bujur = 110.3644;
  static const int metode = 2; // Islamic Society of North America

  Future<ModelJadwalSholat> ambilJadwalSholat() async {
    try {
      final respons = await http.get(
        Uri.parse('$urlDasar?latitude=$lintang&longitude=$bujur&method=$metode'),
      );

      if (respons.statusCode == 200) {
        final dataJson = json.decode(respons.body);
        return ModelJadwalSholat.fromJson(dataJson);
      } else {
        throw Exception('Gagal memuat jadwal sholat');
      }
    } catch (e) {
      throw Exception('Kesalahan: $e');
    }
  }
}