import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SkillScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Get.defaultDialog(
                  title: 'Thêm kỹ năng',
                  content: Expanded(child: Container(child: SkillDetail(),width: 500,height: 700,))
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
          Container(
            width: double.infinity,
            child: DataTable(
              columnSpacing: kDefaultPadding,
              horizontalMargin: 0,
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
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kỹ năng",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding*2),
          InputText(label: 'Tên dịch ngành',),
          SizedBox(height: kDefaultPadding*2),
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