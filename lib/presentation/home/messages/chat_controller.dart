import 'package:flutter/material.dart';
import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/chat.dart';
import 'package:freelance_app/domain/models/chat_message.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/services/http_service.dart';
import 'package:get/get.dart';
import 'package:signalr_core/signalr_core.dart';

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
      connection.on("ReceiveMessage", (data) {
        print('đã kết nối,$data');

        // print('rev: $data');
        // print("jobId: " + data[0].toString());
        // print("freelancerId: " + data[1].toString());
        // print("fromUserId: " + data[2].toString());
        // print("toUserId: " + data[3].toString());
        // print("message: " + data[4].toString());
        // print("msg.Time: " + data[5].toString());

        chatMessages.insert(
            0,
            ChatMessage(
              message: data[4],
              job: Job(id: data[0]),
              freelancer: Account(id: data[1]),
              receiver: Account(id: data[3]),
              sender: Account(id: data[2]),
              time: DateTime.parse(data[5]),
            ));
        loadMessageUser();
      });
    } catch (e) {
      print('lỗi $e');
      print('trạng thái: ${connection.state}');
      //createSignalRConnection();
    }
  }

  void loadMessageUser() async {
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
      await connection.invoke("PutMoney", args: <Object>[jobId,freelancerId,money]);
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

  Future sendRequestCancel(int jobId) async {
    if (connection.state == HubConnectionState.connected) {
      await connection.invoke("SendRequestCancellation", args: <Object>[jobId]);
    }
  }

  void sendMessage(int jobId, int freelancerId, int toUserId) async {
    try {
      if (ctrMessage.text.isNotEmpty) {
        if (connection.state == HubConnectionState.connected) {
          connection.invoke("SendMessage",
              args: <Object>[jobId, freelancerId, toUserId, ctrMessage.text]);
           connection.on("SendMessage_Successfully",(data){
             print('dataaaaa: $data');

            // chatMessages.insert(0,ChatMessage(
            //   message: data[4],
            //   job: Job(id: data[0]),
            //   freelancer: Account(id: data[1]),
            //   receiver: Account(id: data[3]),
            //   sender: Account(id: data[2]),
            //   time: DateTime.parse(data[5]),
            // ));
          });
          //seenMessage(jobId, freelancerId);
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

  @override
  void onClose() {
    disconnectUser();
    super.onClose();
  }
}
