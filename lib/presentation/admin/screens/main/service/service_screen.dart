import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class ServiceScreen extends StatelessWidget {
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
                  title: 'Thêm dịch vụ',
                  content: Expanded(child: Container(child: ServiceDetail(),width: 500,height: 700,))
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
                DataColumn(label: Text('Tên dịch vụ')),
                DataColumn(label: Text('Tên chuyên ngành')),
                DataColumn(label: Text('Tuỳ chọn'))
              ],
              rows: List.generate(20, (index) => recentDataRow()),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceDetail extends StatelessWidget {
  const ServiceDetail({
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
          InputText(label: 'Tên dịch ngành',),
          SizedBox(height: kDefaultPadding*2),
          Row(
            children: [
              Container(
                width: 100,
                child: Text(
                  'Chọn chuyên ngành',
                  style: TEXT_STYLE_ON_FOREGROUND,
                ),
              ),
              SizedBox(width: kDefaultPadding*2,),
              Container(
                width: 260,
                child: DropdownButton(
                  value: Specialty(id: 1,name: 'Tất cả'),
                  onChanged: (newValue) {

                  },
                  items: demoSpecialty.map<DropdownMenuItem>(( value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Container(child: Text(value.name,style: TextStyle(fontSize: 17),),width: 220,),
                    );
                  }).toList(),
                ),
              )

            ],
          ),
          Spacer(),
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
      DataCell(Text('Làm app theo yêu cầu')),
      DataCell(Text('Lập trình ứng dụng di động')),
      DataCell(ElevatedButton(onPressed: (){
        Get.defaultDialog(
            title: 'Sửa dịch vụ',
            content: Expanded(child: Container(child: ServiceDetail(),width: 500,height: 700,))
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