import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/c_profile.dart';
import 'package:freelance_app/presentation/home/widgets/header.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/review.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final controllerHome = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var user = controllerHome.account.value;
      return Scaffold(
          appBar: AppBar(
            title: Text(
              'Hồ Sơ',
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  Header(
                    avatarUrl: user.avatarUrl,
                    name: user.name,
                    tile: user.tile,
                    level: user.level,
                  ),
                  Information(
                    email: user.email,
                    contract: user.website,
                    phoneNumber: user.phone,
                  ),
                  user.description != null
                      ? About(
                          description: '${user.description}',
                        )
                      : const SizedBox.shrink(),
                  Skills(
                    skillsList: controllerHome.account.value.freelancerSkills,
                  ),
                  Services(
                    freelancerServices: user.freelancerServices,
                  ),
                  CProfile(
                    capacityProfiles: user.capacityProfiles,
                  ),
                  Review(
                    rate: me.rate,
                    totalMoney: user.balance,
                    totalVote: 3,
                    workValue: 99,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(
                () => EditProfileScreen(account: user),
              );
            },
            child: Icon(
              Icons.edit,
            ),
          ));
    });
  }
}
