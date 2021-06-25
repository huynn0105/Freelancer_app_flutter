import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/home_controller.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/rating/rating_screen.dart';
import 'package:freelance_app/presentation/home/messages/setup_payment.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../responsive.dart';

class ChatDetailsScreen extends StatelessWidget {
  final Account toUser;
  final Account freelancer;

  const ChatDetailsScreen({this.freelancer, this.toUser});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChatController>();
    var homeController = Get.find<HomeController>();
    final formatter = new NumberFormat("#,###");
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.job.value.name),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Obx(
            () => ListView(
              children: [
                if (controller.status.value == 'In discussion')
                  ListTile(
                    horizontalTitleGap: 0.0,
                    title: Text(
                      'Dự án đang trong quá trình thảo luận',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.amber,
                          fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(CupertinoIcons.bubble_left_bubble_right,
                        color: Colors.amber),
                  ),
                if (controller.job.value.freelancer != null)
                  if (CURRENT_ID == controller.job.value.freelancer.id ||
                      CURRENT_ID == controller.job.value.renter.id) ...[
                    if (controller.status.value == 'Stop discussion')
                      ListTile(
                        horizontalTitleGap: 0.0,
                        title: Text(
                          'Dự án đã đóng',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w500),
                        ),
                        leading:
                            Icon(CupertinoIcons.xmark_circle, color: Colors.red),
                      ),
                    if (controller.status.value == 'Finished')
                      ListTile(
                          horizontalTitleGap: 0.0,
                          title: Text(
                            'Dự án đã hoàn thành',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(CupertinoIcons.check_mark_circled,
                              color: Colors.green)),
                    if (controller.status.value == 'In progress')
                      ListTile(
                        horizontalTitleGap: 0.0,
                        title: Text(
                          'Dự án đang trong quá trình thực hiện',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500),
                        ),
                        leading: Icon(CupertinoIcons.slowmo, color: Colors.blue),
                      ),
                    if (controller.status.value == 'In progress' ||
                        controller.status.value == 'Finished') ...[
                      ListTile(
                          horizontalTitleGap: 0.0,
                          minVerticalPadding: 0.0,
                          title: Text(
                            'Số tiền dự án ${formatter.format(controller.job.value.price)} VNĐ',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.w500),
                          ),
                          leading: Icon(CupertinoIcons.money_dollar_circle,
                              color: Colors.green)),
                    ],
                    Divider(),
                    SizedBox(height: 10),
                    Text('Thành viên',
                        style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 17)),
                    SizedBox(height: kDefaultPadding / 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.grey.shade300,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'http://${controller.job.value.avatarUrl}',
                              httpHeaders: {
                                HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                              },
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                radius: 20,
                              ),
                              errorWidget: (context, url, error) => CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage:
                                    AssetImage('assets/images/avatarnull.png'),
                                radius: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.job.value.renter.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                  'Chủ dự án ${freelancer.id == CURRENT_ID ? '' : ' - Tôi'}')
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            foregroundColor: Colors.transparent,
                            backgroundColor: Colors.grey.shade300,
                            child: CachedNetworkImage(
                              imageUrl: CURRENT_ID !=
                                      controller.job.value.renter.id
                                  ? 'http://${homeController.account.value.avatarUrl}'
                                  : 'http://${toUser.avatarUrl}',
                              httpHeaders: {
                                HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                              },
                              placeholder: (context, url) =>
                                  CupertinoActivityIndicator(),
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                radius: 20,
                              ),
                              errorWidget: (context, url, error) => CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage:
                                    AssetImage('assets/images/avatarnull.png'),
                                radius: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                CURRENT_ID != controller.job.value.renter.id
                                    ? homeController.account.value.name
                                    : toUser.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                  'Freelancer${freelancer.id != toUser.id ? ' - Tôi' : ''}')
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: kDefaultPadding / 2),
                    Divider(),
                  ],
                Text('Giai đoạn',
                    style: TEXT_STYLE_PRIMARY.copyWith(fontSize: 17)),
                Stepper(
                  steps: [
                    Step(
                        isActive: true,
                        state: controller.currentStep.value == 0
                            ? StepState.indexed
                            : StepState.complete,
                        title: Text(
                          "Thảo luận",
                          style: TextStyle(fontSize: 16),
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if(controller.job.value.renter.id == CURRENT_ID)...[
                            if (controller.assign.value) ...[
                              Text("Nạp tiền vào dự án để bắt đầu làm việc",
                                  style: TextStyle(fontSize: 16)),
                              ElevatedButton.icon(
                                icon: Icon(CupertinoIcons.money_dollar_circle),
                                onPressed: () {
                                  Get.off(() => SetupPayment(
                                        job: controller.job.value,
                                        freelancer: freelancer,
                                        toUser: toUser,
                                      ));
                                },
                                label: Text('Nạp tiền vào dự án'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    minimumSize: Size(220, 40)),
                              ),
                            ],
                            if(!controller.assign.value)...[
                              Text('Bạn đã nạp ${formatter.format(controller.job.value.price)} VNĐ vào dự án, hãy chờ freelancer xác nhận'),
                              SizedBox(height: 5),
                              ElevatedButton.icon(
                                  icon: Icon(CupertinoIcons.clear_circled),
                                  onPressed: () {
                                    controller.undo(controller.job.value.id,freelancer.id );
                                    controller
                                        .loadMessageChat(controller.job.value.id,
                                        freelancer.id)
                                        .then((value) => Get.back());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      minimumSize: Size(220, 40)),
                                  label: Text('Thu hồi tiền đã nạp vào dự án')),
                            ]
                          ],
                            if(freelancer.id == CURRENT_ID)
                              Text('Đang trong quá trình thảo luận')
      ],

                        )),
                    Step(
                      isActive: true,
                      state: controller.currentStep.value <= 1
                          ? StepState.indexed
                          : StepState.complete,
                      title: Text("Đang làm", style: TextStyle(fontSize: 16)),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                            if (controller.job.value.renter.id == CURRENT_ID)
                              ElevatedButton.icon(
                                  icon: Icon(CupertinoIcons.clear_circled),
                                  onPressed: () {
                                    controller.checkRequest(controller.job.value.id, freelancer.id).then((value){
                                      if(value){
                                        controller.sendRequestCancel(
                                            controller.job.value.id, 0);
                                        controller
                                            .loadMessageChat(controller.job.value.id,
                                            freelancer.id)
                                            .then((value) => Get.back());
                                      }
                                        else{
                                        Get.snackbar('Lỗi','Đã có 1 lệnh yêu cầu được gửi lên',
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            maxWidth: 600,
                                            snackPosition: SnackPosition.TOP);
                                      }
                                    });

                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                      minimumSize: Size(220, 40)),
                                  label: Text('Yêu cầu huỷ dự án')),
                            if (controller.job.value.freelancer != null)
                              if (controller.job.value.freelancer.id == CURRENT_ID)
                                ElevatedButton.icon(
                                  onPressed: () {
                                    controller.checkRequest(controller.job.value.id, freelancer.id).then((value){
                                      if(value){
                                        controller.sendFinishRequest(
                                            controller.job.value.id);
                                        controller
                                            .loadMessageChat(controller.job.value.id,
                                            freelancer.id)
                                            .then((value) => Get.back());
                                      }
                                      else
                                        Get.snackbar('Lỗi','Đã có 1 lệnh yêu cầu được gửi lên',
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white,
                                            maxWidth: 600,
                                            snackPosition: SnackPosition.TOP);
                                    });

                                  },
                                  icon: Icon(CupertinoIcons.check_mark_circled),
                                  label: Text('Yêu cầu kết thúc dự án'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green,
                                      minimumSize: Size(220, 40)),
                                ),



                        ],
                      ),
                    ),
                    Step(
                      isActive: true,
                      state: controller.currentStep.value <= 2
                          ? StepState.indexed
                          : StepState.complete,
                      title: Text("Đánh giá", style: TextStyle(fontSize: 16)),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (freelancer.id != CURRENT_ID) ...[
                            Text('Đánh giá cho freelancer',
                                style: TextStyle(fontSize: 16)),
                            ElevatedButton.icon(
                              icon: Icon(CupertinoIcons.star),
                              onPressed: () {
                                Get.to(() => RatingScreen(
                                      freelancer: toUser,
                                      jobId: controller.job.value.id,
                                    ));
                              },
                              label: Text('Đánh giá'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.amber,
                                  minimumSize: Size(220, 40)),
                            ),
                          ],
                          if (freelancer.id == CURRENT_ID)
                            Text('Đang chờ chủ dự án đánh giá',
                                style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Step(
                      isActive: true,
                      state: controller.currentStep.value == 3
                          ? StepState.complete
                          : StepState.indexed,
                      title: Text("Kết thúc", style: TextStyle(fontSize: 16)),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dự án đã kết thúc',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                  currentStep: controller.currentStep.value,
                  controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) =>
                      Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
