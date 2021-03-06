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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    if (capacityProfile != null){
      controller.ctrlName.text = capacityProfile.name;
      controller.ctrlUrlWeb.text = capacityProfile.urlweb;
      controller.ctrlDescription.text = capacityProfile.description;
      if (capacityProfile.services != null)
        controller.servicesSelected.assignAll(capacityProfile.services);
    }else{
      controller.ctrlDescription.text='';
      controller.ctrlUrlWeb.text = '';
      controller.ctrlName.text = '';
      controller.base64img.value = '';
      controller.nameImage.value = '';
      controller.servicesSelected.clear();
    }

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "${capacityProfile != null ? 'Ch???nh s???a' : 'Th??m'} h??? s?? n??ng l???c",
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
                      'Ti??u ?????*',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      controller: controller.ctrlName,
                      validator: MinLengthValidator(1,
                          errorText: 'Kh??ng ???????c b??? tr???ng'),
                      hint: 'T??n d??? ??n b???n ???? th???c hi???n',
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
                      hint: 'Link web d???n ?????n d??? ??n n??y (n???u c??).',
                      controller: controller.ctrlUrlWeb,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'M?? t??? chi ti???t*',
                      style: TEXT_STYLE_PRIMARY,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    InputText(
                      hint: 'H??y vi???t th???t chi ti???t v??? s???n ph???m ho???c d??? ??n n??y ????? ng?????i xem c?? th??? hi???u ???????c nh???ng c??ng vi???c th???c s??? b???n ???? l??m.',
                      controller: controller.ctrlDescription,
                      validator: MinLengthValidator(1,
                          errorText: 'Kh??ng ???????c b??? tr???ng'),
                      maxLines: 8,
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Text(
                      'H??nh ???nh li??n quan',
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
                                                'http://${capacityProfile.imageUrl}',
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
                          child: Text('Th??m ???nh'),
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
                            'D???ch v??? li??n quan',
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
                              child: Text('Th??m d???ch v???'),
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
                            if((controller.nameImage.value=='' || controller.base64img.value==''))
                                Get.snackbar('L???i', 'Vui l??ng th??m ???nh',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    maxWidth: 600,
                                    snackPosition: SnackPosition.TOP);
                            else{
                              if(capacityProfile!=null)
                                await controller.putCapacityProfile(capacityProfile.id);
                              else
                                await controller.postCapacityProfile();
                              if(controller.progressState.value == sState.initial) {
                                await controllerHome.loadAccountFromToken();
                                Get.offAllNamed(Routes.home);
                                Get.snackbar('Th??nh c??ng', '${capacityProfile!=null ? 'C???p nh???p ' : 'Th??m '} h??? s?? n??ng l???c th??nh c??ng',
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.green,
                                  maxWidth: 600,
                                  colorText: Colors.white,);
                              }
                              else if(controller.progressState.value == sState.failure)
                                Get.snackbar('L???i','Server l???i! Th??? l???i sau',
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                    maxWidth: 600,
                                    snackPosition: SnackPosition.TOP);



                            }

                          } else {
                            Get.snackbar('L???i', 'Ki???m tra l???i th??ng tin ???? nh???p',
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                                maxWidth: 600,
                                snackPosition: SnackPosition.TOP);
                          }
                        },
                        child:  Text(
                                'X??c nh???n',
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
