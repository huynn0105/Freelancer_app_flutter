import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/rating.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required this.rating,

  }) : super(key: key);

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0,right: 0,bottom: 10,top: 0),
      elevation: 2,
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl: 'http://${rating.avatarRenter}',
                    httpHeaders: {
                      HttpHeaders.authorizationHeader:
                      'Bearer $TOKEN'
                    },
                    placeholder: (context, url) =>
                        CupertinoActivityIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 18,
                    ),
                    errorWidget: (context, url, error) =>
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage(
                              'assets/images/avatarnull.png'),
                          radius: 18,
                        ),
                  ),
                ),
                SizedBox(width: kDefaultPadding/2,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(rating.renter.name,style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 15),),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRated: (v) {},
                      starCount: 5,
                      rating: rating.star.toDouble(),
                      size: 20,
                      isReadOnly: true,
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding/4,),
            Text(rating.job.name,
              style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 18,color: Colors.teal,),
              overflow: TextOverflow.ellipsis,),
            SizedBox(height: kDefaultPadding/4,),
            ExpandableText("${rating.comment}",
              style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.7)),
              expandText: 'ẩn bớt',
              collapseText: 'xem thêm',
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}