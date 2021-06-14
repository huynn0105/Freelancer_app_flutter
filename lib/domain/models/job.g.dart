// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) {
  return Job(
    id: json['id'] as int,
    name: json['name'] as String,
    deadline: json['deadline'] == null
        ? null
        : DateTime.parse(json['deadline'] as String),
    createAt: json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
    details: json['details'] as String,
    renter: json['renter'] == null
        ? null
        : Renter.fromJson(json['renter'] as Map<String, dynamic>),
    freelancer: json['freelancer'] == null
        ? null
        : Account.fromJson(json['freelancer'] as Map<String, dynamic>),
    floorprice: json['floorprice'] as int,
    cellingprice: json['cellingprice'] as int,
    payform: json['payform'] == null
        ? null
        : PayForm.fromJson(json['payform'] as Map<String, dynamic>),
    specialty: json['specialty'] == null
        ? null
        : Specialty.fromJson(json['specialty'] as Map<String, dynamic>),
    service: json['service'] == null
        ? null
        : Service.fromJson(json['service'] as Map<String, dynamic>),
    typeOfWork: json['typeOfWork'] == null
        ? null
        : TypeOfWork.fromJson(json['typeOfWork'] as Map<String, dynamic>),
    formOfWork: json['formOfWork'] == null
        ? null
        : FormOfWork.fromJson(json['formOfWork'] as Map<String, dynamic>),
    province: json['province'] == null
        ? null
        : Province.fromJson(json['province'] as Map<String, dynamic>),
    status: json['status'] as String,
    skills: (json['skills'] as List)
        ?.map(
            (e) => e == null ? null : Skill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    avatarUrl: json['avatarUrl'] as String,
  )..offered = json['offered'] as bool;
}

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deadline': instance.deadline?.toIso8601String(),
      'createAt': instance.createAt?.toIso8601String(),
      'details': instance.details,
      'avatarUrl': instance.avatarUrl,
      'renter': instance.renter,
      'freelancer': instance.freelancer,
      'floorprice': instance.floorprice,
      'cellingprice': instance.cellingprice,
      'payform': instance.payform,
      'specialty': instance.specialty,
      'offered': instance.offered,
      'service': instance.service,
      'typeOfWork': instance.typeOfWork,
      'formOfWork': instance.formOfWork,
      'province': instance.province,
      'status': instance.status,
      'skills': instance.skills,
    };
