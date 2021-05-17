import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Rate extends StatelessWidget {
  const Rate({
    Key key,
    @required this.rate,
  }) : super(key: key);

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 7,vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.yellow,
          ),
          child: Text(
            rate.toString(),
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {},
          starCount: 5,
          rating: rate.toDouble(),
          size: 20,
          isReadOnly: true,
          color: Colors.yellow,
          borderColor: Colors.yellow,
        ),
      ],
    );
  }
}