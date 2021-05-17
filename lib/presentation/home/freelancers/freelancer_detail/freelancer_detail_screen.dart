import 'package:flutter/material.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/avatar.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/record.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/summary.dart';
import 'package:get/get.dart';

class FreelancerDetailScreen extends StatelessWidget {
  final Account account;
  FreelancerDetailScreen({this.account});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Hồ Sơ'),
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext bc) =>
              [
                PopupMenuItem(child: Row(children: [
                  Icon(Icons.flag_outlined, color: Colors.red,),
                  SizedBox(width: 5,),
                  Text('Report user',)
                ],),
                  value: "/newchat",
                  textStyle: TextStyle(color: Colors.red),),
              ],
              onSelected: (route) {
                print(route);
                // Note You must create respective pages for navigation
                // Navigator.pushNamed(context, route);
              },
            ),
          ] ,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 10,),
                Avatar(url: 'assets/images/avatarnull.jpg',),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'account.name',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  me.work,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black54,
                    ),
                    SizedBox(height: 10),
                    Text(
                      me.city,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Information(
                  email: account.email,
                  contract: 'me.contract',
                  phoneNumber: account.phone,
                ),
                SizedBox(height: 15),
                About(
                  description: 'me.description',
                ),
                SizedBox(height: 15),
                // Skills(
                //   skillsList: me.skills,
                // ),
                SizedBox(height: 15),
                Service(
                  servicesList: me.services,
                ),
                SizedBox(height: 15),
                Record(),
                SizedBox(height: 15),
                Summary(
                  rate: me.rate,
                  totalMoney: me.money,
                  totalVote: 3,
                  workValue: 99,
                ),
                SizedBox(height: 100,),

              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {}, label: Text('Mời làm'),)
    );
  }
}
















