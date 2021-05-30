import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/home/profile/capacity_profile/capacity_profile_controller.dart';
import 'package:freelance_app/presentation/home/profile/services_screen.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';

class AddCapacityProfile extends StatelessWidget {

  final controller = Get.put<CapacityProfileController>(CapacityProfileController(
    apiRepositoryInterface: Get.find(),
  ));

  final controllerHome = Get.find<HomeController>();
  final CapacityProfile capacityProfile;

  AddCapacityProfile({this.capacityProfile, Key key}) : super(key: key);

  void initValue() {
    controller.ctrlName.text = capacityProfile.name;
    controller.ctrlUrlWeb.text = capacityProfile.urlweb;
    controller.ctrlDescription.text = capacityProfile.description;
    if (capacityProfile.services != null)
      controller.servicesSelected.assignAll(capacityProfile.services);
  }

  @override
  Widget build(BuildContext context) {
    if (capacityProfile != null) initValue();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "${capacityProfile != null ? 'Chỉnh sửa' : 'Thêm'} hồ sơ năng lực",
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tiêu đề*',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      controller: controller.ctrlName,
                      validator: MinLengthValidator(1,
                          errorText: 'Không được bỏ trống'),
                      hint: 'Tên dự án bạn đã thực hiện',
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'URL',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      hint: 'Link web dẫn đến dự án này (nếu có).',
                      controller: controller.ctrlUrlWeb,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'Mô tả chi tiết*',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      hint: 'Hãy viết thật chi tiết về sản phẩm hoặc dự án này để người xem có thể hiệu được những công việc thực sự bạn đã làm.',
                      controller: controller.ctrlDescription,
                      validator: MinLengthValidator(1,
                          errorText: 'Không được bỏ trống'),
                      maxLines: 8,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'Hình ảnh liên quan',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(
                          () => Container(
                            height: 180,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent, width: 2),
                              image: controller.base64img.value != ''
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(
                                        base64Decode(controller.base64img.value),
                                      ),
                                    )
                                  : capacityProfile != null
                                      ? capacityProfile.imageUrl != null
                                          ? DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                '$IMAGE/${capacityProfile.imageUrl}',
                                                headers: {
                                                  HttpHeaders.authorizationHeader:
                                                      'Bearer $TOKEN'
                                                },
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : null
                                      : null,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.uploadImage();
                          },
                          child: Text('Thêm ảnh'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dịch vụ liên quan',
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
                              child: Text('Thêm dịch vụ'),
                              onPressed: () {
                                if (controller.services.isEmpty)
                                  controller.getServices();
                                Get.to(
                                  () => ServiceScreen(
                                    controller: controller,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ), RoundedButton(
                        onTap: () async {
                          if(formKey.currentState.validate()){
                            if(capacityProfile == null && controller.nameImage.value=='' && controller.base64img.value=='')
                                Get.snackbar('Lỗi', 'Vui lòng thêm ảnh',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.TOP);
                            else{
                              if(capacityProfile!=null)
                                await controller.putCapacityProfile(capacityProfile.id);
                              else
                                await controller.postCapacityProfile();

                              if(controller.progressState.value == sState.initial)
                                Get.snackbar('Thành công','', snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green,
                                  colorText: Colors.white,);
                              else if(controller.progressState.value == sState.failure)
                                Get.snackbar('Lỗi','',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    snackPosition: SnackPosition.BOTTOM);
                              await controllerHome.loadAccountFromToken();
                              Get.offAllNamed(Routes.home);
                              controller.initValue();
                            }

                          } else {
                            Get.snackbar('Lỗi', 'Kiểm tra lại thông tin đã nhập',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                snackPosition: SnackPosition.TOP);
                          }
                        },
                        child:  Text(
                                capacityProfile != null ? 'Cập nhập' : 'Lưu hồ sơ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
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

}
