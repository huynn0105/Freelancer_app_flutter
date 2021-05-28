import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/header.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/review.dart';
import 'package:get/get.dart';

import 'capacity_profile/add_capacity_profile.dart';
import 'capacity_profile/capacity_profiles_screen.dart';
import 'capacity_profile/components/capacity.dart';

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
                  Padding(
                    padding: const EdgeInsets.only(bottom: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hồ sơ năng lực',
                              style: TEXT_STYLE_PRIMARY,
                              overflow: TextOverflow.fade,
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                if(controllerHome.capacityProfiles.isEmpty)
                                   controllerHome.getCapacityProfiles(user.id);
                                Get.to(() => CapacityProfilesScreen(controller: controllerHome,));
                              },
                              child:user.capacityProfiles.isNotEmpty
                                  ? Text('Xem tất cả')
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        user.capacityProfiles.isNotEmpty
                            ? Capacity(
                            capacityProfiles: user.capacityProfiles,
                          onTap: (){
                            if(controllerHome.capacityProfiles.isEmpty)
                               controllerHome.getCapacityProfiles(user.id);
                            Get.to(() => CapacityProfilesScreen(controller: controllerHome,));
                          },
                        )
                            : Center(child: Icon(Icons.error_outline),),
                        Center(
                          child: TextButton(
                            child: Text('Thêm hồ sơ'),
                            onPressed: () {
                              Get.to(() => AddCapacityProfile());
                            },
                          ),
                        ),
                      ],
                    ),
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
