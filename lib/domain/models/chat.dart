import 'package:freelance_app/domain/models/job.dart';

import 'account.dart';

class Chat {
   String lastMessage;
   String status;
   String avatarSender;
   Job job;
   Account freelancer;
   Account lastSender;
   DateTime time;


  Chat({
    this.job,
    this.status,
    this.freelancer,
    this.lastMessage,
    this.avatarSender,
    this.lastSender,
    this.time
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      job: Job.fromJs(json['job'] as Map<String, dynamic>),
      status:  json['status'],
      freelancer: Account.fromJs(json['freelancer'] as Map<String, dynamic>),
      avatarSender: json['avatarSender'],
      lastSender: Account.fromJs(json['lastSender'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'],
      time: DateTime.parse(json['time'] as String),
    );
  }
}

