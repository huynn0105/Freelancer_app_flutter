import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                  DataColumn(label: Text('ID Người dùng')),
                  DataColumn(label: Text('Tên Người Dùng',overflow: TextOverflow.ellipsis,)),
                  DataColumn(label: Text('Ngày tạo',overflow: TextOverflow.ellipsis)),
                ],
                rows: List.generate(10, (index) => recentDataRow(10)),
              ),
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
      DataCell(Text('Nguyễn Nhật Huy')),
      DataCell(Text('01-06-2020')),
    ],
  );
}

