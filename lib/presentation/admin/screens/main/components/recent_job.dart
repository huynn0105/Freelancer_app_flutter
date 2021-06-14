import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/screens/main/manage_job/manage_job_screen.dart';
import 'package:get/get.dart';

class RecentJobss extends StatelessWidget {
  const RecentJobss({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
            Radius.circular(kDefaultPadding / 2)),
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
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Tên Công việc',overflow: TextOverflow.ellipsis,)),
                DataColumn(label: Text('FreelancerId',overflow: TextOverflow.ellipsis)),
                DataColumn(label: Text('Người đăng',overflow: TextOverflow.ellipsis)),
                DataColumn(label: Text('Tuỳ chọn',overflow: TextOverflow.ellipsis)),
              ],
              rows: List.generate(10, (index) => recentDataRow(size.width,size.height)),
            ),
          )
        ],
      ),
    );
  }
  DataRow recentDataRow(double width,double height) {

    return DataRow(
      cells: [
        DataCell(Text('1')),
        DataCell(Text('Thiết kế ứng dụng freelancer')),
        DataCell(Text('1')),
        DataCell(Text('Nguyễn Nhật Huy')),
        DataCell(ElevatedButton(onPressed: (){
          Get.defaultDialog(
              title: 'Chi tiết công việc',
              content: Expanded(child: Container(child: JobDetail(),width: width*0.4,height: height*0.75,))
          );
        }, child: Text('Xem'),style: ElevatedButton.styleFrom(primary: Colors.green),)),
      ],
    );
  }
}

