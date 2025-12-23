class FeedbackModel {
  final String id;
  final String studentName;
  final String studentId;
  final String faculty;
  final Map<String, int> facilityRatings;
  final Map<String, int> serviceRatings;
  final String comments;
  final DateTime timestamp;

  FeedbackModel({
    required this.id,
    required this.studentName,
    required this.studentId,
    required this.faculty,
    required this.facilityRatings,
    required this.serviceRatings,
    required this.comments,
    required this.timestamp,
  });

  double get overallRating {
    final allRatings = [...facilityRatings.values, ...serviceRatings.values];
    if (allRatings.isEmpty) return 0;
    final total = allRatings.reduce((a, b) => a + b);
    return total / allRatings.length;
  }
}