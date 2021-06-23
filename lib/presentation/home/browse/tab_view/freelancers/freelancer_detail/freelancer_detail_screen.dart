import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profiles_screen.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/components/capacity.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/components/capacity_card.dart';
import 'package:freelance_app/presentation/home/profile/profile_screen.dart';
import 'package:freelance_app/presentation/home/profile/review/reviews_screen.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/header.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/review.dart';
import 'package:get/get.dart';
import 'package:freelance_app/constant.dart';
import '../../../../../../domain/models/account.dart';
import '../../../../home_controller.dart';
import '../../../../messages/chat_controller.dart';
import '../../../../messages/messages_screen.dart';
import 'freelancer_detail_controller.dart';

class FreelancerDetailScreen extends StatelessWidget {
  final Account freelancer;

  FreelancerDetailScreen({@required this.freelancer});
  final homeController = Get.find<HomeController>();
  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<FreelancerDetailController>(
        FreelancerDetailController(apiRepositoryInterface: Get.find(), freelancerId: freelancer.id));

    return Scaffold(
      appBar: AppBar(
        title: Text('Hồ Sơ'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext bc) =>
            [
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
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Information(
                    email: freelancer.email,
                    contract: freelancer.website,
                    phoneNumber: freelancer.phone,
                  ),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Earn(balance: freelancer.earning,),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  About(description: freelancer.description,
                    name: freelancer.name,),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  freelancer.freelancerSkills != null
                      ? Skills(
                    skillsList: freelancer.freelancerSkills,
                  )
                      : const SizedBox.shrink(),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  freelancer.freelancerServices != null
                      ? Services(
                    freelancerServices: freelancer.freelancerServices,
                  )
                      : const SizedBox.shrink(),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
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
                                controller.getCapacityProfiles(freelancer.id).then((value) => Get.to(() => CapacityProfilesScreen(capacityProfiles: controller.capacityProfiles,)));

                              },
                              child: freelancer.capacityProfiles.isNotEmpty
                                  ? Text('Xem tất cả')
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        freelancer.capacityProfiles.isNotEmpty
                            ? Capacity(
                          capacityProfiles: freelancer.capacityProfiles,
                          onTap: () {
                            if (controller.capacityProfiles.isEmpty)
                              controller.getCapacityProfiles(freelancer.id);
                            Get.to(() => CapacityProfilesScreen());
                          },
                        )
                            : Text('Chưa có hồ sơ nào!'),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Review(
                    avg: freelancer.totalRating.avg,
                    totalVote: freelancer.totalRating.count,
                    onTap: (){
                      homeController.loadRatingFormId(freelancer.id).then((value) => Get.to(()=>ReviewsScreen(totalRating: freelancer.totalRating,)));
                    },
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
      floatingActionButton: buildSpeedDial(),
    );
  }

  Widget buildSpeedDial() {
    return Obx(
      ()=> SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        icon: Icons.add,
        activeIcon: Icons.remove,
        buttonSize: 56.0,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        label: Text('Mời làm'),
        overlayOpacity: 0.5,
        onOpen: (){
          homeController.loadJobsRenter(2);
        },
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        gradientBoxShape: BoxShape.circle,
        children: List.generate(homeController.jobsRenter[2].length, (index){
          var job = homeController.jobsRenter[2][index];
          return SpeedDialChild(
          label: job.name,
          labelStyle: TextStyle(fontSize: 18.0),
          child: Icon(Icons.work_outlined),
          onTap: (){
            chatController.loadJob(job.id).then((value)
            =>   chatController.loadMessageChat(job.id, freelancer.id).then((value){
              chatController.currentStep(0);
                Get.to(()=>MessagesScreen(toUser: freelancer,freelancer: freelancer,job: job,));
            }));


          }

        );}
      )
      ),
    );
  }
}


