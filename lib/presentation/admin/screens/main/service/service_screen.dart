import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class ServiceScreen extends StatelessWidget {
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
                  'Chọn chuyên ngành',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16
                  ),
                ),
              ),
              Container(
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
          SizedBox(height: kDefaultPadding*2),
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
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Làm mobile app theo yêu cầu'
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50),
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