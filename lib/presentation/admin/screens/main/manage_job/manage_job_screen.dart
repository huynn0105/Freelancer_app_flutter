import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ManageJobScreen extends GetWidget<AdminController> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: Responsive.isDesktop(context) ? EdgeInsets.symmetric(vertical: kDefaultPadding,horizontal: kDefaultPadding*3) : EdgeInsets.all(kDefaultPadding/2),
      child:  Obx(
        ()=> controller.progressState.value == sState.initial
            ? controller.jobs.isNotEmpty ? Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(
                Radius.circular(kDefaultPadding / 2)),
          ),
          child:
          DataTable(
            columnSpacing: kDefaultPadding,
            horizontalMargin: kDefaultPadding,
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Tên Công việc',overflow: TextOverflow.ellipsis,)),
              DataColumn(label: Text('FreelancerId',overflow: TextOverflow.ellipsis)),
              DataColumn(label: Text('Người đăng',overflow: TextOverflow.ellipsis)),
              DataColumn(label: Text('Ngày đăng',overflow: TextOverflow.ellipsis)),
              DataColumn(label: Text('Tuỳ chọn',overflow: TextOverflow.ellipsis)),
            ],
            rows: List.generate(controller.jobs.length, (index) => recentDataRow(controller.jobs[index])),
          )
        ): Center(child: Text('Chưa có công việc nào được đăng'),): Center(child: CircularProgressIndicator(),),
      ),
    );
  }

  DataRow recentDataRow(Job job) {
    final df = new DateFormat('dd-MM-yyyy');
    return DataRow(
      cells: [
        DataCell(Text('${job.id}')),
        DataCell(Text(job.name),),
        DataCell(Text('${job.renter.id}')),
        DataCell(Text(job.renter.name)),
        DataCell(Text('${df.format(job.createAt)}')),
        DataCell(ElevatedButton(onPressed: () async{
          Job result = await controller.loadJobFromId(job.id);
          Get.defaultDialog(
              title: 'CHI TIẾT CÔNG VIỆC',
              titleStyle: TEXT_STYLE_PRIMARY,
              radius: 10,
              content: JobDetail(job: result)
          );
        }, child: Text('Xem'),style: ElevatedButton.styleFrom(primary: Colors.green),)),
      ],
    );
  }
}



class JobDetail extends StatelessWidget {
  const JobDetail({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(kDefaultPadding),
        width: Responsive.isDesktop(context) ? size.width*0.4 : size.width*0.75,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              ItemRow(title: 'Tên công việc',content: job.name),
              Divider(),
              ItemRow(title: 'Mô tả công việc',content: job.details,),
              Divider(),
              ItemRow(title: 'Địa điểm làm việc',content: job.province != null ? job.province.name : 'Toàn quốc'),
              Divider(),
              ItemRow(title: 'Kỹ năng yêu cầu',content: 'Flutter, Android, C++, PHP, C#, ASP.net'),
              Divider(),
              ItemRow(title: 'Hình thức làm việc',content: job.formOfWork.name),
              Divider(),
              ItemRow(title: 'Loại hình làm việc',content: job.typeOfWork.name),
              Divider(),
              ItemRow(title: 'Hình thức trả lương',content: job.payform.name),
              Divider(),
              ItemRow(title: 'Ngân sách',content: '${job.floorprice} - ${job.cellingprice} VNĐ',),
              Divider(),
              ItemRow(title: 'Tuỳ chọn hiển thị',content: 'Công khai'),
              Divider(),

            ],
          ),
        ),
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  const ItemRow({
    Key key,
    @required this.title,
    @required this.content,
  }) : super(key: key);
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(child: Text(title,style: TextStyle(color: Colors.black54),),width: 200,),
          Expanded(child: Text(content)),
        ],
      ),
    );
  }
}
