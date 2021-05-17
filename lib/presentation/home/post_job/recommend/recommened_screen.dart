import 'package:flutter/material.dart';
import 'package:freelance_app/presentation/home/freelancers/freelancer_detail/freelancer_detail_screen.dart';
import 'package:freelance_app/presentation/home/home_screen.dart';
import 'package:freelance_app/presentation/home/widgets/search_box.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class RecommendScreen extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<RecommendScreen> {
  bool isInvite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đề xuất'),
        actions: [
          TextButton(
            onPressed: () {
              Get.to(HomeScreen());
            },
            child: Text(
              'Done',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text(
                'Freelancer được đề xuất cho dự án của bạn',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20,vertical: 10 ),
                child: SearchBox(),
              ),
              Container(
                child: ListView.builder(itemBuilder: (context, index) {
                  return ItemFreelancerRecommend(
                    avatar: 'assets/images/avatar.jpg',
                    name: 'Nguyễn Nhật Huy',
                    serviceName: 'Lập trình mobile',
                    rate: 5,
                    titleButton: isInvite ? 'Đã mời' : 'Mời',
                    onTap: () {
                      Get.to(FreelancerDetailScreen());
                    },
                    onPress: (){
                      setState(() {
                        isInvite = !isInvite;
                      });
                    },
                  );
                },
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ItemFreelancerRecommend extends StatelessWidget {
  const ItemFreelancerRecommend({
    @required this.avatar,
    @required this.name,
    @required this.serviceName,
    @required this.rate,
    @required this.onTap,
    @required this.onPress,
    @required this.titleButton,
    Key key,
  }) : super(key: key);
  final String avatar;
  final String name;
  final String serviceName;
  final int rate;
  final GestureTapCallback onTap;
  final String titleButton;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(avatar),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(serviceName),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.yellow,
                      ),
                      child: Text(
                        rate.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
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
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(onPressed: onPress, child: Text(titleButton))

          ],
        ),
      ),
    );
  }
}
