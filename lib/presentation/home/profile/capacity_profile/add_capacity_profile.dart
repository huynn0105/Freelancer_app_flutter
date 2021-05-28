import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  final controller = Get.find<CapacityProfileController>();

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
                    hint: 'Tên dự án hoặc tên sản phẩm bạn đã thực hiện',
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
                    hint: 'Link web dẫn đến dự án hoặc sản phẩm này (nếu có).',
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
                      onTap: ()  {
                        capacityProfile != null
                            ?  controller.putCapacityProfile(capacityProfile.id)
                            :  controller.postCapacityProfile();
                        controllerHome.loadAccountFromToken();
                        if(controller.progressState.value == sState.initial)
                          Get.snackbar('Success','', snackPosition: SnackPosition.TOP);
                        else if(controller.progressState.value == sState.failure)
                          Get.snackbar('Error','',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.TOP);
                        Get.offAllNamed(Routes.home);
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
