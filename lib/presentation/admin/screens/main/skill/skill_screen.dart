import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SkillScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child: Column(
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
              rows: List.generate(10, (index) => recentDataRow()),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillDetail extends StatelessWidget {
  const SkillDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Flutter'
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50,),
          RoundedButton(onTap: (){}, child: Text('Xác nhận',style: TextStyle(color: Colors.white),))

        ],
      ),
    );
  }
}
DataRow recentDataRow() {
  return DataRow(
    cells: [
      DataCell(Text('1')),
      DataCell(Text('Flutter')),
      DataCell(ElevatedButton(onPressed: (){
        Get.defaultDialog(
            title: 'Sửa kỹ năng',
            content: Expanded(child: Container(child: SkillDetail(),width: 500,height: 700,))
        );
      }, child: Text('Sửa'),style: ElevatedButton.styleFrom(primary: Colors.yellow),)),
    ],
  );
}