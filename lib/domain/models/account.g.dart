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
    title: json['title'] as String,
    description: json['description'] as String,
    createdAtDate: json['createdAtDate'] == null
        ? null
        : DateTime.parse(json['createdAtDate'] as String),
    website: json['website'] as String,
    province: json['province'] == null
        ? null
        : Province.fromJson(json['province'] as Map<String, dynamic>),
    balance: (json['balance'] as num)?.toDouble(),
    earning: (json['earning'] as num)?.toDouble(),
    onReady: json['onReady'] as bool,
    avatarUrl: json['avatarUrl'] as String,
    formOfWork: json['formOfWork'] == null
        ? null
        : FormOfWork.fromJson(json['formOfWork'] as Map<String, dynamic>),
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
  )
    ..bannedAtDate = json['bannedAtDate'] == null
        ? null
        : DateTime.parse(json['bannedAtDate'] as String)
    ..bankAccounts = (json['bankAccounts'] as List)
        ?.map((e) => e == null
            ? null
            : PaymentMethod.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'createdAtDate': instance.createdAtDate?.toIso8601String(),
      'bannedAtDate': instance.bannedAtDate?.toIso8601String(),
      'title': instance.title,
      'province': instance.province,
      'description': instance.description,
      'bankAccounts': instance.bankAccounts,
      'website': instance.website,
      'balance': instance.balance,
      'earning': instance.earning,
      'onReady': instance.onReady,
      'avatarUrl': instance.avatarUrl,
      'formOfWork': instance.formOfWork,
      'level': instance.level,
      'role': instance.role,
      'specialty': instance.specialty,
      'freelancerServices': instance.freelancerServices,
      'freelancerSkills': instance.freelancerSkills,
      'capacityProfiles': instance.capacityProfiles,
      'jobRenters': instance.jobRenters,
    };
