import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/setup_payment.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:signalr_core/signalr_core.dart';
import 'chat_controller.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({this.job, this.toUser, this.freelancerId});

  final Job job;
  final Account toUser;
  final int freelancerId;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ChatController>();
    final ctrlPrice = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Row(
          children: [
            BackButton(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(job.name,style: TextStyle(
              fontSize: 17,

              )),
                  Text(toUser.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey
                      )),
                ],
              ),
            ),
            if(freelancerId!=CURRENT_ID)
              // IconButton(onPressed: () {
              //
              //   GlobalKey<FormState> formKey = GlobalKey<FormState>();
              //   showDialog(context: context, builder: (_)=>AlertDialog(
              //     title: Text('Số tiền bạn sẽ trả cho freelancer sau khi hoàn thành dự án'),
              //     contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              //     content: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //
              //         Form(
              //           key: formKey,
              //           child: TextFormField(
              //             keyboardType: TextInputType.number,
              //             controller: ctrlPrice,
              //            validator: RequiredValidator(errorText: 'Không được bỏ trống'),
              //             inputFormatters: [ThousandsFormatter()],
              //             decoration: InputDecoration(
              //               suffixIcon: Padding(
              //                   padding: EdgeInsets.all(15),
              //                   child: Text(
              //                     'VNĐ',
              //                     style: TextStyle(color: Colors.black54),
              //                   )),
              //             ),
              //           ),
              //         ),
              //
              //         SizedBox(height: 10),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             TextButton(onPressed: (){
              //               Get.back();
              //             }, child: Text('Huỷ',style: TextStyle(color: Colors.red),),),
              //             TextButton(onPressed: (){
              //               var price = int.parse(ctrlPrice.text.replaceAll(',', ''));
              //               if(formKey.currentState.validate())
              //               controller.setupPrice(job.id, freelancerId, price);
              //               Get.back();
              //               controller.chatMessages.insert(0, ChatMessage(
              //                 time: DateTime.now(),
              //                 sender: Account(id: CURRENT_ID),
              //                 job: job,
              //                 type: ChatMessageType.request,
              //                 money: price
              //               ));
              //             }, child: Text('Xác nhận')),
              //           ],
              //         ),
              //
              //       ],
              //     ),
              //
              //   ));
              // }, icon: Icon(Icons.add),
              //
              // )
            ElevatedButton(
                onPressed: () {
                  Get.to(() => SetupPayment());
                },
                child: Text('Giao việc'))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.chatMessages.length,
                  reverse: true,
                  controller: controller.scrollController,
                  itemBuilder: (context, index) => Message(
                    message: controller.chatMessages[index],
                    avatarUrl: toUser.avatarUrl,
                    prevDateTime: index<controller.chatMessages.length-1? controller.chatMessages[index+1].time : null,
                  ),
                ),
              ),
            ),
          ),
          ChatInputField(
            ctrMessage: controller.ctrMessage,
            onTap: () {
              controller.sendMessage(job.id, freelancerId, toUser.id);
            },
          )
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
    @required this.avatarUrl,
    this.prevDateTime,
  }) : super(key: key);
  final ChatMessage message;
  final String avatarUrl;
  final DateTime prevDateTime;

  @override
  Widget build(BuildContext context) {

    Widget messageContains(ChatMessage message) {
      switch (message.type) {
        case ChatMessageType.text:
          return  Flexible(
              child: TextMessage(message: message));
        case ChatMessageType.request:
          return ConfirmWork(money: message.money,message: message,);
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(prevDateTime!=null)
            if(message.time
                .difference(prevDateTime)
                .inDays >= 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Center(child: Text(DateFormat('dd/MM').format(message.time)),),
              ),
          Row(
            mainAxisAlignment: message.sender.id == CURRENT_ID
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              if (message.sender.id != CURRENT_ID)
                Padding(
                  padding: const EdgeInsets.only(bottom: 5,right: 10),
                  child: CircleAvatar(
                    radius: 15,
                    foregroundColor: Colors.transparent,
                    backgroundColor: Colors.grey.shade300,
                    child: CachedNetworkImage(
                      imageUrl: 'http://$avatarUrl',
                      httpHeaders: {
                        HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                      },
                      placeholder: (context, url) => CupertinoActivityIndicator(),
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
    final df = new DateFormat('HH:mm');
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: 15
      ),
      margin: message.sender.id == CURRENT_ID
          ? const EdgeInsets.only(left: 30)
          : const EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
        color:
            Colors.blue.withOpacity(message.sender.id == CURRENT_ID ? 1 : 0.1),
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
                color:
                    message.sender.id == CURRENT_ID ? Colors.white : Colors.black87,
                fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(df.format(message.time),style: TextStyle(fontSize: 13,color: message.sender.id == CURRENT_ID ? Colors.white : Colors.black87),),
                if(message.sender.id == CURRENT_ID)
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
    final df = new DateFormat('HH:mm');
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.all(20),
        child: message.sender.id != CURRENT_ID ? Column(
          children: [
            Text(
              'Yêu cầu kết thúc công việc',
              style: TEXT_STYLE_ON_FOREGROUND,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Hoàn thành',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(double.infinity, 40),
                  elevation: 0),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Yêu cầu làm lại',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(double.infinity, 40),
                  elevation: 0),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Huỷ công việc',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(double.infinity, 40),
                  elevation: 0),
            ),
          ],
        ) : Column(
          children: [
            Text(
              'Bạn đã gửi yêu cầu kết thúc công việc cho chủ dự án',
              style: TEXT_STYLE_ON_FOREGROUND,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(df.format(message.time),style: TextStyle(fontSize: 13,color:Colors.black87),),
                if(message.sender.id == CURRENT_ID)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                        message.status == 'Seen' ? Icons.done_all : Icons.done,
                        size: 15,
                        color:Colors.black87
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmWork extends StatelessWidget {
  final int money;
  final ChatMessage message;
  ConfirmWork({this.money,this.message});
  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    final df = new DateFormat('HH:mm');
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: message.sender.id == CURRENT_ID ? Column(

          children: [
            Text(
              'Bạn có đồng ý thực hiện dự án với mức lương VNĐ?',
              style: TEXT_STYLE_ON_FOREGROUND,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Tôi sẽ hoàn thành nó',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(double.infinity, 40),
                  elevation: 0),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Từ chối',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(double.infinity, 40),
                  elevation: 0),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(df.format(message.time),style: TextStyle(fontSize: 13,color:Colors.black87),),
                if(message.sender.id == CURRENT_ID)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                      message.status == 'Seen' ? Icons.done_all : Icons.done,
                      size: 15,
                        color:Colors.black87
                    ),
                  ),
              ],
            ),

          ],
        ) : Column(
          children: [
            Text(
              'Bạn đã gửi yêu cầu làm việc cho freelancer với mức lương  VNĐ',
              style: TEXT_STYLE_ON_FOREGROUND,
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(df.format(message.time),style: TextStyle(fontSize: 13,color:Colors.black87),),
                if(message.sender.id == CURRENT_ID)
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Icon(
                        message.status == 'Seen' ? Icons.done_all : Icons.done,
                        size: 15,
                        color:Colors.black87
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
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
