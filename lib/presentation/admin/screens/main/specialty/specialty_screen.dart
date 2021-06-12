import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/components/dialog_choices.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SpecialtyScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context)
          ? EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 3)
          : EdgeInsets.all(kDefaultPadding / 2),
      child: Obx(
        () => controller.progressState.value == sState.initial
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      controller.loadServices();
                      Get.defaultDialog(
                          radius: 10,
                          title: 'Thêm chuyên ngành',
                          titleStyle: TEXT_STYLE_PRIMARY,
                          content: SpecialDetail());
                    },
                    style: !Responsive.isMobile(context)
                        ? TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding * 3 / 2,
                                vertical: kDefaultPadding),
                          )
                        : null,
                    icon: Icon(Icons.add),
                    label: Text('Thêm mới'),
                  ),
                  SizedBox(height: kDefaultPadding),
                  controller.specialties.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(kDefaultPadding / 2)),
                          ),
                          width: double.infinity,
                          child: DataTable(
                            columnSpacing: kDefaultPadding,
                            horizontalMargin: kDefaultPadding,
                            columns: [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Tên chuyên ngành')),
                              DataColumn(label: Text('Tuỳ chọn'))
                            ],
                            rows: List.generate(
                                controller.specialties.length,
                                (index) => recentDataRow(
                                    controller.specialties[index])),
                          ),
                        )
                      : Center(child: Text('Trống')),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  DataRow recentDataRow(Specialty specialty) {
    return DataRow(
      cells: [
        DataCell(Text('${specialty.id}')),
        DataCell(Text(specialty.name)),
        DataCell(ElevatedButton(
          onPressed: () {
            Get.defaultDialog(
                title: 'Sửa chuyên ngành',
                radius: 10,
                content: SpecialDetail(specialty: specialty));
          },
          child: Text('Sửa'),
          style: ElevatedButton.styleFrom(primary: Colors.yellow),
        )),
      ],
    );
  }
}

class SpecialDetail extends StatelessWidget {
  SpecialDetail({
    Key key,
    this.specialty,
  }) : super(key: key);
  final Specialty specialty;
  final controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var size = MediaQuery.of(context).size;
    if (specialty != null) {
      controller.ctrlName.text = specialty.name;
      controller.base64img.value = '';
    } else {
      controller.ctrlName.text = '';
      controller.base64img.value = '';
      controller.nameImage.value = '';
    }
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        width:
            Responsive.isDesktop(context) ? size.width * 0.35 : size.width * 0.65,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    child: Text(
                      "Tên chuyên ngành",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    width: 150,
                  ),
                  SizedBox(width: kDefaultPadding),
                  Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                    controller: controller.ctrlName,
                          validator: (text){
                            if (text == null || text.isEmpty) {
                              return 'Yêu cầu nhập';
                            }
                            return null;
                          },
                    decoration: InputDecoration(
                        hintText: 'Lập trình web',
                    ),
                  ),
                      )),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              Text(
                'Hình ảnh liên quan',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              SizedBox(
                height: kDefaultPadding / 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                      height: Responsive.isMobile(context) ? 130 : 180,
                      width: Responsive.isMobile(context) ? 150 : 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent, width: 2),
                        image: controller.base64img.value != ''
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                  base64Decode(controller.base64img.value),
                                ),
                              )
                            : specialty != null
                                ? specialty.image != null
                                    ? DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          "http://${specialty.image}",
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null
                                : null,
                      ),
                    ),
                  ),
                  SizedBox(width: kDefaultPadding),
                  ElevatedButton(
                    onPressed: () => controller.uploadImage(),
                    child: Text('Thêm ảnh'),
                  ),
                ],
              ),
              SizedBox(height: kDefaultPadding),
              Row(
                children: [
                  SizedBox(
                    child: Text(
                      "Chọn dịch vụ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    width: 150,
                  ),
                  SizedBox(width: kDefaultPadding),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.services.isEmpty) {
                          controller.loadServices();
                        }
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              content: DiaLogChoices(listChoice: controller.services,listSelected: controller.servicesSelected,),
                            ));
                      },
                      child: Text('Click để chọn'))
                ],
              ),
              SizedBox(height: 5),
              Obx(
                () => controller.servicesSelected.isNotEmpty
                    ? Wrap(
                        children: List.generate(
                            controller.servicesSelected.length,
                            (index) => Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    print('Chỉ số mảng: $index');


                                    controller.changeValueService(
                                      controller.servicesSelected[index]
                                          .copyWith(isValue: false),
                                    );
                                    controller.servicesSelected.remove(controller.servicesSelected[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Text(controller
                                            .servicesSelected[index].name),
                                        Icon(Icons.clear),
                                      ],
                                    ),
                                  ),
                                ))),
                      )
                    : SizedBox.shrink(),
              ),
              SizedBox(height: kDefaultPadding),
              RoundedButton(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP);
                    } else {
                      if (specialty != null)
                        controller.updateSpecialty(specialty.id);
                      else
                        controller.sendSpecialty();

                      controller.loadSpecialties();
                        Get.back();
                        Get.snackbar(
                          'Thành công',
                          '',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      }
                  },
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

List demoService = [
  Service(id: 1, name: 'Tất cả'),
  Service(id: 2, name: 'Lập trình web'),
  Service(id: 3, name: 'Lập trình ứng dụng di động'),
  Service(id: 4, name: 'Đa nền tảng'),
];
