import 'package:flutter/material.dart';
import '../models/dosen.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Dosen> daftarDosen = [
    Dosen(
      foto: "assets/images/dosen1.jpg",
      nama: "Dr. Ahmad Fauzi, M.Kom",
      nip: "19780422 200112 1 001",
      fakultas: "Fakultas Sains dan Teknologi",
      keahlian: "Kecerdasan Buatan",
      posisi: "Dosen Tetap",
      email: "ahmad.fauzi@kampus.ac.id",
      motto: "Belajar bukan untuk nilai, tapi untuk ilmu.",
    ),
    Dosen(
      foto: "assets/images/dosen2.jpg",
      nama: "Dr. Febi Rahmawati, M.T",
      nip: "19800510 200501 2 002",
      fakultas: "Fakultas Sains dan Teknologi",
      keahlian: "Rekayasa Perangkat Lunak",
      posisi: "Dosen Luar Biasa",
      email: "febi.rahmawati@kampus.ac.id",
      motto: "Teknologi hanyalah alat, kreativitas adalah kuncinya.",
    ),
    Dosen(
      foto: "assets/images/dosen3.jpg",
      nama: "Ir. Budi Santoso, M.Sc",
      nip: "19770218 200212 1 003",
      fakultas: "Fakultas Sains dan Teknologi",
      keahlian: "Jaringan Komputer",
      posisi: "Dosen Tetap",
      email: "budi.santoso@kampus.ac.id",
      motto: "Data berbicara lebih jujur dari opini manusia.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A237E),
        title: const Text(
          "Daftar Dosen",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: daftarDosen.length,
          itemBuilder: (context, index) {
            final dosen = daftarDosen[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Hero(
                  tag: dosen.nama,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(dosen.foto),
                    radius: 30,
                  ),
                ),
                title: Text(
                  dosen.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                subtitle: Text(
                  dosen.keahlian,
                  style: const TextStyle(color: Colors.black54),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.indigo, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => DetailPage(dosen: dosen),
                      transitionsBuilder: (_, animation, __, child) =>
                          FadeTransition(opacity: animation, child: child),
                      transitionDuration:
                      const Duration(milliseconds: 400),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
