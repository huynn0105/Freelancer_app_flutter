import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/home/profile/profile_controller.dart';
import 'package:freelance_app/presentation/home/profile/services_screen.dart';
import 'package:freelance_app/presentation/home/widgets/avatar.dart';
import 'package:freelance_app/presentation/home/widgets/item_box.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'skills_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final Account account;

  EditProfileScreen({@required this.account});

  final controllerHome = Get.find<HomeController>();
  final controllerJob = Get.find<PostJobController>();
  final controller = Get.put<ProfileController>(ProfileController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () async {
      initValue(account);
    });

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit profile',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await controller.uploadProfile(account.id);
                  await controllerHome.loadAccount();
                  controller.progressState(sState.initial);
                  controller.isChange(true);
                  Get.offAllNamed(Routes.home);
                },
                child: Text(
                  'Done',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () async {
                if (controller.isChange.value) {
                  await controllerHome.loadAccount();
                  Get.offAllNamed(Routes.home);
                } else {
                  Get.back();
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ảnh đại diện',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Center(
                        child: Avatar(
                          url: controller.imageURL.value!=''? controller.imageURL.value : account.avatarUrl,
                          onTap: getImage,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Information',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputText(
                          hint: 'Name',
                          controller: controller.ctrlName,
                          label: 'Name',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputText(
                          hint: 'Phone number',
                          controller: controller.ctrlPhoneNumber,
                          label: 'Phone number',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputText(
                          hint: 'Websites',
                          controller: controller.ctrlWebsite,
                          label: 'Websites',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InputText(
                          hint: 'Tile',
                          controller: controller.ctrlTile,
                          label: 'Tile',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Intro',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InputText(
                    hint: 'Experienced English - Vietnamese Translator & Editor',
                    controller: controller.ctrlDescription,
                    maxLines: 8,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Specialty',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Specialty List'),
                              content: setupSpecialties(),
                            );
                          });
                    },
                    readOnly: true,
                    controller: controller.ctrlSpecialty,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Form Of Work',
                          style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Obx(
                          () => Row(
                            children: List.generate(
                              controllerJob.formOfWorks.length,
                              (index) {
                                var form = controllerJob.formOfWorks[index];
                                return ItemBox(
                                  name: form.name,
                                  active: controller.formOfWorkId.value,
                                  index: form.id,
                                  onTap: () {
                                    controller.formOfWorkId.value = form.id;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Level',
                          style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Obx(
                          () => Row(
                            children: List.generate(
                              controller.levels.length,
                              (index) {
                                var level = controller.levels[index];
                                return ItemBox(
                                  name: level.name,
                                  active: controller.levelId.value,
                                  index: level.id,
                                  onTap: () {
                                    controller.levelId.value = level.id;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Skill',
                          style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => controller.skillsSelected.isNotEmpty
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.skillsSelected.length,
                                  itemBuilder: (context, index) {
                                    var skill = controller.skillsSelected[index];
                                    return CheckboxListTile(
                                      title: Text(skill.name),
                                      value: skill.isValue,
                                      onChanged: (bool value) {
                                        controller.changeValueSkill(
                                          skill.copyWith(isValue: value),
                                          controller.skillsSelected,
                                        );
                                        controller.changeValueSkill(
                                          skill.copyWith(isValue: value),
                                          controller.skills,
                                        );
                                      },
                                    );
                                  },
                                )
                              : SizedBox.shrink(),
                        ),
                        Center(
                          child: TextButton(
                            child: Text('Add more skill'),
                            onPressed: () {
                              if (controller.skills.isEmpty) controller.getSkills();
                              Get.to(() => SkillsScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service',
                          style:
                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => controller.servicesSelected.isNotEmpty
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.servicesSelected.length,
                                  itemBuilder: (context, index) {
                                    var service =
                                        controller.servicesSelected[index];
                                    return CheckboxListTile(
                                      title: Text(service.name),
                                      value: service.isValue,
                                      onChanged: (bool value) {
                                        controller.changeValueService(
                                          service.copyWith(isValue: value),
                                          controller.servicesSelected,
                                        );
                                        controller.changeValueService(
                                          service.copyWith(isValue: value),
                                          controller.services,
                                        );
                                      },
                                    );
                                  },
                                )
                              : SizedBox.shrink(),
                        ),
                        Center(
                          child: TextButton(
                            child: Text('Add more service'),
                            onPressed: () {
                              if (controller.services.isEmpty)
                                controller.getServices();
                              Get.to(() => ServiceScreen(
                                    controller: controller,
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Status',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                    () => CheckboxListTile(
                        value: controller.isReady.value,
                        onChanged: (value) {
                          controller.isReady.value = value;
                        },
                        title: Text('On Ready'),
                        controlAffinity: ListTileControlAffinity.leading),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Obx(() {
            if (controller.progressState.value == sState.loading) {
              return Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        )
      ],
    );
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
                controller.uploadAvatar(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.image),
              title: Text('Gallery'),
              onTap: () async {
                controller.uploadAvatar(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void initValue(Account account) {

    controller.ctrlName.text = account.name;
    controller.ctrlPhoneNumber.text = account.phone;
    controller.ctrlDescription.text = account.description;
    controller.ctrlWebsite.text = account.website;
    controller.ctrlTile.text = account.tile;
    controller.formOfWorkId.value =
        account.formOfWork != null ? account.formOfWork.id : 0;
    controller.levelId.value = account.level != null ? account.level.id : 0;
    controller.imageURL.value = account.avatarUrl;
    if (account.freelancerServices != null)
      controller.servicesSelected.assignAll(account.freelancerServices);
    if (account.freelancerSkills != null)
      controller.skillsSelected.assignAll(account.freelancerSkills);
    if (account.specialty != null)
      controller.ctrlSpecialty.text = account.specialty.name;
  }

  Widget setupSpecialties() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Obx(
        () => controllerJob.specialties.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: controllerJob.specialties.length,
                itemBuilder: (BuildContext context, int index) {
                  var specialty = controllerJob.specialties[index];
                  return InkWell(
                    child: ListTile(
                      title: Text(specialty.name),
                    ),
                    onTap: () {
                      controller.ctrlSpecialty.text = specialty.name;
                      controller.specialtyId.value = specialty.id;
                      Get.back();
                    },
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
