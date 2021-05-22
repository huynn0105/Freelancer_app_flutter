// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequest _$AccountRequestFromJson(Map<String, dynamic> json) {
  return AccountRequest(
    name: json['name'] as String,
    roleId: json['roleId'] as int,
    phone: json['phone'] as String,
    website: json['website'] as String,
    tile: json['tile'] as String,
    description: json['description'] as String,
    specialtyId: json['specialtyId'] as int,
    levelId: json['levelId'] as int,
    onReady: json['onReady'] as bool,
    formOfWorkId: json['formOfWorkId'] as int,
    skills: (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    services: (json['services'] as List)
        ?.map((e) =>
            e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AccountRequestToJson(AccountRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'roleId': instance.roleId,
      'phone': instance.phone,
      'tile': instance.tile,
      'description': instance.description,
      'website': instance.website,
      'specialtyId': instance.specialtyId,
      'levelId': instance.levelId,
      'onReady': instance.onReady,
      'formOfWorkId': instance.formOfWorkId,
      'skills': instance.skills,
      'services': instance.services,
    };
