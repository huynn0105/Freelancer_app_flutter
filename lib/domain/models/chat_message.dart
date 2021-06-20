import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';

enum ChatMessageType { text, request }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
   final String message;
   final String avatarUrl;
   final String status;
   final DateTime time;
   final Job job;
   final ChatMessageType type;
   final int money;
   final Account freelancer;
   final Account receiver;
   final Account sender;

   ChatMessage({
     this.message, this.avatarUrl, this.status, this.time, this.job,
     this.freelancer, this.receiver, this.sender,
     this.type = ChatMessageType.text,
     this.money,
});

   factory ChatMessage.fromJson(Map<String, dynamic> json){
     return ChatMessage(
       job: Job.fromJs(json['job'] as Map<String, dynamic>),
       status:  json['status'],
       freelancer: Account.fromJs(json['freelancer'] as Map<String, dynamic>),
       avatarUrl: json['avatarUrl'],
       message: json['message1'],
       receiver: Account.fromJs(json['receiver'] as Map<String, dynamic>),
       sender: Account.fromJs(json['sender'] as Map<String, dynamic>),
       time: DateTime.parse(json['time'] as String),
     );
   }
}
