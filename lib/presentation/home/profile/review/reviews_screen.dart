import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/total_rating.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/review/components/rate_card.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsScreen extends StatelessWidget {

  final TotalRating totalRating;
  ReviewsScreen({this.totalRating});
  @override
  Widget build(BuildContext context) {
    final controller= Get.find<HomeController>();
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 220.0,
                  title: Text('Đánh giá'),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${totalRating.avg}',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: totalRating.avg,
                          size: 50,
                          isReadOnly: true,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                        ),
                        Text(
                          'dựa trên ${totalRating.count} nhận xét',
                          style: TEXT_STYLE_FOREIGN,
                        ),
                      ],
                    ),
                  ),
                  // bottom: TabBar(
                  //   tabs: [
                  //     Tab(
                  //       child: Text(
                  //         'Đã làm',
                  //         style: TextStyle(fontSize: 18),
                  //       ),
                  //     ),
                  //     Tab(
                  //       child: Text(
                  //         'Đã huỷ',
                  //         style: TextStyle(fontSize: 18),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
              ];
            },
            body: Container(
                padding: EdgeInsets.all(kDefaultPadding),
                child: ListView.builder(
                    itemCount: controller.ratings.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      final rating = controller.ratings[index];
                      return ReviewCard(star: rating.star,comment: rating.comment,renter: rating.renter);
    })),

            // TabBarView(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(kDefaultPadding),
            //         child: ListView.builder(
            //             itemCount: 3,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemBuilder: (context, index) => ReviewCard(rate: 5))),
            //     Container(
            //         padding: EdgeInsets.all(kDefaultPadding),
            //         child: ListView.builder(
            //             itemCount: 3,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemBuilder: (context, index) => ReviewCard(rate: 4))),
            //   ],
            // ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}
