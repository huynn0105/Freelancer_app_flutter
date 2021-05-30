import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/profile/review/components/rate_card.dart';
import 'package:freelance_app/presentation/home/profile/review/reviews_screen.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Review extends StatelessWidget {
  const Review({
    Key key,
    this.totalMoney,
    this.totalVote,
    this.workValue,
    this.rate,
  }) : super(key: key);
  final int totalVote;
  final double totalMoney;
  final double workValue;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
          children: [
            Text('Tóm lượt', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Spacer(),
            TextButton(onPressed: ()=>Get.to(()=>ReviewsScreen()), child: Text('Xem tất cả'))
          ],
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('4.0',style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 35),),
              SizedBox(width: kDefaultPadding,),
              SmoothStarRating(
                allowHalfRating: false,
                onRated: (v) {},
                starCount: 5,
                rating: rate.toDouble(),
                size: 40,
                isReadOnly: true,
                color: Colors.yellow,
                borderColor: Colors.yellow,
              ),
            ],
          ),
          Divider(),

          Text('Việc hoàn thành',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
          SizedBox(height: 5,),
          ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)=>ReviewCard(rate: rate)),
          Text('Việc đã hủy',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17)),
          SizedBox(height: 5,),
          ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index)=>ReviewCard(rate: rate)),
        ],

      ),
    );
  }
}

