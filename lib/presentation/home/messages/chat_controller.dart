import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:get/get.dart';
import 'package:signalr_client/hub_connection.dart';
import 'package:signalr_client/hub_connection_builder.dart';

class ChatController extends GetxController{
  //final ApiRepositoryInterface apiRepositoryInterface;

  final serverUrl = "http://freelancervn.somee.com/chatHub";
  HubConnection connection;
  ScrollController scrollController = ScrollController();

  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;


  Future<void> createSignalRConnection() async {
    connection =
        new HubConnectionBuilder().withUrl(serverUrl).build();
    await connection.start();
    if(connection.state == HubConnectionState.Connected) {
      connection.on("ReceiveMessage", (data) {
        print('rev: $data');
        print("fromUserId: " + data[0].toString());
        print("toUserId: " + data[1].toString());
        print("message: " + data[2].toString());
        chatMessages.insert(0, ChatMessage(text: data[2],isSender:  data[1] == CURRENT_ID ? true : false, messageType: ChatMessageType.text));
      });
    }
  }





  void connectUser(int id)async{
    if(connection.state == HubConnectionState.Connected){
      connection.invoke("Connect", args: <Object>[
        id
      ]);
    }
  }



  void sendMessage(id) async {
    if(ctrMessage.text.isNotEmpty){

      if(connection.state == HubConnectionState.Connected){
        connection.invoke("Sendmessage", args: <Object>[
          id, ctrMessage.text
        ]);
        chatMessages.insert(0,ChatMessage(messageType: ChatMessageType.text, isSender: true,text: ctrMessage.text));
        scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      }
      ctrMessage.text = '';
    }


  }



  TextEditingController ctrMessage = TextEditingController();

  @override
  void onReady() {
    createSignalRConnection();
    super.onReady();
  }
}