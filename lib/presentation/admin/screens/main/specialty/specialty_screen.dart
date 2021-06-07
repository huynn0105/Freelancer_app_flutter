
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SpecialtyScreen extends StatelessWidget {
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
                  title: 'Thêm chuyên ngành',
                  titleStyle: TEXT_STYLE_PRIMARY,
                  content: SpecialDetail()
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
              rows: List.generate(20, (index) => recentDataRow()),
            ),
          ),
        ],
      ),
    );
  }
}

class SpecialDetail extends StatelessWidget {
  const SpecialDetail({
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
                child: Text(
                  "Tên chuyên ngành",
                  style: TextStyle(
                      color: Colors.black54,
                    fontSize: 16
                  ),
                ),
                width: 150,
              ),
              Expanded(child: TextField(
                decoration: InputDecoration(
                  hintText: 'Lập trình web'
                ),
              )),
            ],
          ),
          SizedBox(height: kDefaultPadding),
          Text(
            'Hình ảnh liên quan',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16
            ),
          ),
          SizedBox(
            height: kDefaultPadding/3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             Container(
                  height: 130,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2),
                  ),
                ),
              SizedBox(width: kDefaultPadding),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Thêm ảnh'),
              ),
            ],
          ),
          SizedBox(height: kDefaultPadding),
          Row(
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  'Chọn dịch vụ',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16
                  ),
                ),
              ),
              SizedBox(width: kDefaultPadding,),
              Container(
                child: DropdownButton(
                  value: Service(id: 1,name: 'Tất cả'),
                  onChanged: (newValue) {
                  },
                  items: demoService.map<DropdownMenuItem>(( value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Container(child: Text(value.name,style: TextStyle(fontSize: 17),),width: 220,),
                    );
                  }).toList(),
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
      DataCell(Text('Cần tìm lập trình viên mobile')),
      DataCell(ElevatedButton(onPressed: (){
        Get.defaultDialog(
            title: 'Sửa chuyên ngành',
            content: Expanded(child: Container(child: SpecialtyScreen(),width: 500,height: 700,))
        );
      }, child: Text('Sửa'),style: ElevatedButton.styleFrom(primary: Colors.yellow),)),
    ],
  );
}

List demoService = [
  Service(id: 1,name: 'Tất cả'),
  Service(id: 2,name: 'Lập trình web'),
  Service(id: 3,name: 'Lập trình ứng dụng di động'),
  Service(id: 4,name: 'Đa nền tảng'),

];