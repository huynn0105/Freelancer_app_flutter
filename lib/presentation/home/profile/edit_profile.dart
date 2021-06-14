import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/home/profile/profile_controller.dart';
import 'package:freelance_app/presentation/home/profile/services_screen.dart';

import 'package:freelance_app/presentation/home/widgets/item_box.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';

import 'skills_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final Account account;

  EditProfileScreen({@required this.account});

  final controllerHome = Get.find<HomeController>();
  final controller = Get.put<ProfileController>(ProfileController(
    apiRepositoryInterface: Get.find(),
  ));

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 1), () async {
      await initValue(account);
    });

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit profile',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  controller.uploadProfile(account.id).then((value) {
                    print('Giá trị ngoài: $value');
                    if(value) {
                      controllerHome.loadAccountFromToken().then((value) {
                        Get.offAllNamed(Routes.home);
                        Get.snackbar(
                            'Thành công', 'Cập nhập thông tin thành công',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            maxWidth: 600,
                            snackPosition: SnackPosition.TOP);
                      });
                    }
                    else
                      Get.snackbar('Thất bại', 'Server bận, thử lại sau!',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          maxWidth: 600,
                          snackPosition: SnackPosition.TOP);
                  });
                },
                child: Text(
                  'Hoàn thành',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            leading: BackButton(
              onPressed: () async {
                if (controller.isChange.value) {
                  await controllerHome.loadAccountFromToken();
                  Get.offAllNamed(Routes.home);
                } else
                  Get.back();
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Information',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputText(
                          hint: 'Họ và tên',
                          controller: controller.ctrlName,
                          label: 'Tên đầy đủ',
                        ),
                        SizedBox(height: 10),
                        InputText(
                          hint: 'Điện thoại',
                          controller: controller.ctrlPhoneNumber,
                          label: 'Số điện thoại',
                        ),
                        SizedBox(height: 10),
                        InputText(
                          hint: 'Website cá nhân',
                          controller: controller.ctrlWebsite,
                          label: 'Website (nếu có)',
                        ),
                        SizedBox(height: 10),
                        InputText(
                          hint: 'Lập trình viên mobile',
                          controller: controller.ctrlTitle,
                          label: 'Chức danh',
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Thành phố',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onTap: () {
                            controller.loadProvinces();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Danh sách thành phố'),
                                    content: setupLocation(),
                                  );
                                });
                          },
                          readOnly: true,
                          controller: controller.ctrlProvince,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Giới thiệu bản thân',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  InputText(
                    hint: '1. Bạn là ai?\n2. Kinh nghiệm và chuyển môn?...',
                    controller: controller.ctrlDescription,
                    maxLines: 8,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Lĩnh vực',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onTap: () {
                      controller.loadSpecialties();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Danh sách lĩnh vực'),
                              content: setupSpecialties(),
                            );
                          });
                    },
                    readOnly: true,
                    controller: controller.ctrlSpecialty,
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trình độ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
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
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kỹ năng',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Obx(
                          () => controller.skillsSelected.isNotEmpty
                              ? ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.skillsSelected.length,
                                  itemBuilder: (context, index) {
                                    var skill =
                                        controller.skillsSelected[index];
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
                            child: Text('Thêm kỹ năng'),
                            onPressed: () {
                              if (controller.skills.isEmpty)
                                controller.getSkills();
                              Get.to(() => SkillsScreen());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dịch vụ',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
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
                            child: Text('Thêm dịch vụ'),
                            onPressed: () {
                              if (controller.services.isEmpty)
                                controller.loadServices();
                              Get.to(() => ServiceScreen(
                                controller: controller,
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
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

  Future<void> initValue(Account account) async {
    controller.ctrlName.text = account.name;
    controller.ctrlPhoneNumber.text = account.phone;
    controller.ctrlDescription.text = account.description;
    controller.ctrlWebsite.text = account.website;
    controller.ctrlTitle.text = account.title;
    controller.levelId.value = account.level != null ? account.level.id : 0;
    controller.specialtyId.value =
        account.specialty != null ? account.specialty.id : 0;
    if (account.freelancerServices != null)
      controller.servicesSelected.assignAll(account.freelancerServices);
    if (account.freelancerSkills != null)
      controller.skillsSelected.assignAll(account.freelancerSkills);
    if (account.specialty != null)
      controller.ctrlSpecialty.text = account.specialty.name;
    if (account.province != null)
      controller.ctrlProvince.text = account.province.name;
  }

  Widget setupSpecialties() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Obx(
        () => controller.specialties.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.specialties.length,
                itemBuilder: (BuildContext context, int index) {
                  var specialty = controller.specialties[index];
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

  Widget setupLocation() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Obx(
        () => controller.provinces.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.provinces.length,
                itemBuilder: (BuildContext context, int index) {
                  var province = controller.provinces[index];
                  return InkWell(
                    child: ListTile(
                      title: Text(province.name),
                    ),
                    onTap: () {
                      controller.ctrlProvince.text = province.name;
                      controller.province(province);
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
