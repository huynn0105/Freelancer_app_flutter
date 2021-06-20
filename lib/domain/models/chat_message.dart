import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';

enum ChatMessageType { text, request }

class ChatMessage {
   final String message;
   final String avatarUrl;
   String status;
   final DateTime time;
   final Job job;
   final ChatMessageType type;
   final Account freelancer;
   final Account receiver;
   final Account sender;






   final int money;


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

   ChatMessage copyWith({String status}) {
     return ChatMessage(
       money: this.money,
       type: this.type,
       job: this.job,
       time: this.time,
       avatarUrl: this.avatarUrl,
       sender: this.sender,
       freelancer: this.freelancer,
       receiver: this.receiver,
       message: this.message,
       status: status ?? this.status,
     );
   }


}
