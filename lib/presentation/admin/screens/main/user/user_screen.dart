import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/MyFiles.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/my_feilds.dart';
import 'package:freelance_app/responsive.dart';
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Người dùng',style: TEXT_STYLE_PRIMARY,),
                SizedBox(height: 5,),
                InfoCardGridView(list:demoUserM,crossAxisCount: Responsive.isMobile(context) ? 2 : 4,),
              ],
            ),
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
                DataColumn(label: Text('ID Người dùng')),
                DataColumn(label: Text('Tên Người Dùng',overflow: TextOverflow.ellipsis,)),
                DataColumn(label: Text('Ngày tạo',overflow: TextOverflow.ellipsis)),
              ],
              rows: List.generate(10, (index) => recentDataRow(10)),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentDataRow(int id) {

  return DataRow(
    cells: [
      DataCell(Text('$id')),
      DataCell(Text('Nguyễn Nhật Huy')),
      DataCell(Text('01-06-2020')),
    ],
  );
}

