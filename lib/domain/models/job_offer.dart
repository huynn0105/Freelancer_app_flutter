import 'package:freelance_app/domain/models/job.dart';

class JobOffer{
  int jobId;
  int freelancerId;
  int offerPrice;
  String expectedDay;
  String description;
  String todoList;
  Job job;

  JobOffer.fromJson(Map<String, dynamic> json) {
    jobId = json['jobId'];
    freelancerId = json['freelancerId'];
    offerPrice = json['offerPrice'];
    expectedDay = json['expectedDay'];
    description = json['description'];
    todoList = json['todoList'];
    job = json['job'] == null ? null : Job.fromJson(json['job'] as Map<String, dynamic>);
  }
}