import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final String gameId;
  final Function(double) onRatingChanged;
  final double size;
  final Color? starColor;

  const RatingStars({
    required this.rating,
    required this.gameId,
    required this.onRatingChanged,
    this.size = 24,
    this.starColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            onRatingChanged(index + 1.0);
          },
          child: Icon(
            index < rating.floor()
                ? Icons.star
                : index < rating
                    ? Icons.star_half
                    : Icons.star_border,
            size: size,
            color: starColor ?? Theme.of(context).primaryColor,
          ),
        );
      }),
    );
  }
}