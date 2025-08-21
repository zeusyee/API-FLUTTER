import 'package:flutter/material.dart';
import 'screens/layar_jadwal_sholat.dart';

void main() {
  runApp(AplikasiSaya());
}

class AplikasiSaya extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal Sholat',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LayarJadwalSholat(),
      debugShowCheckedModeBanner: false,
    );
  }
}