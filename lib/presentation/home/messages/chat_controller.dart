import 'package:flutter/material.dart';
import 'package:freelance_app/data/data.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/chat.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

import '../../../domain/models/chat_message.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/services/http_service.dart';


class ChatController extends GetxController {
  final ApiRepositoryInterface apiRepositoryInterface;

  ChatController({this.apiRepositoryInterface});

  HubConnection connection;
  ScrollController scrollController = ScrollController();

  RxList<ChatMessage> chatMessages = <ChatMessage>[].obs;
  RxList<Chat> chats = <Chat>[].obs;
  TextEditingController ctrMessage = TextEditingController();


  Future<void> createSignalRConnection() async {
    try {
      connection = HubConnectionBuilder().withUrl(CHAT_HUB).build();
      await connection.start();
      await connectUser();
      print('đã kết nối ${connection.state}');
      connection.on("ReceiveMessage", (data) {
        print('nhận $data');
        loadMessageUser();
        ChatMessage message = ChatMessage.fromJson(data[0]);
        chatMessages.insert(0,message);
      });
      connection.on('Seen', (data) {
        print('đã xem: $data');

        seenMesLocal();
      });
      connection.on('SuggestedPrice', (data) {
        print('nhận Suggested $data');
      });

      connection.on('PutMoney_Successfully', (data) {
        print('gửi Suggested $data');
      });
      connection.on('Confirm', (arguments) { });
      connection.on('Requestfinish', (arguments) { });
      connection.on('SendFinishRequest_Successfull', (arguments) { });
      connection.on('SendMessage_Successfully', (data) {

        chatMessages.insert(
            0,ChatMessage.fromJson(data[0]));
      });
      connection.on('Finish', (arguments) { });
      connection.on('RequestRework', (arguments) { });
      connection.on('RequestCancellation', (arguments) { });
      connection.on('ConfirmRequest', (arguments) { });

    } catch (e) {
      print('lỗi $e');
      print('trạng thái: ${connection.state}');
      //createSignalRConnection();
    }
  }

  void seenMesLocal(){
    chatMessages.forEach((element) {
        element.status = 'Seen';
    });
    chatMessages.refresh();


  }

  Future loadMessageUser() async {
    try {
      await apiRepositoryInterface
          .getMessageUser()
          .then((value) => chats.assignAll(value));
    } catch (e) {
      print('Lỗi mess: $e');
    }
  }

  Future loadMessageChat(int jobId, int freelancerId) async {
    try {
      await apiRepositoryInterface
          .getMessageChat(jobId, freelancerId)
          .then((value) => chatMessages.assignAll(value));
    } catch (e) {
      print('Lỗi mess: $e');
    }
  }

  Future connectUser() async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("Connect", args: <Object>[CURRENT_ID]);
    }
  }

  Future seenMessage(int jobId, int freelancerId) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SeeMessage", args: <Object>[jobId,freelancerId,CURRENT_ID]);
    }
  }

  Future disconnectUser() async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("Disconnect", args: <Object>[CURRENT_ID]);
    }
  }

  Future setupPrice(int jobId, int freelancerId, int money) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SuggestedPrice", args: <Object>[jobId,freelancerId,money]);
    }
  }

  Future confirmSuggestedPrice(int jobId, int freelancerId, int money, bool confirm) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("ConfirmSuggestedPrice", args: <Object>[jobId,freelancerId,money,confirm]);
    }
  }

  Future finishJob(int jobId) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("FinishJob", args: <Object>[jobId]);
    }
  }

  Future sendRequestRework(int jobId) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SendRequestRework", args: <Object>[jobId]);
    }
  }

  Future sendConfirmRequest(int jobId, String status, int adminId,String message) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SendConfirmRequest", args: <Object>[jobId,status,adminId,message]);
    }
  }

  Future sendFinishRequest(int jobId) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SendFinishRequest", args: <Object>[jobId]);
    }
  }

  Future sendRequestCancel(int jobId) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SendRequestCancellation", args: <Object>[jobId]);
    }
  }

  void sendMessage(int jobId, int freelancerId, int toUserId)  {
    try {
      if (ctrMessage.text.isNotEmpty) {
        if (connection.state == HubConnectionState.connected) {
          connection.invoke("SendMessage",
              args: <Object>[jobId, freelancerId, toUserId, ctrMessage.text]);

          // chatMessages.insert(0, ChatMessage(
          //   job: Job(id: jobId),
          //   sender: Account(id: CURRENT_ID),
          //   freelancer: Account(id: freelancerId),
          //   receiver: Account(id: toUserId),
          //   message: ctrMessage.text,
          //   time: DateTime.now(),
          //   status: 'UnSeen'
          // ));

          scrollController.animateTo(
            0.0,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
        }
        ctrMessage.text = '';
        //loadMessageUser();
      }
    } catch (e) {
      print('lỗi: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    createSignalRConnection();
    loadMessageUser();
    super.onReady();
  }
}
