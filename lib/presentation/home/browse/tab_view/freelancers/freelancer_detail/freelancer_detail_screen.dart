import 'package:flutter/material.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/home/browse/tab_view/freelancers/rating/rating_screen.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profiles_screen.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/components/capacity.dart';
import 'package:freelance_app/presentation/home/profile/profile_screen.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/header.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/review.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import 'freelancer_detail_controller.dart';

class FreelancerDetailScreen extends StatelessWidget {
  final int freelancerId;

  FreelancerDetailScreen({@required this.freelancerId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<FreelancerDetailController>(
        FreelancerDetailController(
            apiRepositoryInterface: Get.find(), freelancerId: freelancerId));
    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ Sơ'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Báo cáo freelancer',
                    )
                  ],
                ),
                value: "/newchat",
                textStyle: TextStyle(color: Colors.red),
              ),
            ],
            onSelected: (route) {
              print(route);
              // Note You must create respective pages for navigation
              // Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.progressState.value == sState.initial) {
          var freelancer = controller.freelancer.value;
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Header(
                    avatarUrl: freelancer.avatarUrl,
                    name: freelancer.name,
                    tile: freelancer.title,
                    level: freelancer.level,
                  ),
                  Information(
                    email: freelancer.email,
                    contract: freelancer.website,
                    phoneNumber: freelancer.phone,
                  ),
                  Divider(color: Colors.grey),
                  Earn(),
                  Divider(color: Colors.grey),
                  About(description: freelancer.description,name: freelancer.name,),
                  Divider(
                    thickness: kDefaultPadding/2,
                    color: Colors.grey[300],
                  ),
                  freelancer.freelancerSkills != null
                          ? Skills(
                              skillsList: freelancer.freelancerSkills,
                            )
                      : const SizedBox.shrink(),
                  Divider(
                    thickness: kDefaultPadding/2,
                    color: Colors.grey[300],
                  ),
                  freelancer.freelancerServices != null
                          ? Services(
                              freelancerServices: freelancer.freelancerServices,
                            )
                      : const SizedBox.shrink(),
                  Divider(
                    thickness: kDefaultPadding/2,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding/2),
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
                                if(controller.capacityProfiles.isEmpty)
                                controller.getCapacityProfiles(freelancerId);
                                Get.to(() => CapacityProfilesScreen(controller: controller,));
                              },
                              child:freelancer.capacityProfiles.isNotEmpty
                                  ? Text('Xem tất cả')
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        freelancer.capacityProfiles.isNotEmpty
                            ? Capacity(
                            capacityProfiles: freelancer.capacityProfiles,
                          onTap: (){
                            if(controller.capacityProfiles.isEmpty)
                               controller.getCapacityProfiles(freelancerId);
                            Get.to(() => CapacityProfilesScreen(controller: controller,));
                          },
                        )
                            : Text('Chưa có hồ sơ nào!'),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: kDefaultPadding/2,
                    color: Colors.grey[300],
                  ),
                  Review(
                    rate: me.rate,
                    totalMoney: freelancer.balance,
                    totalVote: 3,
                    workValue: 99,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
        } else if (controller.progressState.value == sState.failure) {
          const Center(
            child: Icon(
              Icons.error_outline,
              size: 50,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return RatingScreen(freelancer: controller.freelancer.value,);
              });
        },
        label: Text('Mời làm'),
      ),
    );
  }
}
