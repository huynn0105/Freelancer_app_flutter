import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/job_description/job_description_screen.dart';
import 'package:freelance_app/presentation/home/post_job/job_location/job_location_screen.dart';
import 'package:freelance_app/presentation/home/post_job/job_skills/job_skills_screen.dart';
import 'package:freelance_app/presentation/home/post_job/post_job_controller.dart';
import 'package:freelance_app/presentation/home/post_job/successful/successful_screen.dart';
import 'package:freelance_app/presentation/home/widgets/item_box.dart';
import 'package:get/get.dart';

class PostJobDetailScreen extends GetWidget<PostJobController> {

  void postJob() async {
      final bool result = await controller.postJob();
      if (result) {
        Get.offAll(()=>SuccessfulScreen());
      } else {
        Get.snackbar('Error','',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'Post Job Detail',
            ),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: controller.nameTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Specialty',
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
                    controller: controller.specialtyTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Service',
                    ),
                    readOnly: true,
                    controller: controller.serviceTextController,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Service List'),
                              content: setupServices(),
                            );
                          });
                    },
                  ),
                  TextField(
                    controller: controller.descriptionTextController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: controller.locationTextController,
                    decoration: InputDecoration(
                      labelText: 'Location',
                      prefixIcon: Icon(
                        Icons.location_on,
                      ),
                    ),
                    onTap: ()=> Get.to(()=> JobLocationScreen(id: 0,controller: controller,))
                    ,
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
                      labelText: 'Deadline',
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
                        Text('Type of work'),
                        SizedBox(
                          height: 4,
                        ),
                        Obx(
                          ()=> Row(
                            children: List.generate(
                              controller.typeOfWorks.length,
                              (index){
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
                        Text('Form of work'),
                        SizedBox(
                          height: 4,
                        ),
                        Obx(
                              ()=> Row(
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
                        Text('Pay form'),
                        SizedBox(
                          height: 4,
                        ),
                        Obx(
                              ()=> Row(
                            children: List.generate(
                              controller.payForms.length,
                                  (index){
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
                        Text('Salary'),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.floorPriceTextController,
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
                                controller: controller.cellingPriceTextController,
                                keyboardType: TextInputType.number,
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
                        Text('Skills'),
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
                          child: Text('Add more skill'),
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
                  SizedBox(height: 10,),
                  Obx(
                    ()=> CheckboxListTile(value: controller.isPrivate.value, onChanged: (value){
                      controller.isPrivate.value = value;
                    },
                      title: Text('I want this to be Secretly Visible - only people I link this to them and I invite them to work with will be able to see it.'),
                        controlAffinity: ListTileControlAffinity.leading
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      postJob();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40),
                    ),
                    child: Text(
                      'Post Job',
                      style: TextStyle(fontSize: 20),
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
