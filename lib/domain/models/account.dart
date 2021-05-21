import 'package:freelance_app/domain/models/capacity_profile.dart';

import 'form_of_work.dart';
import 'package:freelance_app/domain/models/level.dart';
import 'package:freelance_app/domain/models/role.dart';
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:freelance_app/domain/models/specialty.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';


@JsonSerializable()
class Account {
  int id;
  String name;
  String phone;
  String email;
  int roleId;
  String tile;
  String description;
  String website;
  double balance;
  double earning;
  bool onReady;
  String avatarUrl;
  FormOfWork formOfWork;
  Level level;
  Role role;
  Specialty specialty;
  List<Service> freelancerServices;
  List<Skill> freelancerSkills;
  List<CapacityProfile> capacityProfiles;


  Account({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.roleId,
    this.tile,
    this.description,
    this.website,
    this.balance,
    this.earning,
    this.onReady,
    this.avatarUrl,
    this.formOfWork,
    this.level,
    this.role,
    this.specialty,
    this.freelancerServices,
    this.freelancerSkills,
    this.capacityProfiles,
});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
