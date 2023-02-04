import 'package:company_finder_app/models/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as ratingBar;
import '../models/rating.dart';

class RatingBar extends StatefulWidget {

  RatingCompany? rating;

  RatingBar({this.rating});

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ratingBar.RatingBar.builder(
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            widget.rating!.rate = rating;
          });
        },
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      ),
    );
  }
}
