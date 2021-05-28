import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/profile/review/components/rate_card.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đánh giá'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('4.0',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
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
              Text('dựa trên 23 nhận xét',style: TEXT_STYLE_FOREIGN,),
              SizedBox(height: kDefaultPadding/2,),
              Divider(color: Colors.grey,),
              SizedBox(height: kDefaultPadding,),
              ListView.builder(
                itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index)=>ReviewCard(rate: 4))
            ],
          ),
        ),
      ),
    );
  }
}
