import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';

enum ChatMessageType { text, request }

class ChatMessage {
  final int id;
  final int jobId;
  final int senderId;
  final int receiveId;
  final String message;
  String status;
  final DateTime time;
  final int freelancerId;
  final String avatarUrl;
  final String form;
  final String confirmation;


  ChatMessage({
    this.message,
    this.avatarUrl,
    this.status,
    this.time,
    this.jobId,
    this.freelancerId,
    this.receiveId,
    this.senderId,
    this.id,
    this.form,
    this.confirmation,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      jobId: json['jobId'],
      status: json['status'],
      id: json['id'],
      avatarUrl: json['avatarUrl'],
      message: json['message1'],
      senderId: json['senderId'],
      freelancerId: json['freelancerId'],
      receiveId: json['receiveId'],
      form: json['form'],
      confirmation: json['confirmation'],
      time: DateTime.parse(json['time'] as String),
    );
  }


}
