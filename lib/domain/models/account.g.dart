// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    roleId: json['roleId'] as int,
    tile: json['tile'] as String,
    description: json['description'] as String,
    website: json['website'] as String,
    balance: (json['balance'] as num)?.toDouble(),
    isAccuracy: json['isAccuracy'] as bool,
    speccializeid: json['speccializeid'] as int,
    levelId: json['levelId'] as int,
    onReady: json['onReady'] as bool,
    formOnWorkId: json['formOnWorkId'] as int,
    avatarUrl: json['avatarUrl'] as String,
    city: json['city'] as String,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'roleId': instance.roleId,
      'tile': instance.tile,
      'description': instance.description,
      'website': instance.website,
      'balance': instance.balance,
      'isAccuracy': instance.isAccuracy,
      'speccializeid': instance.speccializeid,
      'levelId': instance.levelId,
      'onReady': instance.onReady,
      'formOnWorkId': instance.formOnWorkId,
      'avatarUrl': instance.avatarUrl,
      'city': instance.city,
    };
