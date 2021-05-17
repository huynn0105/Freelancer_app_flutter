import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/post_job/job_skills/job_skills_screen.dart';
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
  final controllerHome = Get.find<HomeController>();
  final controllerJob = Get.find<PostJobController>();
  final controller = Get.put<ProfileController>(ProfileController(
    apiRepositoryInterface: Get.find(),
    localRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      Get.bottomSheet(
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
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

    final user = controllerHome.account.value;

    controller.ctrlName.text = user.name;
    controller.ctrlPhoneNumber.text = user.phone;
    controller.ctrlDescription.text = user.description;
    controller.ctrlWebsite.text = user.website;
    controller.ctrlTile.text = user.tile;
    controller.formOnWorkId.value = user.formOnWorkId;
    controller.levelId.value = user.levelId;
    controller.imageURL.value = user.avatarUrl;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh sửa thông tin',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await controller.uploadProfile(controllerHome.account.value.id);
              await controllerHome.loadAccount();
              await controllerHome.getLevelFromId();
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
                      url: controller.imageURL.value,
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
                      label: 'Phone number',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputText(
                      hint: 'Tile',
                      controller: controller.ctrlTile,
                      label: 'Phone number',
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
                label: 'Description',
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
                controller: controller.ctrlSpecializeId,
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
                              active: controller.formOnWorkId.value,
                              index: form.id,
                              onTap: () {
                                controller.formOnWorkId.value = form.id;
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
                            var level =  controller.levels[index];
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
                        controller.getSkills();
                        Get.to(() => SkillsScreen(
                            ));
                      },
                    ))
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
                        controller.getServices();
                        Get.to(() => ServiceScreen());
                      },
                    ))
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
    );
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
                      controller.ctrlSpecializeId.text = specialty.name;
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
