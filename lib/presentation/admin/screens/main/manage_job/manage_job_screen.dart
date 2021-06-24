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
      padding: Responsive.isDesktop(context)
          ? EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 3)
          : EdgeInsets.all(kDefaultPadding / 2),
      child: Obx(
        () => controller.progressState.value == sState.initial
            ? controller.jobs.isNotEmpty
                ? Container(
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
                        DataColumn(
                            label: Text(
                          'Tên Công việc',
                          overflow: TextOverflow.ellipsis,
                        )),
                        DataColumn(
                            label: Text('Ngày tạo',
                                overflow: TextOverflow.ellipsis)),
                        DataColumn(
                            label: Text('Người đăng',
                                overflow: TextOverflow.ellipsis)),
                        DataColumn(
                            label: Text('Trạng thái',
                                overflow: TextOverflow.ellipsis)),
                        DataColumn(
                            label: Text('Tuỳ chọn',
                                overflow: TextOverflow.ellipsis)),
                      ],
                      rows: List.generate(
                          controller.jobs.length,
                          (index) =>
                              recentDataRow(controller.jobs[index], context)),
                    ))
                : Center(
                    child: Text('Chưa có công việc nào được đăng'),
                  )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  DataRow recentDataRow(Job job, context) {
    print('Ngày đăng ${job.createAt.toString()}');
    final df = new DateFormat('dd-MM-yyyy');
    return DataRow(
      cells: [
        DataCell(Text('${job.id}')),
        DataCell(SizedBox(width: 200,child: Text(job.name)),),
        DataCell(Text(job.createAt!=null ? '${df.format(job.createAt)}': '')),
        DataCell(Text(job.renter.name)),
        DataCell(Text(job.status)),
        DataCell(ElevatedButton(
          onPressed: () async {
            await controller.loadJobFromId(job.id).then((value){
              print('tra: ${value.name}');
              if(value!=null)
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.all(10),
                        content: Container(
                          width: 600,
                            child: JobDetail(job: value))));
            });
          },
          child: Text('Xem'),
          style: ElevatedButton.styleFrom(primary: Colors.green),
        )),
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
    final df = new DateFormat('dd-MM-yyyy');

    String convertStatus(String status){
      switch(status){
        case 'Finished':
          return 'Đã hoàn thành';
        case 'Finished':
          return 'In progress';
        case 'Request finish':
          return 'Yêu cầu kết thúc';
        case 'Request rework':
          return 'Yêu cầu làm lại';
        case 'Request cancellation':
          return 'Yêu cầu huỷ';
        case 'Cancellation':
          return 'Đã huỷ';
        case 'Waiting':
          return 'Đang chờ';
        case 'Closed':
          return 'Đã đóng';
        default : return 'Đang chờ';
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('CHI TIẾT CÔNG VIỆC'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.clear), onPressed: () => Get.back())
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(kDefaultPadding/2),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  child: Text('Thông tin công việc',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                ),
              ),

              ItemRow(title: 'Tên công việc', content: job.name),
              Divider(),
              ItemRow(
                title: 'Trạng thái',
                content: convertStatus(job.status),
              ),
              Divider(),
              ItemRow(
                title: 'Ngày đăng',
                content:job.createAt!=null ? df.format(job.createAt) : '',
              ),
              Divider(),
              ItemRow(
                title: 'Bắt đầu làm lúc',
                content:job.startAt!=null ? df.format(job.startAt) : '',
              ),
              Divider(),
              ItemRow(
                title: 'Kết thúc lúc',
                content: job.finishAt!=null ? df.format(job.finishAt) : '',
              ),
              Divider(),
              ItemRow(
                title: 'Mô tả công việc',
                content: job.details,
              ),
              Divider(),
              ItemRow(
                  title: 'Địa điểm làm việc',
                  content:
                      job.province != null ? job.province.name : 'Toàn quốc'),
              Divider(),
              Padding(padding: EdgeInsets.symmetric(vertical: 7),child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Kỹ năng yêu cầu',
                      style: TextStyle(color: Colors.black54),
                    ),
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  ),
                  Expanded(child: Wrap(
                    children: List.generate(job.skills.length, (index){
                      if(index<job.skills.length-1)
                        return Text('${job.skills[index].name}, ');
                      return Text(job.skills[index].name);
                    }),
                  )),
                ],
              ),),
              Divider(),
              ItemRow(
                  title: 'Hình thức làm việc', content: job.formOfWork.name),
              Divider(),
              ItemRow(
                  title: 'Loại hình làm việc', content: job.typeOfWork.name),
              Divider(),
              ItemRow(title: 'Hình thức trả lương', content: job.payform.name),
              Divider(),
              ItemRow(
                title: 'Ngân sách',
                content: '${job.floorprice} - ${job.cellingprice} VNĐ',
              ),
              Divider(),
              ItemRow(title: 'Tuỳ chọn hiển thị', content: 'Công khai'),
              Divider(),
              ItemRow(title: 'Đăng vào', content: '${df.format(job.createAt)}'),
              Divider(),
              ItemRow(title: 'Hến hạng nhận hồ sơ', content: '${df.format(job.deadline)}'),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  child: Text('Thông tin nhà tuyển dụng',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                ),
              ),
              ItemRow(title: 'Id nhà tuyển dụng', content: '${job.renter.id}'),
              Divider(),
              ItemRow(title: 'Tên nhà tuyển dụng', content: job.renter.name),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
                  child: Text('Thông tin freelancer',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                ),
              ),
              ItemRow(title: 'Id freelancer', content:job.freelancer!=null ? '${job.freelancer.id}' : ''),
              Divider(),
              ItemRow(title: 'Tên freelancer', content:job.freelancer!=null ? '${job.freelancer.name}' : ''),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
            child: Text(
              title,
              style: TextStyle(color: Colors.black54),
            ),
            width: 200,
          ),
          Expanded(child: Text(content)),
        ],
      ),
    );
  }
}
