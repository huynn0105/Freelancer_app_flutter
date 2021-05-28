import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/RecentFile.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            'Công việc gần đây',
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
                DataColumn(label: Text('Tên công việc')),
                DataColumn(label: Text('Ngày')),
                DataColumn(label: Text('Người đăng'))
              ],
              rows: List.generate(demoRecentJob.length, (index) => recentDataRow(demoRecentJob[index])),
            ),
          )
        ],
      ),
    );
  }
}

DataRow recentDataRow(RecentJob recentJob) {
  return DataRow(
    cells: [
      DataCell(Row(
        children: [
          SvgPicture.asset(
            recentJob.avatar,
            height: 30,
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
            child: Text(recentJob.title,),
          ),
        ],
      )),
      DataCell(Text(recentJob.date)),
      DataCell(Text(recentJob.renderName)),
    ],
  );
}