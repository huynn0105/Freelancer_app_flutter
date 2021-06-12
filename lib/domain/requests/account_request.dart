import 'package:freelance_app/domain/models/service.dart';
import 'package:freelance_app/domain/models/skill.dart';
import 'package:json_annotation/json_annotation.dart';
part 'account_request.g.dart';

@JsonSerializable()
class AccountRequest {
   String name;
   int roleId;
   String phone;
   String tile;
   String description;
   String website;
   int specialtyId;
   int levelId;
   String provinceID;
   List<Skill> skills;
   List<Service> services;

  AccountRequest({
    this.name,
    this.roleId,
    this.phone,
    this.website,
    this.tile,
    this.description,
    this.specialtyId,
    this.levelId,
    this.provinceID,
    this.skills,
    this.services,
  });

   factory AccountRequest.fromJson(Map<String, dynamic> json) => _$AccountRequestFromJson(json);

   Map<String, dynamic> toJson() => _$AccountRequestToJson(this);
}
