import 'package:freelance_app/domain/models/job.dart';

import 'account.dart';

class Chat {
   final Job job;
   final String lastMessage;
   final String status;
   final Account freelancer;
   final Account lastSender;
   final Account toUser;
   final DateTime time;
   final String lastMsgStatus;
   final int unseenCount;


  Chat({
    this.job,
    this.status,
    this.freelancer,
    this.lastMessage,
    this.lastSender,
    this.toUser,
    this.time,
    this.lastMsgStatus,
    this.unseenCount
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      job: Job.fromJs(json['job'] as Map<String, dynamic>),
      status:  json['status'],
      freelancer: Account.fromJs(json['freelancer'] as Map<String, dynamic>),
      lastSender: Account.fromJs(json['lastSender'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'],
      toUser: Account.fromJson(json['toUser'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
      lastMsgStatus: json['lastMsgStatus'],
      unseenCount: json['unseenCount'],
    );
  }
}

