import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/chat_message.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackButton(),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            SizedBox(
              width: kDefaultPadding * 0.75,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Huy Hyun',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Hoạt động 3m trước',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.more_vert,color: Colors.blue,), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ListView.builder(
                itemCount: demoChatMessages.length,
                itemBuilder: (context, index) => Message(
                  message: demoChatMessages[index],
                ),
              ),
            ),
          ),
          ChatInputField()
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


    Widget messageContains(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);

        case ChatMessageType.image:
          return ImageMessage();
        default:
          return SizedBox();
      }
    }
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!message.isSender) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                SizedBox(width: kDefaultPadding/2,),
              ],
              messageContains(message),
            ],
          ),
          if (message.isSender) MessageStatusDot(status: message.messageStatus)
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
      margin: EdgeInsets.only(top: kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(message.isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.text,
        style:
            TextStyle(color: message.isSender ? Colors.white : Colors.black87,fontSize: 17),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key key,
  }) : super(key: key);

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
          Icon(
            Icons.send,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
