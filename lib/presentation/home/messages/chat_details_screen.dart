
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/setup_payment.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatDetailsScreen extends StatelessWidget {
  final int freelancerId;


  const ChatDetailsScreen({this.freelancerId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChatController>();
    final formatter = new NumberFormat("#,###");
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.job.value.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Obx(
          () => ListView(
            children: [
              if (controller.status.value == 'In discussion')...[
                ListTile(
                  title:  Text('Dự án đang trong quá trình thảo luận'),
                  leading: Icon(Icons.connect_without_contact,color: Colors.amber),),

                Text('Chủ dự án', style: TEXT_STYLE_PRIMARY),
                SizedBox(height: kDefaultPadding / 4),
                Text(
                  controller.job.value.renter.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                if (CURRENT_ID == controller.job.value.renter.id)
                  ElevatedButton(
                      onPressed: () {
                        Get.to(() => SetupPayment(
                          job: controller.job.value,
                          freelancerId: controller.job.value.freelancer.id,
                        ));
                      },
                      child: Text('Giao việc')),
              ],
              if(controller.job.value.freelancer!=null)
              if(CURRENT_ID ==  controller.job.value.freelancer.id || CURRENT_ID == controller.job.value.renter.id)...[
                if(controller.status.value == 'Stop discussion')
                  ListTile(
                    title: Text('Dự án đã đóng'),
                    leading: Icon(Icons.cancel_outlined,color: Colors.red),
                  ),
                if(controller.status.value == 'Finished')
                  ListTile(
                      title:  Text('Dự án đã hoàn thành'),
                      leading: Icon(Icons.done,color: Colors.green)
                  ),
                if(controller.status.value == 'In progress')
                  ListTile(
                    title:  Text('Dự án đang trong quá trình thực hiện'),
                    leading: Icon(Icons.hourglass_empty,color: Colors.blue),),
                if(controller.status.value == 'In progress')...[
                  Text('Số tiền dự án: ${formatter.format(controller.job.value.price)} VNĐ',style: TEXT_STYLE_PRIMARY),
                  SizedBox(height: kDefaultPadding / 2),
                  Text('Chủ dự án', style: TEXT_STYLE_PRIMARY),
                  SizedBox(height: kDefaultPadding / 4),
                  Text(
                    controller.job.value.renter.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: kDefaultPadding / 3),
                  Text('Freelancer', style: TEXT_STYLE_PRIMARY),
                  SizedBox(height: kDefaultPadding / 4),
                  Text(
                    controller.job.value.freelancer.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
                Divider(),
                SizedBox(height: kDefaultPadding / 2),
                Text('Tuỳ chọn', style: TEXT_STYLE_PRIMARY),
                SizedBox(height: kDefaultPadding / 4),
                freelancerId == CURRENT_ID
                    ? ListTile(
                  onTap: () {
                    controller.sendFinishRequest(controller.job.value.id);
                  },
                  leading: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  title: Text(
                    'Yêu cầu kết thúc dự án',
                    style: TextStyle(fontSize: 18),
                  ),
                )
                    : ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                  ),
                  title: Text('Yêu cầu huỷ dự án',
                      style: TextStyle(fontSize: 18)),
                ),
              ]


            ],
          ),
        ),
      ),
    );
  }
}
