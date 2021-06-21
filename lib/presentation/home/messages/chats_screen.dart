import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/chat.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/messages_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatsScreen extends StatelessWidget {
  var controller = Get.put<ChatController>(
      ChatController(apiRepositoryInterface: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin nhắn'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          controller.loadMessageUser();
        },
        child: Column(
          children: [
            Expanded(
              child: Obx(
                ()=> ListView.builder(
                  itemCount: controller.chats.length,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final chat = controller.chats[index];
                    return ChatCard(
                      chat: chat,
                      onTap: () {
                        controller.seenMessage(chat.job.id, chat.freelancer.id);
                        print('trạng THái: ${chat.status}');
                        controller.status(chat.status);
                        controller.loadMessageChat(chat.job.id, chat.freelancer.id).then((value)
                        => Get.to(() => MessagesScreen(
                                  toUser: chat.toUser,
                                  job: chat.job,
                                  freelancer: chat.freelancer,
                                )));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({Key key, @required this.chat, @required this.onTap})
      : super(key: key);
  final Chat chat;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Row(
          children: [
            Stack(children: [
              CircleAvatar(
                radius: 24,
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.grey.shade300,
                child: CachedNetworkImage(
                  imageUrl: 'http://${chat.toUser.avatarUrl}',
                  httpHeaders: {
                    HttpHeaders.authorizationHeader: 'Bearer $TOKEN'
                  },
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 23,
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: AssetImage('assets/images/avatarnull.png'),
                    radius: 23,
                  ),
                ),
              ),
            ]),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.job.name,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${chat.lastSender.id == CURRENT_ID ?'Bạn:' : '${chat.toUser.name}: '} ${chat.lastMessage}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: chat.lastSender.id != CURRENT_ID  ? chat.lastMsgStatus == "Seen" ? FontWeight.w400 :   FontWeight.bold : FontWeight.w400
                      ),
                    )
                  ],
                ),
              ),
            ),
            Text(DateTime.now().difference(chat.time).inDays < 1
                ? DateFormat('HH:mm').format(chat.time)
                : DateFormat('dd:MM').format(chat.time),
              style: TextStyle(
                  fontWeight: chat.lastSender.id != CURRENT_ID  ? chat.lastMsgStatus == "Seen" ? FontWeight.w400 :   FontWeight.bold : FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }
}
