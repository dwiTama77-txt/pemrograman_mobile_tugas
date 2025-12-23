import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final int rating;
  final Function(int) onRatingChanged;

  const RatingStar({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return GestureDetector(
          onTap: () => onRatingChanged(starIndex),
          child: AnimatedScale(
            scale: starIndex == rating ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.star,
              size: 32,
              color: starIndex <= rating ? Colors.amber : Colors.grey.shade400,
            ),
          ),
        );
      }),
    );
  }
}
