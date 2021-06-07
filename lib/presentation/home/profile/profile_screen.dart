import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/responsive.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/profile/edit_profile.dart';
import 'package:freelance_app/presentation/home/profile/withdraw/withdraw_screen.dart';
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
          backgroundColor: Colors.grey[200],
          appBar: Responsive.isMobile(context)
              ? AppBar(
                  title: Text(
                    'Hồ Sơ',
                  ),
                  actions: [
                    IconButton(icon: Icon(Icons.logout), onPressed: logout)
                  ],
                )
              : null,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Responsive(
                    mobile: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(0.0),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          margin: EdgeInsets.all(0.0),
                          child: Information(
                            email: user.email,
                            contract: user.website,
                            phoneNumber: user.phone,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        Card(
                          child: Obx(
                            ()=> OnReady(
                              value: controllerHome.accountOnReady.value,
                              onChanged: (value) {
                                controllerHome.accountOnReady(value);
                                 controllerHome.sendOnReady();
                              },
                            ),
                          ),
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          child: Earn(),
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          child: About(
                            description: user.description,
                            name: user.name,
                          ),
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          child: Skills(
                            skillsList:
                                controllerHome.account.value.freelancerSkills,
                          ),
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          child: Services(
                            freelancerServices: user.freelancerServices,
                          ),
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          child: Padding(
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
                                        if (controllerHome
                                            .capacityProfiles.isEmpty)
                                          controllerHome
                                              .getCapacityProfiles(user.id);
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
                                          if (controllerHome
                                              .capacityProfiles.isEmpty)
                                            controllerHome
                                                .getCapacityProfiles(user.id);
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
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                        Card(
                          child: Review(
                            rate: me.rate,
                            totalMoney: user.balance,
                            totalVote: 3,
                            workValue: 99,
                          ),
                          margin: EdgeInsets.all(0.0),
                        ),
                        SizedBox(
                          height: kDefaultPadding / 2,
                        ),
                      ],
                    ),
                    tablet: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Column(
                        children: [
                          Card(
                            margin: EdgeInsets.all(0.0),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.all(0.0),
                                      child: Information(
                                        email: user.email,
                                        contract: user.website,
                                        phoneNumber: user.phone,
                                      ),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Obx(
                                        ()=> OnReady(
                                          value: controllerHome.accountOnReady.value,
                                          onChanged: (value) {
                                            controllerHome.accountOnReady(!value);
                                            controllerHome.sendOnReady();
                                          },
                                        ),
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Earn(),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: About(
                                        description: user.description,
                                        name: user.name,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Skills(
                                        skillsList: controllerHome
                                            .account.value.freelancerSkills,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Services(
                                        freelancerServices:
                                            user.freelancerServices,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding / 2,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: kDefaultPadding / 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
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
                                                    if (controllerHome
                                                        .capacityProfiles
                                                        .isEmpty)
                                                      controllerHome
                                                          .getCapacityProfiles(
                                                              user.id);
                                                    Get.to(() =>
                                                        CapacityProfilesScreen(
                                                          controller:
                                                              controllerHome,
                                                        ));
                                                  },
                                                  child: user.capacityProfiles
                                                          .isNotEmpty
                                                      ? Text('Xem tất cả')
                                                      : const SizedBox.shrink(),
                                                ),
                                              ],
                                            ),
                                            user.capacityProfiles.isNotEmpty
                                                ? Capacity(
                                                    capacityProfiles:
                                                        user.capacityProfiles,
                                                    onTap: () {
                                                      if (controllerHome
                                                          .capacityProfiles
                                                          .isEmpty)
                                                        controllerHome
                                                            .getCapacityProfiles(
                                                                user.id);
                                                      Get.to(() =>
                                                          CapacityProfilesScreen(
                                                            controller:
                                                                controllerHome,
                                                          ));
                                                    },
                                                  )
                                                : Center(
                                                    child: Icon(
                                                        Icons.error_outline),
                                                  ),
                                            Center(
                                              child: TextButton(
                                                child: Text('Thêm hồ sơ'),
                                                onPressed: () {
                                                  Get.to(() =>
                                                      AddCapacityProfile());
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Review(
                                        rate: me.rate,
                                        totalMoney: user.balance,
                                        totalVote: 3,
                                        workValue: 99,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    desktop: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 250.0),
                      child: Column(
                        children: [
                          Card(
                            margin: EdgeInsets.all(0.0),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding / 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.all(0.0),
                                      child: Information(
                                        email: user.email,
                                        contract: user.website,
                                        phoneNumber: user.phone,
                                      ),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Obx(
                                        ()=> OnReady(
                                          value: controllerHome.accountOnReady.value,
                                          onChanged: (value) {
                                            controllerHome.accountOnReady(!value);
                                            controllerHome.sendOnReady();
                                          },
                                        ),
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Earn(),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: About(
                                        description: user.description,
                                        name: user.name,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Skills(
                                        skillsList: controllerHome
                                            .account.value.freelancerSkills,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Services(
                                        freelancerServices:
                                            user.freelancerServices,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: kDefaultPadding / 2,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kDefaultPadding,
                                            vertical: kDefaultPadding / 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
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
                                                    if (controllerHome
                                                        .capacityProfiles
                                                        .isEmpty)
                                                      controllerHome
                                                          .getCapacityProfiles(
                                                              user.id);
                                                    Get.to(() =>
                                                        CapacityProfilesScreen(
                                                          controller:
                                                              controllerHome,
                                                        ));
                                                  },
                                                  child: user.capacityProfiles
                                                          .isNotEmpty
                                                      ? Text('Xem tất cả')
                                                      : const SizedBox.shrink(),
                                                ),
                                              ],
                                            ),
                                            user.capacityProfiles.isNotEmpty
                                                ? Capacity(
                                                    capacityProfiles:
                                                        user.capacityProfiles,
                                                    onTap: () {
                                                      if (controllerHome
                                                          .capacityProfiles
                                                          .isEmpty)
                                                        controllerHome
                                                            .getCapacityProfiles(
                                                                user.id);
                                                      Get.to(() =>
                                                          CapacityProfilesScreen(
                                                            controller:
                                                                controllerHome,
                                                          ));
                                                    },
                                                  )
                                                : Center(
                                                    child: Icon(
                                                        Icons.error_outline),
                                                  ),
                                            Center(
                                              child: TextButton(
                                                child: Text('Thêm hồ sơ'),
                                                onPressed: () {
                                                  Get.to(() =>
                                                      AddCapacityProfile());
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                    Card(
                                      child: Review(
                                        rate: me.rate,
                                        totalMoney: user.balance,
                                        totalVote: 3,
                                        workValue: 99,
                                      ),
                                      margin: EdgeInsets.all(0.0),
                                    ),
                                    SizedBox(
                                      height: kDefaultPadding / 2,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
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
    return InkWell(
      onTap: () => Get.to(() => WithdrawScreen()),
      child: Padding(
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
            ),
            SizedBox(
              width: kDefaultPadding,
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}

class OnReady extends StatelessWidget {
  const OnReady({
    Key key,
    @required this.onChanged,
    @required this.value,
  }) : super(key: key);
  final Function onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Muốn nhận việc',
            style: TEXT_STYLE_PRIMARY,
          ),
          Spacer(),
          Switch(
            value: value,
            onChanged: (value) {
              onChanged(value);
            },
            activeTrackColor: Colors.lightBlue[200],
            activeColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
