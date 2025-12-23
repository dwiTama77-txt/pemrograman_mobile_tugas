import 'package:flutter/material.dart';
import 'feedback_form_page.dart';
import '../widgets/facility_card.dart';
import '../services/feedback_service.dart';
import '../models/feedback_model.dart';

class HomePage extends StatelessWidget {
  final FeedbackService feedbackService;

  const HomePage({super.key, required this.feedbackService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Campus Feedback',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[700]!, Colors.purple[700]!],
                  ),
                ),
                child: const Icon(
                  Icons.school,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Stats - Gunakan AnimatedBuilder untuk mendengarkan perubahan
                  _buildStatsSection(),
                  const SizedBox(height: 24),

                  // Quick Actions
                  Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.feedback,
                          title: 'Beri Feedback',
                          color: Colors.blue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackFormPage(
                                  feedbackService: feedbackService,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.analytics,
                          title: 'Lihat Hasil',
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackResultsPage(
                                  feedbackService: feedbackService,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Facility Ratings Preview - Gunakan AnimatedBuilder
                  _buildFacilityRatingsPreview(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk stats section yang reactive
  Widget _buildStatsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[50]!, Colors.purple[50]!],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  // Listen to changes in feedback count dengan AnimatedBuilder
                  AnimatedBuilder(
                    animation: feedbackService,
                    builder: (context, child) {
                      return Text(
                        '${feedbackService.feedbacks.length}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      );
                    },
                  ),
                  Text(
                    'Total Feedback',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Listen to changes in overall average dengan AnimatedBuilder
                  AnimatedBuilder(
                    animation: feedbackService,
                    builder: (context, child) {
                      final overallAverage = feedbackService.getOverallAverage();
                      return Text(
                        overallAverage.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: _getRatingColor(overallAverage),
                        ),
                      );
                    },
                  ),
                  Text(
                    'Rating Rata-rata',
                    style: TextStyle(
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

  // Widget untuk facility ratings preview yang reactive
  Widget _buildFacilityRatingsPreview() {
    return AnimatedBuilder(
      animation: feedbackService,
      builder: (context, child) {
        final facilityAverages = feedbackService.getFacilityAverages();

        if (facilityAverages.isEmpty) {
          return const SizedBox(); // Return empty if no data
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating Fasilitas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: facilityAverages.entries
                  .map((entry) => FacilityCard(
                title: entry.key,
                rating: entry.value,
                color: Colors.blue,
              ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color.withAlpha(51), color.withAlpha(26)],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4) return Colors.green;
    if (rating >= 3) return Colors.orange;
    return Colors.red;
  }
}

// Class FeedbackResultsPage - Pastikan juga reactive
class FeedbackResultsPage extends StatelessWidget {
  final FeedbackService feedbackService;

  const FeedbackResultsPage({super.key, required this.feedbackService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Feedback'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: feedbackService,
        builder: (context, child) {
          final facilityAverages = feedbackService.getFacilityAverages();
          final serviceAverages = feedbackService.getServiceAverages();
          final overallAverage = feedbackService.getOverallAverage();

          if (feedbackService.feedbacks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada data feedback',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overall Rating
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green[50]!, Colors.blue[50]!],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Rating Keseluruhan',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          overallAverage.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: _getRatingColor(overallAverage),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _buildStars(overallAverage),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Berdasarkan ${feedbackService.feedbacks.length} feedback',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Facility Ratings
                if (facilityAverages.isNotEmpty) ...[
                  Text(
                    'Rating Fasilitas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: facilityAverages.entries
                        .map((entry) => FacilityCard(
                      title: entry.key,
                      rating: entry.value,
                      color: Colors.blue,
                    ))
                        .toList(),
                  ),
                ],

                const SizedBox(height: 24),

                // Service Ratings
                if (serviceAverages.isNotEmpty) ...[
                  Text(
                    'Rating Layanan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: serviceAverages.entries
                        .map((entry) => FacilityCard(
                      title: entry.key,
                      rating: entry.value,
                      color: Colors.green,
                    ))
                        .toList(),
                  ),
                ],

                const SizedBox(height: 24),

                // Feedback List
                Text(
                  'Daftar Feedback Terbaru',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16),
                ...feedbackService.feedbacks.reversed.take(5).map((feedback) =>
                    _buildFeedbackItem(feedback)
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedbackItem(FeedbackModel feedback) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  feedback.studentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Chip(
                  label: Text(
                    feedback.overallRating.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: _getRatingColor(feedback.overallRating),
                ),
              ],
            ),
            Text(
              '${feedback.studentId} - ${feedback.faculty}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            if (feedback.comments.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                feedback.comments,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              '${feedback.timestamp.day}/${feedback.timestamp.month}/${feedback.timestamp.year}',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStars(double rating) {
    return List.generate(5, (index) {
      return Icon(
        index < rating ? Icons.star : Icons.star_border,
        color: _getRatingColor(rating),
        size: 24,
      );
    });
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4) return Colors.green;
    if (rating >= 3) return Colors.orange;
    return Colors.red;
  }
}