import 'package:flutter/material.dart';
import '../models/feedback_model.dart';

class FeedbackService with ChangeNotifier {
  final List<FeedbackModel> _feedbacks = [];

  List<FeedbackModel> get feedbacks => _feedbacks;

  void addFeedback(FeedbackModel feedback) {
    _feedbacks.add(feedback);
    notifyListeners();
  }

  Map<String, double> getFacilityAverages() {
    if (_feedbacks.isEmpty) return {};

    final Map<String, double> totals = {};
    final Map<String, int> counts = {};

    for (final feedback in _feedbacks) {
      feedback.facilityRatings.forEach((facility, rating) {
        totals.update(facility, (value) => value + rating.toDouble(), ifAbsent: () => rating.toDouble());
        counts.update(facility, (value) => value + 1, ifAbsent: () => 1);
      });
    }

    return totals.map((key, value) => MapEntry(key, value / counts[key]!));
  }

  Map<String, double> getServiceAverages() {
    if (_feedbacks.isEmpty) return {};

    final Map<String, double> totals = {};
    final Map<String, int> counts = {};

    for (final feedback in _feedbacks) {
      feedback.serviceRatings.forEach((service, rating) {
        totals.update(service, (value) => value + rating.toDouble(), ifAbsent: () => rating.toDouble());
        counts.update(service, (value) => value + 1, ifAbsent: () => 1);
      });
    }

    return totals.map((key, value) => MapEntry(key, value / counts[key]!));
  }

  double getOverallAverage() {
    if (_feedbacks.isEmpty) return 0;
    final total = _feedbacks.map((f) => f.overallRating).reduce((a, b) => a + b);
    return total / _feedbacks.length;
  }
}