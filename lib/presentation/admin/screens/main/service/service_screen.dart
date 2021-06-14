import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/admin/components/dialog_choices.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class ServiceScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child: Obx(
        ()=>  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(10),
                      content: Container(width: Responsive.isDesktop(context) ? size.width * 0.35 : double.maxFinite,
                          height:400,child: ServiceDetail()),
                    );
                  }
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
                rows: List.generate(controller.services.length, (index) => recentDataRow(controller.services[index],context)),
              ),
            ) : Center(child: CircularProgressIndicator()),
          ],
        )
      ),
    );

  }
  DataRow recentDataRow(Service service,context) {
    var size = MediaQuery.of(context).size;
    return DataRow(
      cells: [
        DataCell(Text('${service.id}')),
        DataCell(Text(service.name)),
        DataCell(ElevatedButton(
          onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                  content: Container(width: Responsive.isDesktop(context) ? size.width * 0.35 : double.maxFinite,
                      height:400,child: ServiceDetail(service: service,)),
                );
              }
          );
        }, child: Text('Sửa'),style: ElevatedButton.styleFrom(primary: Colors.yellow),)),
      ],
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

    final _formKey = GlobalKey<FormState>();
    if (service != null) {
      controller.ctrlName.text = service.name;
      controller.specialtiesSelected.assignAll(service.specialties);
    } else {
      controller.ctrlName.text = '';
      controller.specialtiesSelected.clear();
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text( '${service!=null ? 'Sửa' : 'Thêm' } chuyên ngành'),
        centerTitle:true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.clear), onPressed: ()=>Get.back())
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(kDefaultPadding),
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
                          'Chuyên ngành',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            controller.loadSpecialties();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.all(10),
                                  content: Container(
                                      width: Responsive.isDesktop(context) ? size.width * 0.35 : double.maxFinite,
                                      child: DiaLogChoices(listChoice: controller.specialties,listSelected: controller.specialtiesSelected)),
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
                    maxWidth: 600,
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                }
              }, child: Text('Xác nhận',style: TextStyle(color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }

}


