import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/admin/admin_controller.dart';
import 'package:freelance_app/presentation/widgets/rounded_button.dart';
import 'package:freelance_app/responsive.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  final controller = Get.find<AdminController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Responsive.isDesktop(context)
          ? EdgeInsets.symmetric(
              vertical: kDefaultPadding, horizontal: kDefaultPadding * 3)
          : EdgeInsets.all(kDefaultPadding / 2),
      child: Obx(
        () => controller.progressState.value == sState.initial
            ? controller.requests.isNotEmpty
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
                        DataColumn(label: Text('Tên công việc')),
                        DataColumn(
                            label: Text(
                          'Chủ dự án',
                          overflow: TextOverflow.ellipsis,
                        )),
                        DataColumn(
                            label: Text('Freelancer',
                                overflow: TextOverflow.ellipsis)),
                        DataColumn(
                            label: Text('Loại yêu cầu',
                                overflow: TextOverflow.ellipsis)),
                        DataColumn(
                            label: Text('Tuỳ chọn',
                                overflow: TextOverflow.ellipsis)),
                      ],
                      rows: List.generate(controller.requests.length,
                          (index) => recentDataRow(controller.requests[index])),
                    ),
                  )
                : Center(
                    child: Text('Hiện không có yêu cầu nào!',style: TextStyle(fontSize: 22),),
                  )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  DataRow recentDataRow(Job job) {
    return DataRow(
      cells: [
        DataCell(Text(job.name)),
        DataCell(Text(job.renter.name)),
        DataCell(Text(job.freelancer.name)),
        DataCell(Text(job.status)),
        DataCell(ElevatedButton(
          onPressed: () {
            controller
                .loadMessageChat(job.id)
                .then((value) => Get.defaultDialog(
                    title: 'Chi tiết',
                    content: Expanded(
                        child: Container(
                      child: ReportDetail(job: job),
                      width: 800,
                      height: 700,
                    ))));
          },
          child: Text('Xem'),
          style: ElevatedButton.styleFrom(primary: Colors.green),
        )),
      ],
    );
  }
}

class ReportDetail extends StatelessWidget {
  const ReportDetail({
    Key key,
    this.job,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    final df = new DateFormat('dd-MM  HH:mm');
    final formatter = new NumberFormat("#,###");
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
            Text(
              job.name,
              style: TEXT_STYLE_PRIMARY,
            ),
            SizedBox(height: kDefaultPadding/2),
            Row(
              children: [
                Text('Chủ dự án:'),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Text(
                  job.renter.name,
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding/2),
            Row(
              children: [
                Text('Freelancer:'),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Text(
                  job.freelancer.name,
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding/2),
            Row(
              children: [
                Text('Số tiền thực hiện dự án'),
                SizedBox(width: kDefaultPadding),
                Text(
                  formatter.format(job.price),
                  style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: kDefaultPadding/2),
            Row(
              children: [
                Text('Loại yêu cầu'),
                SizedBox(width: kDefaultPadding),
                Text(
                  job.status,
                  style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(
              height: kDefaultPadding),
            Text('Tin nhắn'),
            SizedBox(
              height: kDefaultPadding/3),
            Container(
              width: 800,
              height: 300,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: controller.chatMessages.isNotEmpty
                  ? ListView.builder(
                      itemCount: controller.chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = controller.chatMessages[index];
                        return ListTile(
                          leading: Text(
                              message.senderId == job.renter.id
                                  ? '${job.renter.name} (Chủ dự án)   ${df.format(message.time)}:'
                                  : '${job.freelancer.name} (Freelancer)   ${df.format(message.time)}:',
                              style: TextStyle(
                                  color: message.senderId == job.renter.id
                                      ? Colors.green
                                      : Colors.blue,
                                  fontWeight: FontWeight.w500)),
                          title: Row(
                            children: [

                              SizedBox(width: 14),
                              if (message.type == 'SuggestedPrice')
                                Expanded(
                                  child: Text(
                                      '${job.freelancer.name} ${message.confirmation == 'Decline' ? 'đồng ý' : 'từ chối'} dự án với số tiền ${message.message}'),
                                ),
                              if (message.type == 'FinishRequest')
                                Expanded(child: Text(message.message)),
                              if (message.type == 'Text') Text(message.message),

                            ],
                          ),
                        );
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              children: [
                if(job.status == 'Request cancellation')...[
                  Expanded(
                      child: RoundedButton(
                        onTap: () {
                          showDialog(context: context,builder: (_){
                            final ctrlText= TextEditingController();
                            return AlertDialog(
                              title: Text('Lý do bạn đưa ra quyết định này'),
                              content: Container(
                                width: 500,
                                child: TextField(controller: ctrlText,maxLines: 6,decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.all(16),),),
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Huỷ',style: TextStyle(fontSize: 18),),
                                )),
                                TextButton(onPressed: (){
                                  controller.sendConfirmRequest(job.id,'Cancellation',CURRENT_ID,ctrlText.text);
                                  print('data gửi: ${job.id}, Cancellation,$CURRENT_ID,${ctrlText.text}');
                                  }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Gửi yêu cầu',style: TextStyle(fontSize: 18,color: Colors.red),),
                                )),
                              ],
                            );
                          });

                        },
                        child: Text(
                          'Chấp nhận yêu cầu',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      )),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Expanded(
                      child: RoundedButton(
                        onTap: () {
                          showDialog(context: context,builder: (_){
                            final ctrlText= TextEditingController();
                            return AlertDialog(
                              title: Text('Lý do bạn đưa ra quyết định này'),
                              content: Container(
                                width: 500,
                                child: TextField(controller: ctrlText,maxLines: 6,decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.all(16),),),
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Huỷ',style: TextStyle(fontSize: 18),),
                                )),
                                TextButton(onPressed: (){
                                  controller.sendConfirmRequest(job.id,'Finished',CURRENT_ID,ctrlText.text);
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Gửi yêu cầu',style: TextStyle(fontSize: 18,color: Colors.red),),
                                )),
                              ],
                            );
                          });
                        },
                        child: Text(
                          'Huỷ yêu cầu',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      )),
                  SizedBox(
                      width: kDefaultPadding),
                  Expanded(
                      child: RoundedButton(
                        onTap: () {
                          showDialog(context: context,builder: (_){
                            final ctrlText= TextEditingController();
                            return AlertDialog(
                              title: Text('Lý do bạn đưa ra quyết định này'),
                              content: Container(
                                width: 500,
                                child: TextField(controller: ctrlText,maxLines: 6,decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.all(16),),),
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Huỷ',style: TextStyle(fontSize: 18),),
                                )),
                                TextButton(onPressed: (){
                                  controller.sendConfirmRequest(job.id,'In progress',CURRENT_ID,ctrlText.text);
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Gửi yêu cầu',style: TextStyle(fontSize: 18,color: Colors.red),),
                                )),
                              ],
                            );
                          });
                        },
                        child: Text(
                          'Cho dự án tiếp tục làm',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      )),
                ],
                if(job.status == 'Request rework')...[
                  Expanded(
                      child: RoundedButton(
                        onTap: () {
                          showDialog(context: context,builder: (_){
                            final ctrlText= TextEditingController();
                            return AlertDialog(
                              title: Text('Lý do bạn đưa ra quyết định này'),
                              content: Container(
                                width: 500,
                                child: TextField(controller: ctrlText,maxLines: 6,decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.all(16),),),
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Huỷ',style: TextStyle(fontSize: 18),),
                                )),
                                TextButton(onPressed: (){
                                  controller.sendConfirmRequest(job.id,'In progress',CURRENT_ID,ctrlText.text);
                                  print('data gửi: ${job.id}, In progress,$CURRENT_ID,${ctrlText.text}');
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Gửi yêu cầu',style: TextStyle(fontSize: 18,color: Colors.red),),
                                )),
                              ],
                            );
                          });

                        },
                        child: Text(
                          'Chấp nhận yêu cầu',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      )),
                  SizedBox(
                    width: kDefaultPadding,
                  ),
                  Expanded(
                      child: RoundedButton(
                        onTap: () {
                          showDialog(context: context,builder: (_){
                            final ctrlText= TextEditingController();
                            return AlertDialog(
                              title: Text('Lý do bạn đưa ra quyết định này'),
                              content: Container(
                                width: 500,
                                child: TextField(controller: ctrlText,maxLines: 6,decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: EdgeInsets.all(16),),),
                              ),
                              actions: [
                                TextButton(onPressed: (){
                                  Get.back();
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Huỷ',style: TextStyle(fontSize: 18),),
                                )),
                                TextButton(onPressed: (){
                                  controller.sendConfirmRequest(job.id,'Finished',CURRENT_ID,ctrlText.text);
                                }, child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text('Gửi yêu cầu',style: TextStyle(fontSize: 18,color: Colors.red),),
                                )),
                              ],
                            );
                          });
                        },
                        child: Text(
                          'Huỷ yêu cầu',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      )),

                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
