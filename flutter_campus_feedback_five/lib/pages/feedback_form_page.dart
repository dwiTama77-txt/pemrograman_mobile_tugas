import 'package:flutter/material.dart';
import '../models/feedback_model.dart';
import '../services/feedback_service.dart';
import '../widgets/rating_widget.dart';

class FeedbackFormPage extends StatefulWidget {
  final FeedbackService feedbackService;

  const FeedbackFormPage({super.key, required this.feedbackService});

  @override
  State<FeedbackFormPage> createState() => FeedbackFormPageState();
}

class FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _facultyController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  // Facility ratings
  final Map<String, int> _facilityRatings = {};
  final Map<String, int> _serviceRatings = {};

  final List<String> _facilities = [
    'Perpustakaan',
    'Laboratorium',
    'Ruang Kelas',
    'Fasilitas Olahraga',
    'Kantin',
    'Parkir',
    'Wi-Fi Kampus',
    'Toilet',
  ];

  final List<String> _services = [
    'Administrasi Akademik',
    'Layanan IT',
    'Bimbingan Konseling',
    'Layanan Perpustakaan',
    'Layanan Kesehatan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback Kampus'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Information
              _buildSectionHeader('Informasi Mahasiswa'),
              _buildTextField(
                controller: _nameController,
                label: 'Nama Lengkap',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _idController,
                label: 'NIM',
                icon: Icons.badge,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM harus diisi';
                  }
                  return null;
                },
              ),
              _buildTextField(
                controller: _facultyController,
                label: 'Fakultas',
                icon: Icons.school,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Fakultas harus diisi';
                  }
                  return null;
                },
              ),

              // Facility Ratings
              _buildSectionHeader('Rating Fasilitas Kampus'),
              ..._facilities.map((facility) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RatingWidget(
                  label: facility,
                  onRatingChanged: (rating) {
                    setState(() {
                      _facilityRatings[facility] = rating;
                    });
                  },
                  initialRating: _facilityRatings[facility] ?? 0,
                ),
              )),

              // Service Ratings
              _buildSectionHeader('Rating Layanan Kampus'),
              ..._services.map((service) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: RatingWidget(
                  label: service,
                  onRatingChanged: (rating) {
                    setState(() {
                      _serviceRatings[service] = rating;
                    });
                  },
                  initialRating: _serviceRatings[service] ?? 0,
                ),
              )),

              // Comments
              _buildSectionHeader('Komentar & Saran'),
              TextFormField(
                controller: _commentsController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Komentar dan saran',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),

              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'Kirim Feedback',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        validator: validator,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_facilityRatings.isEmpty || _serviceRatings.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harap beri rating untuk semua fasilitas dan layanan'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final feedback = FeedbackModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentName: _nameController.text,
        studentId: _idController.text,
        faculty: _facultyController.text,
        facilityRatings: _facilityRatings,
        serviceRatings: _serviceRatings,
        comments: _commentsController.text,
        timestamp: DateTime.now(),
      );

      widget.feedbackService.addFeedback(feedback);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback berhasil dikirim!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }
}