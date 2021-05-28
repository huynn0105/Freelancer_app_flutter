import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key key,
    @required this.rate,
  }) : super(key: key);

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.grey.shade300,
                child: CachedNetworkImage(
                  imageUrl: 'https://www.thebalancesmb.com/thmb/6gflK8z4FzPq6JwDNWIGJzlA9w8=/4086x2298/smart/filters:no_upscale()/no-cost-online-business-58a6434c3df78c345bae15ae.jpg',
                  httpHeaders: {
                    HttpHeaders.authorizationHeader:
                    'Bearer $TOKEN'
                  },
                  placeholder: (context, url) =>
                      CupertinoActivityIndicator(),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 20,
                  ),
                  errorWidget: (context, url, error) =>
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage(
                            'assets/images/avatarnull.png'),
                        radius: 20,
                      ),
                ),
              ),
              SizedBox(width: kDefaultPadding/2,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nguyễn Nhật Huy',style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 17),),
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
              ),
              Spacer(),
              Text('1 ngày trước',style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.8)),),
            ],
          ),
          SizedBox(height: kDefaultPadding/4,),
          ExpandableText("The Centrifuge Option 1 Sale has not yet started. When it starts (at 17:00 UTC May 26), you will be assigned a random place in line alongside everyone else who arrived before the start and in front of those who arrive at or after the start.",
            style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.7)),
            expandText: 'ẩn bớt',
            collapseText: 'xem thêm',
            maxLines: 2,
          )
        ],
      ),
    );
  }
}