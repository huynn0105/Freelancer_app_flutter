import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/components/dialog_choices.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class ServiceScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child: Obx(
        ()=>  controller.progressState.value == sState.initial ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                    radius: 10,
                    title: 'Thêm dịch vụ',
                    titleStyle: TEXT_STYLE_PRIMARY,
                    content: ServiceDetail()
                );
              },
              style: !Responsive.isMobile(context) ?TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding*3/2,
                    vertical: kDefaultPadding),
              ):null,
              icon: Icon(Icons.add),
              label: Text('Thêm mới'),
            ),
            SizedBox(height: kDefaultPadding),
            controller.services.isNotEmpty ? Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(
                    Radius.circular(kDefaultPadding / 2)),
              ),
              child: DataTable(
                columnSpacing: kDefaultPadding,
                horizontalMargin: kDefaultPadding,
                columns: [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Tên dịch vụ')),
                  DataColumn(label: Text('Tuỳ chọn'))
                ],
                rows: List.generate(controller.services.length, (index) => recentDataRow(controller.services[index])),
              ),
            ) : Center(child: Text('Trống')),
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ServiceDetail extends StatelessWidget {
   ServiceDetail({
    Key key,
     this.service,
  }) : super(key: key);
   final Service service;


  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    var size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    if (service != null) {
      controller.ctrlName.text = service.name;
    } else {
      controller.ctrlName.text = '';
      controller.specialtiesSelected.clear();
    }

    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      width: Responsive.isDesktop(context) ? size.width * 0.35 : size.width * 0.65,
      height:400,
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Text(
                        "Tên chuyên ngành",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16
                        ),
                      ),
                      width: 150,
                    ),
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

                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: kDefaultPadding*2),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Chọn chuyên ngành',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (controller.specialties.isEmpty) {
                            controller.loadSpecialties();
                          }
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                contentPadding: EdgeInsets.all(10),
                                content: DiaLogChoices(listChoice: controller.specialties,listSelected: controller.specialtiesSelected),
                              ));
                        },
                        child: Text('Click để chọn')),
                  ],
                ),
                SizedBox(height: 5),
                Obx(
                      () => controller.specialtiesSelected.isNotEmpty
                      ? Wrap(
                    children: List.generate(
                        controller.specialtiesSelected.length,
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
                                controller.changeValueSpecialty(
                                  controller.specialtiesSelected[index]
                                      .copyWith(isValue: false),
                                );
                                controller.specialtiesSelected.remove(this);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Wrap(
                                  crossAxisAlignment:
                                  WrapCrossAlignment.center,
                                  children: [
                                    Text(controller
                                        .specialtiesSelected[index].name),
                                    Icon(Icons.clear),
                                  ],
                                ),
                              ),
                            ))),
                  )
                      : SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: RoundedButton(onTap: (){
              if(_formKey.currentState.validate()){
                if(service!=null)
                  controller.updateService(service.id).then((value) => controller.loadServices());
                else
                  controller.sendService().then((value) => controller.loadServices());
                Get.back();
                Get.snackbar(
                  'Thành công',
                  '',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              }
            }, child: Text('Xác nhận',style: TextStyle(color: Colors.white),)),
          )
        ],
      ),
    );
  }
}
DataRow recentDataRow(Service service) {
  return DataRow(
    cells: [
      DataCell(Text('${service.id}')),
      DataCell(Text(service.name)),
      DataCell(ElevatedButton(onPressed: (){
        Get.defaultDialog(
            title: 'Sửa dịch vụ',
            content: ServiceDetail(service: service)
        );
      }, child: Text('Sửa'),style: ElevatedButton.styleFrom(primary: Colors.yellow),)),
    ],
  );
}

List demoSpecialty = [
  Specialty(id: 1,name: 'Tất cả'),
  Specialty(id: 2,name: 'Lập trình web'),
  Specialty(id: 3,name: 'Lập trình ứng dụng di động'),
  Specialty(id: 4,name: 'Đa nền tảng'),

];