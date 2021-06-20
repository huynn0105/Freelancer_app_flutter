import 'package:freelance_app/domain/models/capacity_profile.dart';
import 'package:freelance_app/domain/models/job.dart';
import 'package:freelance_app/domain/models/payment_method.dart';
import 'package:freelance_app/domain/models/province.dart';
import 'package:freelance_app/domain/models/total_rating.dart';
import 'form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/role.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';


class Account {
  int id;
  String name;
  String phone;
  String email;
  DateTime createdAtDate;
  DateTime bannedAtDate;
  String title;
  Province province;
  String description;
  List<PaymentMethod> bankAccounts;
  String website;
  TotalRating totalRating;
  int balance;
  int earning;
  bool onReady;
  String avatarUrl;
  FormOfWork formOfWork;
  Level level;
  Role role;
  Specialty specialty;
  List<Service> freelancerServices;
  List<Skill> freelancerSkills;
  List<CapacityProfile> capacityProfiles;
  List<Job> jobRenters;


  Account({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.title,
    this.description,
    this.createdAtDate,
    this.website,
    this.province,
    this.balance,
    this.earning,
    this.onReady,
    this.avatarUrl,
    this.totalRating,
    this.formOfWork,
    this.specialty,
    this.capacityProfiles,
    this.freelancerServices,
    this.freelancerSkills,
    this.level,
    this.role,
    this.jobRenters,
    this.bankAccounts,
    this.bannedAtDate,
});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAtDate: json['createdAtDate'] == null
          ? null
          : DateTime.parse(json['createdAtDate'] as String),
      website: json['website'] as String,
      province: json['province'] == null
          ? null
          : Province.fromJson(json['province'] as Map<String, dynamic>),
      balance: json['balance'] as int,
      earning: json['earning'] as int,
      onReady: json['onReady'] as bool,
      avatarUrl: json['avatarUrl'] as String,
      formOfWork: json['formOfWork'] == null
          ? null
          : FormOfWork.fromJson(json['formOfWork'] as Map<String, dynamic>),
      totalRating: json['totalRatingModel'] == null
          ? null
          : TotalRating.fromJson(json['totalRatingModel'] as Map<String, dynamic>),
      level: json['level'] == null
          ? null
          : Level.fromJson(json['level'] as Map<String, dynamic>),
      role: json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
      specialty: json['specialty'] == null
          ? null
          : Specialty.fromJson(json['specialty'] as Map<String, dynamic>),
      freelancerServices: (json['freelancerServices'] as List)
          ?.map((e) =>
      e == null ? null : Service.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      freelancerSkills: (json['freelancerSkills'] as List)
          ?.map(
              (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      capacityProfiles: (json['capacityProfiles'] as List)
          ?.map((e) => e == null
          ? null
          : CapacityProfile.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      jobRenters: (json['jobRenters'] as List)
          ?.map((e) => e == null ? null : Job.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      bannedAtDate : json['bannedAtDate'] == null
          ? null
          : DateTime.parse(json['bannedAtDate'] as String),
      bankAccounts : (json['bankAccounts'] as List)
          ?.map((e) => e == null
          ? null
          : PaymentMethod.fromJson(e as Map<String, dynamic>))
          ?.toList()
  );

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.name,
    'phone': this.phone,
    'email': this.email,
    'createdAtDate': this.createdAtDate?.toIso8601String(),
    'bannedAtDate': this.bannedAtDate?.toIso8601String(),
    'title': this.title,
    'province': this.province,
    'description': this.description,
    'bankAccounts': this.bankAccounts,
    'website': this.website,
    'balance': this.balance,
    'earning': this.earning,
    'onReady': this.onReady,
    'avatarUrl': this.avatarUrl,
    'formOfWork': this.formOfWork,
    'totalRatingModel': this.totalRating,
    'level': this.level,
    'role': this.role,
    'specialty': this.specialty,
    'freelancerServices': this.freelancerServices,
    'freelancerSkills': this.freelancerSkills,
    'capacityProfiles': this.capacityProfiles,
    'jobRenters': this.jobRenters,
  };

  

  factory Account.fromJs(Map<String, dynamic> json)
    => Account(
        id : json['id'],
        name : json['name'],
    );

}
