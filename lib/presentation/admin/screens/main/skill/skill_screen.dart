import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SkillScreen extends GetWidget<AdminController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child: Obx(
        ()=> controller.progressState.value == sState.initial ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Get.defaultDialog(
                  radius: 10,
                    title: 'Thêm kỹ năng',
                    titleStyle: TEXT_STYLE_PRIMARY,
                    content: SkillDetail()
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
            Container(
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
                  DataColumn(label: Text('Tên kỹ năng')),
                  DataColumn(label: Text('Tuỳ chọn'))
                ],
                rows: List.generate(controller.skills.length, (index) => recentDataRow(controller.skills[index])),
              ),
            ),
          ],
        ) : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class SkillDetail extends StatefulWidget {
   SkillDetail({
    Key key,
    this.skill,
  }) : super(key: key);

  final Skill skill;

  @override
  _SkillDetailState createState() => _SkillDetailState();
}

class _SkillDetailState extends State<SkillDetail> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {

    if(widget.skill!=null)
      controller.ctrlName.text = widget.skill.name;
    else{
      controller.ctrlName.text = '';
    }

    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      width: Responsive.isDesktop(context)? size.width*0.35 : size.width*0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  "Tên kỹ năng",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (text){
                      if (text == null || text.isEmpty) {
                        return 'Yêu cầu nhập';
                      }
                      return null;
                    },
                    controller: controller.ctrlName,
                    decoration: InputDecoration(

                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50,),
          RoundedButton(onTap: (){
            if (_formKey.currentState.validate()){
              if(widget.skill == null)
                controller.sendSkill().then((value) => controller.loadSkills());
              else
                controller.updateSkill(widget.skill.id).then((value) => controller.loadSkills());
              Get.back();
              Get.snackbar(
                'Thành công',
                '',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            }
          }, child: Text('Xác nhận',style: TextStyle(color: Colors.white),))

        ],
      ),
    );
  }
}
DataRow recentDataRow(Skill skill) {
  return DataRow(
    cells: [
      DataCell(Text('${skill.id}')),
      DataCell(Text(skill.name)),
      DataCell(ElevatedButton(onPressed: (){
        Get.defaultDialog(
            title: 'Sửa kỹ năng',
            content: SkillDetail(skill: skill)
        );
      }, child: Text('Sửa'),style: ElevatedButton.styleFrom(primary: Colors.yellow),)),
    ],
  );
}