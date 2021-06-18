import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/profile/review/components/rate_card.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          '4.0',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: 4,
                          size: 50,
                          isReadOnly: true,
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
                        ),
                        Text(
                          'dựa trên 23 nhận xét',
                          style: TEXT_STYLE_FOREIGN,
                        ),
                      ],
                    ),
                  ),
                  bottom: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Đã làm',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Đã huỷ',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Container(
                  padding: EdgeInsets.all(kDefaultPadding),
                    child: ListView.builder(
                        itemCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ReviewCard(rate: 4))),
                Container(
                    padding: EdgeInsets.all(kDefaultPadding),
                    child: ListView.builder(
                        itemCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => ReviewCard(rate: 4))),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
