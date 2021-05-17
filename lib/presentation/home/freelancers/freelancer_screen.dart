import 'package:flutter/material.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/freelancer.dart';
import 'package:freelance_app/presentation/home/freelancers/freelancer_detail/freelancer_detail_screen.dart';
import 'package:freelance_app/presentation/widgets/nav_item.dart';
import 'package:freelance_app/presentation/widgets/rate.dart';
import 'package:get/get.dart';

class FreelancersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Freelancer',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.blue,
        ),
      ),
      body: ListView.builder(
          itemCount: freelancers.length,
          itemBuilder: (context, index) {
            Freelancer freelancer = freelancers[index];
                return ItemFreelancer(
                  avatar: freelancer.avatar,
                  name: freelancer.name,
                  serviceName: freelancer.work,
                  city: freelancer.city,
                  rate: freelancer.rate,
                  money: freelancer.money,
                  skills: freelancer.skills,
                  onTap: (){
                    Get.to(FreelancerDetailScreen(account: Account(),));
                  },
                );
      }),
      backgroundColor: Colors.grey[100],
    );
  }
}

class ItemFreelancer extends StatelessWidget {
  const ItemFreelancer({
    @required this.avatar,
    @required this.name,
    @required this.serviceName,
    @required this.rate,
    @required this.money,
    @required this.skills,
    @required this.onTap,
    @required this.city,
    Key key,
  }) : super(key: key);
  final String avatar;
  final String name;
  final String serviceName;
  final int rate;
  final double money;
  final String city;
  final List<String> skills;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: avatar != null ? AssetImage(avatar) : AssetImage('assets/images/avatarnull.png'),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(city),
                    Text(serviceName),
                    Rate(rate: rate),
                    Text(
                      '$money VNĐ',
                      style: TextStyle(
                          color: Color(0xFF0fe19b),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.keyboard_arrow_right),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 10),
              child: Wrap(
                runSpacing: 5,
                spacing: 5,
                children: List.generate(
                  skills.length,
                  (index) => NavItem(
                    title: skills[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.65),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


