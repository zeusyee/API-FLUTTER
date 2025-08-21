import 'package:flutter/material.dart';

class KartuWaktuSholat extends StatelessWidget {
  final String nama;
  final String waktu;
  final IconData ikon;

  const KartuWaktuSholat({
    Key? key,
    required this.nama,
    required this.waktu,
    required this.ikon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              ikon,
              size: 32,
              color: Colors.green[700],
            ),
            SizedBox(height: 8),
            Text(
              nama,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 4),
            Text(
              waktu,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}