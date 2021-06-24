import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/chat_details_screen.dart';
import 'package:freelance_app/presentation/home/messages/rating/rating_screen.dart';
import 'package:freelance_app/presentation/routes/navigation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../responsive.dart';
import 'chat_controller.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({this.job, this.toUser, this.freelancer});

  final Job job;
  final Account toUser;
  final Account freelancer;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChatController>();
    return Container(
      color:  Colors.grey[100],
      padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 250),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 1,
          title: Row(
            children: [
              BackButton(
                onPressed: () {
                  controller.loadMessageUser().then((value) => Get.back());
                  Get.offAllNamed(Routes.home);
                },
              ),
              CircleAvatar(
                radius: 20,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.grey.shade300,
                child: CachedNetworkImage(
                  imageUrl: 'http://${toUser.avatarUrl}',
                  httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 17,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/avatarnull.png'),
                    radius: 17,
                  ),
                ),
              ),
              SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(job.name,
                        style: TextStyle(
                          fontSize: 17,
                        )),
                    Text(toUser.name,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.loadJob(job.id).then((value) {
                      if (controller.job.value.rating != null)
                        controller.currentStep(3);
                      controller.checkAssign(job.id, freelancer.id)
                          .then((value) => Get.to(() => ChatDetailsScreen(
                                freelancer: freelancer,
                                toUser: toUser,
                              )));
                    });
                  },
                  icon: Icon(Icons.more_vert)),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
                child: Obx(() => ListView.builder(
                    itemCount: controller.chatMessages.length,
                    reverse: true,
                    controller: controller.scrollController,
                    itemBuilder: (context, index) {
                      controller.seenMessage(job.id, freelancer.id);
                      return Message(
                        message: controller.chatMessages[index],
                        toUser: toUser,
                        prevDateTime: index < controller.chatMessages.length - 1
                            ? controller.chatMessages[index + 1].time
                            : null,
                      );
                    })),
              ),
            ),
            ChatInputField(
              ctrMessage: controller.ctrMessage,
              onTap: () {
                controller.sendMessage(job.id, freelancer.id, toUser.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
    @required this.toUser,
    this.prevDateTime,
  }) : super(key: key);
  final ChatMessage message;
  final Account toUser;
  final DateTime prevDateTime;

  @override
  Widget build(BuildContext context) {
    Widget messageContains(ChatMessage message) {
      switch (message.type) {
        case 'Text':
          return Flexible(child: TextMessage(message: message));
        case 'SuggestedPrice':
          if (message.confirmation == null)
            return SuggestPrice(message: message);
          return ConfirmPrice(message: message);
        case 'FinishRequest':
          if (message.confirmation == null)
            return RequestFinished(message: message);
          return ConfirmFinish(
            message: message,
            toUser: toUser,
          );
        case 'Notification':
          return ConfirmAdmin(
            message: message,
            toUser: toUser,
          );
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: message.type != 'Text'
                ? MainAxisAlignment.center
                : message.senderId == CURRENT_ID
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (message.senderId != CURRENT_ID)
                if (message.type == 'Text')
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, right: 10),
                    child: CircleAvatar(
                      radius: 15,
                      foregroundColor: Colors.transparent,
                      backgroundColor: Colors.grey.shade300,
                      child: CachedNetworkImage(
                        imageUrl: 'http://${toUser.avatarUrl}',
                        httpHeaders: {
                          HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                        },
                        placeholder: (context, url) =>
                            CupertinoActivityIndicator(),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 13,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              AssetImage('assets/images/avatarnull.png'),
                          radius: 13,
                        ),
                      ),
                    ),
                  ),
              messageContains(message),
            ],
          ),
          // if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final String status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 3, left: 5),
      height: 15,
      width: 15,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      child: Icon(
        status == 'Seen' ? Icons.done_all : Icons.done,
        size: 12,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class ImageMessage extends StatelessWidget {
  const ImageMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset("assets/images/avatar.jpg"),
        ),
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({Key key, @required this.message}) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd-MM HH:mm');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      margin: message.senderId == CURRENT_ID
          ? EdgeInsets.only(left: 40)
          : EdgeInsets.only(right: 40),
      decoration: BoxDecoration(
        color:
            Colors.blue.withOpacity(message.senderId == CURRENT_ID ? 1 : 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Text(
            message.message,
            maxLines: 20,
            style: TextStyle(
                color: message.senderId == CURRENT_ID
                    ? Colors.white
                    : Colors.black87,
                fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  df.format(message.time),
                  style: TextStyle(
                      fontSize: 12,
                      color: message.senderId == CURRENT_ID
                          ? Colors.white
                          : Colors.black87),
                ),
                if (message.senderId == CURRENT_ID)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      message.status == 'Seen' ? Icons.done_all : Icons.done,
                      size: 15,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RequestFinished extends StatelessWidget {
  RequestFinished({this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChatController>();
    final df = new DateFormat('dd-MM HH:mm');
    return Flexible(
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
      child: message.senderId != CURRENT_ID ? Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 0.0 : 150),
        child: Column(
          children: [
            Text(
              'Yêu cầu kết thúc dự án',
              style: TEXT_STYLE_ON_FOREGROUND,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.currentStep(2);
                controller.finishJob(message.jobId, message.id);
                controller.loadMessageChat(message.jobId, message.freelancerId);
              },
              child: Text(
                'Hoàn thành',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(300, 40),
                  elevation: 0),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                controller.currentStep(2);
                controller.sendRequestRework(message.jobId, message.id);
                controller.loadMessageChat(message.jobId, message.freelancerId);
              },
              child: Text(
                'Yêu cầu làm lại',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(300, 40),
                  elevation: 0),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                controller.currentStep(2);
                controller.sendRequestCancel(message.jobId, message.id);
                controller.loadMessageChat(message.jobId, message.freelancerId);
              },
              child: Text(
                'Huỷ dự án',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(300, 40),
                  elevation: 0),
            ),
          ],
        ),
      ) : Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        children: [
          Text(
            'Bạn đã gửi yêu cầu kết thúc dự án',
            style: TEXT_STYLE_ON_FOREGROUND,
          ),
          SizedBox(width: 5),
          Text(
            df.format(message.time),
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          if (message.senderId == CURRENT_ID)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Icon(
                  message.status == 'Seen' ? Icons.done_all : Icons.done,
                  size: 15,
                  color: Colors.black87),
            ),
        ],
      )


    ));
  }
}

class SuggestPrice extends StatelessWidget {
  final ChatMessage message;

  SuggestPrice({this.message});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChatController>();
    final formatter = new NumberFormat("#,###");
    final df = new DateFormat('dd-MM HH:mm');
    return Flexible(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: message.senderId != CURRENT_ID
              ? Column(
                  children: [
                    Text(
                      'Bạn có đồng ý thực hiện dự án với mức lương ${formatter.format(int.parse(message.message))} VNĐ?',
                      style: TEXT_STYLE_ON_FOREGROUND,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.currentStep(1);
                        controller.confirmSuggestedPrice(message.jobId,
                            message.freelancerId, message.id, true);
                        controller.loadMessageChat(
                            message.jobId, message.freelancerId);
                      },
                      child: Text(
                        'Tôi sẽ hoàn thành nó',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(300, 40),
                          elevation: 0),
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        controller.confirmSuggestedPrice(message.jobId,
                            message.freelancerId, message.id, false);
                        controller.loadMessageChat(
                            message.jobId, message.freelancerId);
                      },
                      child: Text(
                        'Từ chối',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(300, 40),
                          elevation: 0),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          df.format(message.time),
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                        ),
                        if (message.senderId == CURRENT_ID)
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Icon(
                                message.status == 'Seen'
                                    ? Icons.done_all
                                    : Icons.done,
                                size: 15,
                                color: Colors.black87),
                          ),
                      ],
                    ),
                  ],
                )
              : Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  alignment: WrapAlignment.end,
                  children: [
                    Text(
                      'Bạn đã gửi yêu cầu làm việc cho freelancer với mức lương ${formatter.format(int.parse(message.message))}  VNĐ',
                      style: TEXT_STYLE_ON_FOREGROUND,
                    ),
                    Text(
                      df.format(message.time),
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                    if (message.senderId == CURRENT_ID)
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Icon(
                            message.status == 'Seen'
                                ? Icons.done_all
                                : Icons.done,
                            size: 15,
                            color: Colors.black87),
                      ),
                  ],
                )),
    );
  }
}

class ConfirmPrice extends StatelessWidget {
  final ChatMessage message;

  ConfirmPrice({this.message});

  @override
  Widget build(BuildContext context) {
    final df = new DateFormat('dd-MM HH:mm');
    return Flexible(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: message.confirmation == 'Accept'
                ? Colors.green[200]
                : Colors.red[200],
          ),
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              if (message.confirmation == 'Accept')
                Text(
                  'Xác nhận thành công, hãy bắt đầu dự án!',
                  style: TEXT_STYLE_ON_FOREGROUND,
                ),
              if (message.confirmation == 'Decline')
                message.freelancerId != CURRENT_ID
                    ? Text('Freelancer đã từ chối nhận dự án ')
                    : Text('Bạn đã từ chối dự án'),
              Text(
                df.format(message.time),
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
            ],
          )),
    );
  }
}

class ConfirmFinish extends StatelessWidget {
  final ChatMessage message;
  final Account toUser;

  ConfirmFinish({this.message, this.toUser});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return Flexible(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: message.confirmation == 'Finished'
                ? Colors.green[200]
                : Colors.red[200],
          ),
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(children: [
            if (message.confirmation == 'Finished') ...[
              Text('Dự án đã hoàn thành'),
              if (message.freelancerId == CURRENT_ID)
                Text('Bạn sẽ sớm nhận được tiền từ hệ thống'),
              if (controller.job.value.rating == null)
                if (message.freelancerId != CURRENT_ID) ...[
                  Text('Đánh giá freelancer nào!'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => RatingScreen(
                            freelancer: toUser,
                            jobId: message.jobId,
                          ));
                    },
                    child: Text(
                      'Đánh giá',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(300, 40),
                        elevation: 0),
                  ),
                ],
            ],
            if (message.confirmation == 'Request rework') ...[
              if (message.freelancerId == CURRENT_ID)
                Text('Bạn đã gửi yêu cầu làm lại dự án cho freelancer'),
              if (message.freelancerId != CURRENT_ID)
                Text('Chủ dự án đã yêu cầu bạn làm lại'),
            ],
            if (message.confirmation == 'Request cancellation') ...[
              if (message.freelancerId != CURRENT_ID)
                Text('Bạn đã gửi yêu cầu huỷ dự án cho freelancer'),
              if (message.freelancerId == CURRENT_ID)
                Text('Chủ dự án đã yêu cầu huỷ bỏ dự'),
            ]
          ])),
    );
  }
}

class ConfirmAdmin extends StatelessWidget {
  final ChatMessage message;
  final Account toUser;

  ConfirmAdmin({this.message, this.toUser});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatController>();
    return Flexible(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Column(children: [
            if (message.confirmation == 'Finished' || message.confirmation == 'Cancellation') ...[
              Text(message.message),
              if (message.freelancerId == CURRENT_ID)
                if(message.confirmation == 'Finished')
                Text('Bạn sẽ sớm nhận được tiền từ hệ thống'),
              if (controller.job.value.rating == null)
                if (message.freelancerId != CURRENT_ID) ...[
                  Text('Đánh giá freelancer nào!'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => RatingScreen(
                        freelancer: toUser,
                        jobId: message.jobId,
                      ));
                    },
                    child: Text(
                      'Đánh giá',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        minimumSize: Size(300, 40),
                        elevation: 0),
                  ),
                ],
            ],
            if (message.confirmation == 'In progress')
              Text(message.message),
          ])),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key key,
    this.onTap,
    this.ctrMessage,
  }) : super(key: key);

  final TextEditingController ctrMessage;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 3),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 32,
                color: Color(0xFF087949).withOpacity(0.08))
          ]),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: Colors.blue,
          ),
          SizedBox(
            width: kDefaultPadding,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding * 0.75,
              ),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: TextField(
                controller: ctrMessage,
                decoration: InputDecoration(
                  hintText: 'Aa',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding,
          ),
          IconButton(
            onPressed: onTap,
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
