import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/job_description/job_description_screen.dart';
import 'package:freelance_app/presentation/home/post_job/job_location/job_location_screen.dart';
import 'package:freelance_app/presentation/home/post_job/job_skills/job_skills_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/widgets/item_box.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../responsive.dart';

class PostJobDetailScreen extends GetWidget<PostJobController> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color:  Colors.grey[100],
          padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Chi tiết công việc',
              ),
            ),
            body: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      maxLength: 100,
                      decoration: InputDecoration(
                        labelText: 'Tên công việc',
                      ),
                      controller: controller.nameTextController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Lĩnh vực',
                      ),
                      onTap: () {
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
                      controller: controller.specialtyTextController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Dịch vụ',
                      ),
                      readOnly: true,
                      controller: controller.serviceTextController,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Danh sách dịch vụ'),
                                content: setupServices(),
                              );
                            });
                      },
                    ),
                    TextField(
                      controller: controller.descriptionTextController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      //Normal textInputField will be displayed
                      maxLines: 5,
                      // when user presses enter it will adapt to it
                      decoration: InputDecoration(
                        labelText: 'Mô tả công việc',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: controller.locationTextController,
                      decoration: InputDecoration(
                        labelText: 'Địa điểm',
                        prefixIcon: Icon(
                          Icons.location_on,
                        ),
                      ),
                      onTap: () => Get.to(() => JobLocationScreen(
                            id: 0,
                            controller: controller,
                          )),
                      readOnly: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onTap: () {
                        selectDate(context, controller);
                      },
                      decoration: InputDecoration(
                        labelText: 'Hạn chót',
                        prefixIcon: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.blue,
                        ),
                        suffixStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                        suffixText: 'Chọn ngày',
                      ),
                      readOnly: true,
                      controller: controller.deadlineTextController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loại hình làm việc'),
                          SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Row(
                              children: List.generate(
                                controller.typeOfWorks.length,
                                (index) {
                                  var type = controller.typeOfWorks[index];
                                  return ItemBox(
                                    name: type.name,
                                    active: controller.typeId.value,
                                    index: type.id,
                                    onTap: () {
                                      controller.typeId.value = type.id;
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
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hình thức làm việc'),
                          SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Row(
                              children: List.generate(
                                controller.formOfWorks.length,
                                (index) {
                                  var form = controller.formOfWorks[index];
                                  return ItemBox(
                                    name: form.name,
                                    active: controller.formId.value,
                                    index: form.id,
                                    onTap: () {
                                      controller.formId.value = form.id;
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
                      height: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hình thức trả lương'),
                          SizedBox(
                            height: 4,
                          ),
                          Obx(
                            () => Row(
                              children: List.generate(
                                controller.payForms.length,
                                (index) {
                                  var payForm = controller.payForms[index];
                                  return ItemBox(
                                    name: payForm.name,
                                    active: controller.payFormId.value,
                                    index: payForm.id,
                                    onTap: () {
                                      controller.payFormId.value = payForm.id;
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
                          Text('Ngân sách'),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.floorPriceTextController,
                                  inputFormatters: [ThousandsFormatter()],
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          'VNĐ',
                                          style: TextStyle(color: Colors.black54),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller:
                                      controller.cellingPriceTextController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [ThousandsFormatter()],
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Text(
                                          'VNĐ',
                                          style: TextStyle(color: Colors.black54),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          )
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
                          Text('Kỹ năng'),
                          Obx(
                            () => ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.skillsSelected.length,
                              itemBuilder: (context, index) {
                                var skill = controller.skillsSelected[index];
                                return CheckboxListTile(
                                  title: Text(skill.name),
                                  value: skill.isValue,
                                  onChanged: (bool value) {
                                    controller.changeValue(
                                      skill.copyWith(isValue: value),
                                      controller.skillsSelected,
                                    );
                                    controller.changeValue(
                                      skill.copyWith(isValue: value),
                                      controller.skills,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Center(
                              child: TextButton(
                            child: Text('Thêm kỹ năng'),
                            onPressed: () {
                              Get.to(() => JobSkillsScreen(
                                    id: 0,
                                  ));
                            },
                          ))
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => CheckboxListTile(
                          value: controller.isPrivate.value,
                          onChanged: (value) {
                            controller.isPrivate.value = value;
                          },
                          title: Text(
                              'Tôi muốn việc này được Hiển Thị Bí Mật. chỉ những người nào tôi gửi link việc này cho họ và tôi mời họ làm việc mới có thể xem.'),
                          controlAffinity: ListTileControlAffinity.leading),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.postJob();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40),
                      ),
                      child: Text(
                        'Đăng việc',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
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
                      controller.specialtyTextController.text = specialty.name;
                      controller.serviceTextController.text = '';
                      controller.getSpecialtyServices(specialty.id);
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

  Widget setupLocations() {
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
                      controller.locationTextController.text = province.name;
                      controller.provinceId.value = province.provinceId;
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

  Widget setupServices() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Obx(
        () => controller.services.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: controller.services.length,
                itemBuilder: (BuildContext context, int index) {
                  var service = controller.services[index];
                  return InkWell(
                    child: ListTile(
                      title: Text(service.name),
                    ),
                    onTap: () {
                      controller.serviceTextController.text = service.name;
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
