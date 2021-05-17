
import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
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
  String city;
  String description;
  String website;
  double balance;
  bool isAccuracy;
  int speccializeid;
  int levelId;
  bool onReady;
  int formOnWorkId;
  String avatarUrl;


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
    this.isAccuracy,
    this.speccializeid,
    this.levelId,
    this.onReady,
    this.formOnWorkId,
    this.avatarUrl,
    this.city,

  });

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
