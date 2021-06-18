import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/chat.dart';
import 'package:freelance_app/presentation/home/messages/chat_controller.dart';
import 'package:freelance_app/presentation/home/messages/messages_screen.dart';
import 'package:get/get.dart';
class ChatsScreen extends StatelessWidget {
  var controller = Get.put<ChatController>(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tin nhắn'),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context,index)=> ChatCard(chat: chatsData[index],onTap: (){
              controller.connectUser(chatsData[index].id);
              Get.to(()=>MessagesScreen());
            },),
          ),),
        ],
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
    @required this.chat,
    @required this.onTap
  }) : super(key: key);
  final Chat chat;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding,vertical: kDefaultPadding*0.75),
        child: Row(
          children: [
            Stack(
              children:[ CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(chat.image),
              ),
                chat.isActive ? Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3,
                      )
                    ),
                  ),
                ) : SizedBox.shrink(),
        ]
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chat.name,style: TEXT_STYLE_ON_FOREGROUND,),
                  SizedBox(height: 8,),
                  Opacity(
                    opacity: 0.64,
                    child: Text(chat.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),),
            Opacity(
                opacity: 0.64,
                child: Text(chat.time)),
          ],
        ),
      ),
    );
  }
}
