import 'package:flutter/material.dart';
import '../models/model_jadwal_sholat.dart';
import '../services/layanan_jadwal_sholat.dart';
import '../widgets/kartu_waktu_sholat.dart';

class LayarJadwalSholat extends StatefulWidget {
  @override
  _LayarJadwalSholatState createState() => _LayarJadwalSholatState();
}

class _LayarJadwalSholatState extends State<LayarJadwalSholat> {
  final LayananJadwalSholat _layanan = LayananJadwalSholat();
  ModelJadwalSholat? _jadwalSholat;
  bool _sedangMemuat = true;
  String? _pesanKesalahan;

  @override
  void initState() {
    super.initState();
    _muatJadwalSholat();
  }

  Future<void> _muatJadwalSholat() async {
    try {
      setState(() {
        _sedangMemuat = true;
        _pesanKesalahan = null;
      });

      final jadwalSholat = await _layanan.ambilJadwalSholat();
      
      setState(() {
        _jadwalSholat = jadwalSholat;
        _sedangMemuat = false;
      });
    } catch (e) {
      setState(() {
        _pesanKesalahan = e.toString();
        _sedangMemuat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Jadwal Sholat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[700],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _muatJadwalSholat,
          ),
        ],
      ),
      body: _bangunKonten(),
    );
  }

  Widget _bangunKonten() {
    if (_sedangMemuat) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.green[700]),
            SizedBox(height: 16),
            Text(
              'Sedang memuat jadwal sholat...',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_pesanKesalahan != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[400],
            ),
            SizedBox(height: 16),
            Text(
              'Terjadi kesalahan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            SizedBox(height: 8),
            Text(
              _pesanKesalahan!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _muatJadwalSholat,
              child: Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _muatJadwalSholat,
      color: Colors.green[700],
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bangunKartuLokasi(),
            SizedBox(height: 16),
            _bangunKartuTanggal(),
            SizedBox(height: 16),
            _bangunGridJadwalSholat(),
          ],
        ),
      ),
    );
  }

  Widget _bangunKartuLokasi() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.green[600]!, Colors.green[800]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yogyakarta, Indonesia',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Lintang: -7.8014, Bujur: 110.3644',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunKartuTanggal() {
    if (_jadwalSholat == null) return SizedBox.shrink();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.green[700], size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _jadwalSholat!.tanggal,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    _jadwalSholat!.tanggalHijriah,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bangunGridJadwalSholat() {
    if (_jadwalSholat == null) return SizedBox.shrink();

    final daftarSholat = [
      {'nama': 'Subuh', 'waktu': _jadwalSholat!.subuh, 'ikon': Icons.brightness_2},
      {'nama': 'Terbit', 'waktu': _jadwalSholat!.terbit, 'ikon': Icons.wb_sunny},
      {'nama': 'Dzuhur', 'waktu': _jadwalSholat!.dzuhur, 'ikon': Icons.wb_sunny_outlined},
      {'nama': 'Ashar', 'waktu': _jadwalSholat!.ashar, 'ikon': Icons.brightness_6},
      {'nama': 'Maghrib', 'waktu': _jadwalSholat!.maghrib, 'ikon': Icons.brightness_3},
      {'nama': 'Isya', 'waktu': _jadwalSholat!.isya, 'ikon': Icons.brightness_2_outlined},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Waktu Sholat Hari Ini',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
          ),
          itemCount: daftarSholat.length,
          itemBuilder: (context, index) {
            final sholat = daftarSholat[index];
            return KartuWaktuSholat(
              nama: sholat['nama'] as String,
              waktu: sholat['waktu'] as String,
              ikon: sholat['ikon'] as IconData,
            );
          },
        ),
      ],
    );
  }
}