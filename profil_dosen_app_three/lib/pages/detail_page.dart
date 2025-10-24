import 'package:flutter/material.dart';
import '../models/dosen.dart';

class DetailPage extends StatelessWidget {
  final Dosen dosen;

  const DetailPage({super.key, required this.dosen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A237E), // biru tua
              Color(0xFF3949AB), // biru sedang
              Color(0xFFE8EAF6), // biru muda lembut
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Foto profil dengan Hero animation + shadow lembut
                Hero(
                  tag: dosen.nama,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(dosen.foto),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Nama dosen
                Text(
                  dosen.nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Kartu detail dengan efek shadow lembut
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 370),
                  child: Card(
                    color: Colors.white.withOpacity(0.9),
                    shadowColor: Colors.blueAccent.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoRow(Icons.badge, "NIP", dosen.nip),
                          const Divider(thickness: 1, height: 20),
                          _buildInfoRow(Icons.school, "Fakultas", dosen.fakultas),
                          const Divider(thickness: 1, height: 20),
                          _buildInfoRow(Icons.work, "Posisi", dosen.posisi),
                          const Divider(thickness: 1, height: 20),
                          _buildInfoRow(Icons.lightbulb, "Bidang Keahlian", dosen.keahlian),
                          const Divider(thickness: 1, height: 20),
                          _buildInfoRow(Icons.email, "Email", dosen.email),

                          const SizedBox(height: 20),
                          const Text(
                            "Quote / Motto",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Quote box lembut
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.indigo.shade100,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.format_quote,
                                    color: Colors.indigo),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '"${dosen.motto}"',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Tombol kembali
                SizedBox(
                  width: 180,
                  height: 45,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_back,
                        color: Color(0xFF1A237E)),
                    label: const Text(
                      'Kembali',
                      style: TextStyle(
                        color: Color(0xFF1A237E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Widget pembantu untuk baris info dengan ikon
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.indigo, size: 22),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
