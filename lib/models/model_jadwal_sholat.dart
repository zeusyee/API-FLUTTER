class ModelJadwalSholat {
  final String subuh;
  final String terbit;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;
  final String tanggal;
  final String tanggalHijriah;

  ModelJadwalSholat({
    required this.subuh,
    required this.terbit,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.tanggal,
    required this.tanggalHijriah,
  });

  factory ModelJadwalSholat.fromJson(Map<String, dynamic> json) {
    final waktuSholat = json['data']['timings'];
    final tanggal = json['data']['date'];
    
    return ModelJadwalSholat(
      subuh: waktuSholat['Fajr'],
      terbit: waktuSholat['Sunrise'],
      dzuhur: waktuSholat['Dhuhr'],
      ashar: waktuSholat['Asr'],
      maghrib: waktuSholat['Maghrib'],
      isya: waktuSholat['Isha'],
      tanggal: tanggal['readable'],
      tanggalHijriah: '${tanggal['hijri']['day']} ${tanggal['hijri']['month']['en']} ${tanggal['hijri']['year']}',
    );
  }
}