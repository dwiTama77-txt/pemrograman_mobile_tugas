import 'package:flutter/material.dart';
import '../models/dosen.dart';

class DosenCard extends StatelessWidget {
  final Dosen dosen;
  final VoidCallback onTap;

  const DosenCard({super.key, required this.dosen, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Foto profil
              CircleAvatar(
                backgroundImage: AssetImage(dosen.foto),
                radius: 50,
              ),
              const SizedBox(height: 12),

              // Nama dosen
              Text(
                dosen.nama,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),

              // Bidang Keahlian
              Text(
                dosen.keahlian,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

              // Email
              Text(
                dosen.email,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 12),

              // Tombol "Lihat Detail"
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A237E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                child: const Text(
                  "Lihat Detail",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
