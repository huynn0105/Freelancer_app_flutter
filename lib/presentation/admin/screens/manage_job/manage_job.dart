import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/my_feilds.dart';
import 'package:freelance_app/presentation/admin/screens/main/components/recent_job.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';

class ManageJob extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                    rows: List.generate(10, (index) => recentDataRow()),
                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

DataRow recentDataRow() {

  return DataRow(
    cells: [
      DataCell(Text('1')),
      DataCell(Text('Thiết kế ứng dụng freelancer')),
      DataCell(Text('1')),
      DataCell(Text('Nguyễn Nhật Huy')),
      DataCell(ElevatedButton(onPressed: (){
        Get.defaultDialog(
            title: 'Chi tiết công việc',
            content: Expanded(child: Container(child: JobDetail(),width: 500,height: 700,))
        );
      }, child: Text('Xem'),style: ElevatedButton.styleFrom(primary: Colors.green),)),
    ],
  );
}

class JobDetail extends StatelessWidget {
  const JobDetail({
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

            TextField(
              decoration: InputDecoration(
                labelText: 'Tên công việc'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Mô tả công việc'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Địa điểm'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Kỹ năng'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Hình thức làm việc'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Loại hình làm việc'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Hình thức trả lương'
              ),
              readOnly: true,
            ),
            SizedBox(height: kDefaultPadding),
            Row(
              children: [
                Expanded(child:TextField(
                  decoration: InputDecoration(
                      labelText: 'Ngân sách'
                  ),
                  readOnly: true,
                ),),
                SizedBox(width: kDefaultPadding,),
                Expanded(child:TextField(
                  decoration: InputDecoration(
                      labelText: 'Ngân sách'
                  ),
                  readOnly: true,
                ),)
              ],
            ),
            SizedBox(height: kDefaultPadding),
            CheckboxListTile(value: true, onChanged: (_){}, title: Text('Bí mật'),)

          ],
        ),
      ),
    );
  }
}
