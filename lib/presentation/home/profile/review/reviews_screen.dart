import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/total_rating.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/review/components/rate_card.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../../responsive.dart';

class ReviewsScreen extends StatelessWidget {
  final TotalRating totalRating;

  ReviewsScreen({this.totalRating});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(title: Text('Đánh giá'),),
              body: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        totalRating.avg.toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SmoothStarRating(
                        allowHalfRating: false,
                        onRated: (v) {},
                        starCount: 5,
                        rating: double.parse(totalRating.avg.toStringAsFixed(2)),
                        size: 50,
                        isReadOnly: true,
                        color: Colors.yellow,
                        borderColor: Colors.yellow,
                      ),
                      Text(
                        'dựa trên ${totalRating.count} nhận xét',
                        style: TEXT_STYLE_FOREIGN,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  Obx(
                    () => controller.ratings.isNotEmpty
                        ? ListView.builder(
                            itemCount: controller.ratings.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final rating = controller.ratings[index];
                              return ReviewCard(rating: rating);
                            })
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ],
              ),


      ));
  }
}
