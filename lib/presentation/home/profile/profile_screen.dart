import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/home/widgets/about.dart';
import 'package:freelance_app/presentation/home/widgets/avatar.dart';
import 'package:freelance_app/presentation/home/widgets/information.dart';
import 'package:freelance_app/presentation/home/widgets/service.dart';
import 'package:freelance_app/presentation/home/widgets/skills.dart';
import 'package:freelance_app/presentation/home/widgets/review.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
            actions: [
              IconButton(icon: Icon(Icons.logout), onPressed: logout)
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Obx(() => Avatar(
                        url: controllerHome.imageURL.value != ''
                            ? controllerHome.imageURL.value
                            : user.avatarUrl,
                        onTap: getImage,
                      )),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  user.tile != null
                      ? Text(
                          user.tile,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        )
                      : const SizedBox.shrink(),
                  user.level != null
                      ? Text(
                          user.level.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: kDefaultPadding,
                  ),
                  Information(
                    email: user.email,
                    contract: user.website,
                    phoneNumber: user.phone,
                  ),
                  Divider(color: Colors.grey),
                  OnReady(),
                  Divider(color: Colors.grey),
                  Earn(),
                  Divider(color: Colors.grey),
                  About(
                    description: user.description,
                    name: user.name,
                  ),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Skills(
                    skillsList: controllerHome.account.value.freelancerSkills,
                  ),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Services(
                    freelancerServices: user.freelancerServices,
                  ),
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
                                if (controllerHome.capacityProfiles.isEmpty)
                                  controllerHome.getCapacityProfiles(user.id);
                                Get.to(() => CapacityProfilesScreen(
                                      controller: controllerHome,
                                    ));
                              },
                              child: user.capacityProfiles.isNotEmpty
                                  ? Text('Xem tất cả')
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        user.capacityProfiles.isNotEmpty
                            ? Capacity(
                                capacityProfiles: user.capacityProfiles,
                                onTap: () {
                                  if (controllerHome.capacityProfiles.isEmpty)
                                    controllerHome.getCapacityProfiles(user.id);
                                  Get.to(() => CapacityProfilesScreen(
                                        controller: controllerHome,
                                      ));
                                },
                              )
                            : Center(
                                child: Icon(Icons.error_outline),
                              ),
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
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
                  ),
                  Review(
                    rate: me.rate,
                    totalMoney: user.balance,
                    totalVote: 3,
                    workValue: 99,
                  ),
                  Divider(
                    thickness: kDefaultPadding / 2,
                    color: Colors.grey[300],
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
  void logout() async {
    await controllerHome.logOut();
    Get.offAllNamed(Routes.login);
  }
  Future getImage() async {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () {
                controllerHome.uploadAvatar(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Thư viện'),
              onTap: () async {
                controllerHome.uploadAvatar(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Earn extends StatelessWidget {
  const Earn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      child: Row(
        children: [
          Text(
            'Kiếm được',
            style: TEXT_STYLE_PRIMARY,
          ),
          Spacer(),
          Text(
            '100.000.00 VNĐ',
            style: TEXT_STYLE_ON_FOREGROUND,
          )
        ],
      ),
    );
  }
}

class OnReady extends StatelessWidget {
  const OnReady({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Muốn nhận việc',
            style: TEXT_STYLE_PRIMARY,
          ),
          Spacer(),
          Switch(
            value: true,
            onChanged: (value) {},
            activeTrackColor: Colors.lightBlue[200],
            activeColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
