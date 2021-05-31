import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:get/get.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(kDefaultPadding / 2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tất cả công việc',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: kDefaultPadding,
                horizontalMargin: 0,
                columns: [
                  DataColumn(label: Text('ID Job')),
                  DataColumn(
                      label: Text(
                    'Tên Công việc',
                    overflow: TextOverflow.ellipsis,
                  )),
                  DataColumn(
                      label: Text('Tên người thuê',
                          overflow: TextOverflow.ellipsis)),
                  DataColumn(
                      label: Text('Tên Freelancer',
                          overflow: TextOverflow.ellipsis)),
                  DataColumn(
                      label: Text('Tuỳ chọn', overflow: TextOverflow.ellipsis)),
                ],
                rows: List.generate(10, (index) => recentDataRow(index)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportDetail extends StatelessWidget {
  const ReportDetail({
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Thiết kế ứng dụng freelancer',style: TEXT_STYLE_PRIMARY,),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Text('Người thuê:'),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Text('Nguyễn Văn A',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Text('Freelancer:'),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Text('Nguyễn Nhật Huy',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
              ],
            ),

            SizedBox(height: kDefaultPadding),
            Text('Lý do:'),
            SizedBox(height: kDefaultPadding/2),
            Text('Tôi muốn huỷ công việc vì freelancer không hoàn thành đúng thời hạn đã giao',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w500),),

            SizedBox(height: kDefaultPadding,),
            Text('Tin nhắn'),
            Container(
              width: 500,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(width: 2,color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: ListView(children: [
                ListTile(
                  leading: Text('Nguyễn Nhật Huy',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
                  title: Text('Hãy hoàn thành đúng yêu cầu'),
                ),
                ListTile(
                  leading: Text('Nguyễn Văn A',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500)),
                  title: Text('Cho tôi thêm thời gian',),
                ),
                ListTile(
                  leading: Text('Nguyễn Nhật Huy',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
                  title: Text('Bạn có thêm 1 tuần'),
                ),
                ListTile(
                  leading: Text('Nguyễn Nhật Huy',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500)),
                  title: Text('Đã quá hạn deadline rồi'),
                ),
                ListTile(
                  leading: Text('Nguyễn Văn A',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500)),
                  title: Text('Sr tôi không thể hoàn thành công việc'),
                ),
                ListTile(
                  leading: Text('Nguyễn Nhật Huy',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500)),
                  title: Text('Tôi sẽ yêu cầu làm lại'),
                ),
              ]),
            ),
            SizedBox(height: kDefaultPadding,),
            Row(
              children: [
                Expanded(child: RoundedButton(onTap: (){}, child: Text('Xác nhận',style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,)),
                SizedBox(width: kDefaultPadding,),
                Expanded(child: RoundedButton(onTap: (){}, child: Text('Từ chối',style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

DataRow recentDataRow(int id) {
  return DataRow(
    cells: [
      DataCell(Text('$id')),
      DataCell(Text('Thiết kế ứng dụng freelancer')),
      DataCell(Text('Nguyễn Văn A')),
      DataCell(Text('Nguyễn Nhật Huy')),
      DataCell(ElevatedButton(
        onPressed: () {
          Get.defaultDialog(
              title: 'Chi tiết',
              content: Expanded(
                  child: Container(
                child: ReportDetail(),
                width: 500,
                height: 700,
              )));
        },
        child: Text('Xem'),
        style: ElevatedButton.styleFrom(primary: Colors.green),
      )),
    ],
  );
}
