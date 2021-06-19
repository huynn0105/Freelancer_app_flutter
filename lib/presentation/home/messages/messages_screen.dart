import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/setup_payment.dart';
import 'package:get/get.dart';
import 'chat_controller.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({this.job,this.userId,this.freelancerId});
  final Job job;
  final int userId;
  final int freelancerId;

  var controller = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
            elevation: 2,
            title: Row(
              children: [
                BackButton(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(job.name),
                      Text(
                          controller.chats[0].freelancer.name,
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,)
                      ),

                    ],
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Get.to(()=>SetupPayment());
                }, child: Text('Giao việc'))
              ],
            ),
          ),


      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(
                ()=> ListView.builder(
                  itemCount: controller.chatMessages.length,
                    reverse: true,
                  controller: controller.scrollController,
                  itemBuilder: (context, index) => Message(
                    message: controller.chatMessages[index],
                  ),
                ),
              ),
            ),
          ),
          ChatInputField(
            ctrMessage: controller.ctrMessage,
            onTap: (){
              controller.sendMessage(job.id,freelancerId,userId);

          },)
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  const Message({
    Key key,
    @required this.message,
  }) : super(key: key);
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {


    // Widget messageContains(ChatMessage message) {
    //   switch (message.messageType) {
    //     case ChatMessageType.text:
    //       return Flexible(child: Padding(
    //         padding: message.isSender ?  const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30),
    //         child: TextMessage(message: message),
    //       ));
    //     case ChatMessageType.request:
    //       return RequestFinished();
    //     case ChatMessageType.image:
    //       return ImageMessage();
    //     default:
    //       return SizedBox();
    //   }
    // }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                message.sender.id == CURRENT_ID ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (message.sender.id != CURRENT_ID) ...[
                CircleAvatar(
                  radius: 15,
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl: 'http://${message.avatarUrl}',
                    httpHeaders: {HttpHeaders.authorizationHeader: 'Bearer $TOKEN'},
                    placeholder: (context, url) => CupertinoActivityIndicator(),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 13,
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('assets/images/avatarnull.png'),
                      radius: 13,
                    ),
                  ),
                ),
                SizedBox(width: kDefaultPadding/2,),
              ],
              Flexible(child: Padding(
                padding: message.sender.id == CURRENT_ID ?  const EdgeInsets.only(left: 30) : const EdgeInsets.only(right: 30),
                child: TextMessage(message: message),
              ))
            ],
          ),
         // if (message.isSender) MessageStatusDot(status: message.messageStatus)
        ],
      ),
    );
  }
}
class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return Colors.red;
        case MessageStatus.not_view:
          return Theme.of(context).textTheme.bodyText1.color.withOpacity(0.1);
        case MessageStatus.viewed:
          return Colors.blue;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding / 4),

      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.not_sent ? Icons.close : Icons.done,
        size: 10,
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(message.sender.id == CURRENT_ID ? 1 : 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        message.message,
        maxLines: 20,
        style:
            TextStyle(color: message.sender.id == CURRENT_ID ? Colors.white : Colors.black87,fontSize: 17),
      ),
    );
  }
}

class RequestFinished extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Yêu cầu kết thúc công việc',style: TEXT_STYLE_ON_FOREGROUND,),
            SizedBox(height: 10),
            ElevatedButton(onPressed: (){}, child: Text('Hoàn thành',style: TextStyle(color: Colors.black,fontSize: 16),),style: ElevatedButton.styleFrom(primary: Colors.white,minimumSize: Size(double.infinity, 40),elevation: 0),),
            SizedBox(height: 5),
            ElevatedButton(onPressed: (){}, child: Text('Yêu cầu làm lại',style: TextStyle(color: Colors.black,fontSize: 16),),style: ElevatedButton.styleFrom(primary: Colors.white,minimumSize: Size(double.infinity, 40),elevation: 0),),
            SizedBox(height: 5),
            ElevatedButton(onPressed: (){}, child: Text('Huỷ công việc',style: TextStyle(color: Colors.black,fontSize: 16),),style: ElevatedButton.styleFrom(primary: Colors.white,minimumSize: Size(double.infinity, 40),elevation: 0),),
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
          IconButton(onPressed: onTap, icon:  Icon(Icons.send,
              color: Colors.blue,
          ),),
        ],
      ),
    );
  }
}
