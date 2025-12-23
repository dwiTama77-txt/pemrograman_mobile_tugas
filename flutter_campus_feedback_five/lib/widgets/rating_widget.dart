import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  final String label;
  final ValueChanged<int> onRatingChanged;
  final int initialRating;

  const RatingWidget({
    super.key,
    required this.label,
    required this.onRatingChanged,
    this.initialRating = 0,
  });

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            final rating = index + 1;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentRating = rating;
                });
                widget.onRatingChanged(rating);
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: rating <= _currentRating
                      ? _getColorForRating(rating)
                      : Colors.grey[200],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: rating <= _currentRating
                        ? _getColorForRating(rating)
                        : Colors.grey[400]!,
                  ),
                ),
                child: Center(
                  child: Text(
                    rating.toString(),
                    style: TextStyle(
                      color: rating <= _currentRating
                          ? Colors.white
                          : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(
          _getRatingText(_currentRating),
          style: TextStyle(
            color: _getColorForRating(_currentRating),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getColorForRating(int rating) {
    switch (rating) {
      case 1: return Colors.red;
      case 2: return Colors.orange;
      case 3: return Colors.yellow[700]!;
      case 4: return Colors.lightGreen;
      case 5: return Colors.green;
      default: return Colors.grey;
    }
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1: return 'Sangat Tidak Puas';
      case 2: return 'Tidak Puas';
      case 3: return 'Cukup';
      case 4: return 'Puas';
      case 5: return 'Sangat Puas';
      default: return 'Pilih Rating';
    }
  }
}