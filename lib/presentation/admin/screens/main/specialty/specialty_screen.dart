
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/presentation/home/post_job/widgets/input_text.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class SpecialtyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Get.defaultDialog(
                  title: 'Thêm chuyên ngành',
                  content: Expanded(child: Container(child: SpecialtyScreen(),width: 500,height: 700,))
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
            "Chuyên ngành",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding),
          InputText(label: 'Tên chuyên ngành',),
          SizedBox(height: kDefaultPadding),
          Text(
            'Hình ảnh liên quan',
            style: TEXT_STYLE_ON_FOREGROUND,
          ),
          SizedBox(
            height: kDefaultPadding/2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             Container(
                  height: 130,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent, width: 2),

                  ),
                ),
              ElevatedButton(
                onPressed: () {

                },
                child: Text('Thêm ảnh'),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          Row(
            children: [
              Container(
                width: 100,
                child: Text(
                  'Chọn dịch vụ',
                  style: TEXT_STYLE_ON_FOREGROUND,
                ),
              ),
              SizedBox(width: kDefaultPadding,),
              Container(
                width: 260,
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