import 'package:flutter/material.dart';

enum ChatMessageType { text, audio, image, request }
enum MessageStatus { not_sent, not_view, viewed }

class ChatMessage {
  final String text;
  final ChatMessageType messageType;

  final bool isSender;

  ChatMessage({
    this.text = '',
    @required this.messageType,

    @required this.isSender,
  });
}

List demoChatMessages = [
  ChatMessage(
    text: "Hi Sajol,",
    messageType: ChatMessageType.text,

    isSender: false,
  ),
  ChatMessage(
    text: "Hello, How are you?",
    messageType: ChatMessageType.text,

    isSender: true,
  ),
  ChatMessage(
    text: "",
    messageType: ChatMessageType.image,

    isSender: false,
  ),
  ChatMessage(
    text: "",
    messageType: ChatMessageType.request,

    isSender: true,
  ),
  ChatMessage(
    text: "Error happend",
    messageType: ChatMessageType.text,

    isSender: true,
  ),
  ChatMessage(
    text: "This looks great man!!",
    messageType: ChatMessageType.text,

    isSender: false,
  ),
  ChatMessage(
    text: "Glad you like it",
    messageType: ChatMessageType.request,

    isSender: true,
  ),
];