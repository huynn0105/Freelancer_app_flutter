import 'package:freelance_app/domain/models/form_of_work.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/rating.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:freelance_app/domain/models/type_of_work.dart';

import 'account.dart';
import 'pay_form.dart';
import 'renter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job.g.dart';

@JsonSerializable()
class Job {
  int id;
  String name;
  int bidCount;
  int price;
  DateTime deadline;
  DateTime createAt;
  DateTime startAt;
  DateTime finishAt;
  String details;
  String avatarUrl;
  Renter renter;
  Account freelancer;
  int floorprice;
  int cellingprice;
  PayForm payform;
  Specialty specialty;
  bool offered;
  Service service;
  TypeOfWork typeOfWork;
  FormOfWork formOfWork;
  Province province;
  String status;
  Rating rating;
  List<Skill> skills;

  Job({
    this.id,
    this.name,
    this.deadline,
    this.createAt,
    this.details,
    this.renter,
    this.freelancer,
    this.rating,
    this.floorprice,
    this.cellingprice,
    this.payform,
    this.specialty,
    this.service,
    this.typeOfWork,
    this.formOfWork,
    this.province,
    this.price,
    this.status,
    this.skills,
    this.avatarUrl,
    this.bidCount,
    this.offered,
    this.finishAt,
    this.startAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);

  factory Job.fromJs(Map<String, dynamic> json) {
   return Job(
       id : json['id'],
       name : json['name'],
   );
  }
}
