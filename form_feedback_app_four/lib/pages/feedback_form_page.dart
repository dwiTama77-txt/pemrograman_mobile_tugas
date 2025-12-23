import 'package:flutter/material.dart';
import '../widgets/rating_star.dart';

class FeedbackFormPage extends StatefulWidget {
  const FeedbackFormPage({super.key});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _comment = '';
  int _rating = 0;

  // Kirim feedback ke halaman hasil
  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        '/result',
        arguments: {
          'name': _name,
          'comment': _comment,
          'rating': _rating,
        },
      );
    }
  }

  // Reset semua input form
  void _resetForm() {
    setState(() {
      _name = '';
      _comment = '';
      _rating = 0;
    });
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('Form Feedback'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert), // Titik tiga di kanan atas
            onSelected: (value) {
              if (value == 'reset') {
                _resetForm();
              } else if (value == 'about') {
                showAboutDialog(
                  context: context,
                  applicationName: 'Form Feedback App',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(Icons.feedback, color: Colors.deepPurple),
                  children: const [
                    Text(
                      'Aplikasi ini dibuat untuk mengumpulkan masukan pengguna '
                          'melalui nama, komentar, dan rating bintang.\n\n'
                          'Dikembangkan dengan Flutter dan desain profesional elegan.',
                    ),
                  ],
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.refresh, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text('Bersihkan Form'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'about',
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.deepPurple),
                    SizedBox(width: 8),
                    Text('Tentang Aplikasi'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Berikan Feedback Anda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nama
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (val) => setState(() => _name = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'Nama wajib diisi' : null,
                  ),
                  const SizedBox(height: 20),

                  // Komentar
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Komentar',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.comment),
                    ),
                    maxLines: 3,
                    onChanged: (val) => setState(() => _comment = val),
                    validator: (val) =>
                    val == null || val.isEmpty ? 'Komentar wajib diisi' : null,
                  ),
                  const SizedBox(height: 20),

                  // Rating + emot kecil
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rating:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RatingStar(
                              rating: _rating,
                              onRatingChanged: (rating) {
                                setState(() => _rating = rating);
                              },
                            ),
                          ),
                          const SizedBox(width: 6),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) =>
                                ScaleTransition(scale: anim, child: child),
                            child: _rating == 0
                                ? const SizedBox(width: 32, height: 32)
                                : Column(
                              key: ValueKey<int>(_rating),
                              children: [
                                Text(
                                  _getEmoji(_rating),
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: _getEmojiColor(_rating),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getRatingText(_rating),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _getEmojiColor(_rating),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol Kirim
                  ElevatedButton(
                    onPressed: _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Kirim Feedback',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Fungsi tambahan untuk emoji dan teks rating
  String _getEmoji(int rating) {
    switch (rating) {
      case 1:
        return '😡';
      case 2:
        return '😞';
      case 3:
        return '😐';
      case 4:
        return '😊';
      case 5:
        return '🤩';
      default:
        return '';
    }
  }

  Color _getEmojiColor(int rating) {
    switch (rating) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Sangat Buruk';
      case 2:
        return 'Buruk';
      case 3:
        return 'Biasa Saja';
      case 4:
        return 'Baik';
      case 5:
        return 'Sangat Baik';
      default:
        return '';
    }
  }
}
