import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile/pages/deteksi.dart';
import 'package:mobile/pages/profile.dart';

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF829991),
        elevation: 0,
        title: Text(
          'RESTCOUNT',
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.white
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(

        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TombolKustom(
              ikon: Icons.search,
              label: 'Deteksi Kendaraan',
              onPressed: () {
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => CameraView())
                );
              },
            ),
            SizedBox(height: 16.0),
            TombolKustom(
              ikon: Icons.person,
              label: 'Profile',
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => ProfileScreen())
                );
              },
            ),
            SizedBox(height: 16.0),
            TombolKustom(
              ikon: Icons.settings,
              label: 'Pengaturan Akun',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class TombolKustom extends StatelessWidget {
  final IconData ikon;
  final String label;
  final VoidCallback onPressed;

  TombolKustom({
    required this.ikon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF819A8F),
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            ikon,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
