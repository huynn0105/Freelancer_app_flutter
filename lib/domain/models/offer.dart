import 'package:freelance_app/domain/models/account.dart';

class Offer{
  int jobId;
  int freelancerId;
  int offerPrice;
  String expectedDay;
  String description;
  String todoList;
  String status;
  Account freelancer;

  Offer.fromJson(Map<String, dynamic> json) {
    jobId = json['jobId'];
    freelancerId = json['freelancerId'];
    offerPrice = json['offerPrice'];
    expectedDay = json['expectedDay'];
    description = json['description'];
    todoList = json['todoList'];
    status = json['status'];
    freelancer = json['freelancer'] == null ? null : Account.fromJson(json['freelancer']);
  }

}