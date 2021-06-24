import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/components/dialog_choices.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SpecialtyScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context)
          ? EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 3)
          : EdgeInsets.all(kDefaultPadding / 2),
      child: Obx(
        () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_)=>AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              content: Container(
                                  width: Responsive.isDesktop(context) ? size.width * 0.35 : double.maxFinite,
                                  child: SpecialDetail()))
                      );
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
                                    controller.specialties[index],context)),
                          ),
                        )
                      : Center(child: CircularProgressIndicator())
                ],
              )
            ,
      ),
    );
  }

  DataRow recentDataRow(Specialty specialty,context) {
    var size = MediaQuery.of(context).size;
    return DataRow(
      cells: [
        DataCell(Text('${specialty.id}')),
        DataCell(Text(specialty.name)),
        DataCell(ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
                builder: (_)=>AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                    content: Container(
                      width: Responsive.isDesktop(context) ? size.width * 0.35 : double.maxFinite,
                        child: SpecialDetail(specialty: specialty)))
                );

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


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    final _formKey = GlobalKey<FormState>();
    var size = MediaQuery.of(context).size;
    if (specialty != null) {
      controller.ctrlName.text = specialty.name;
      controller.servicesSelected.assignAll(specialty.services);
      controller.base64img.value = '';
    } else {
      controller.ctrlName.text = '';
      controller.base64img.value = '';
      controller.servicesSelected.clear();
      controller.nameImage.value = '';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${specialty!=null ? 'Sửa' : 'Thêm'} chuyên ngành'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.clear), onPressed: ()=>Get.back())
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(kDefaultPadding),
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
                    validator: RequiredValidator(errorText: 'Yêu cầu nhập'),
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
                      "Dịch vụ",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                    width: 150,
                  ),
                  SizedBox(width: kDefaultPadding),
                  ElevatedButton(
                      onPressed: () {
                        controller.loadServices();
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              contentPadding: EdgeInsets.all(10),
                              content: Container(
                                  width: Responsive.isDesktop(context) ? size.width * 0.35 : double.maxFinite,
                                  child: DiaLogChoices(listChoice: controller.services,listSelected: controller.servicesSelected,)),
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
                    if (!_formKey.currentState.validate()) {
                      Get.snackbar('Lỗi', 'Kiểm tra lại thông tin',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          maxWidth: 600,
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
                          maxWidth: 600,
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

