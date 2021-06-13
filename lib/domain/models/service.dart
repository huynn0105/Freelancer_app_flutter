import 'package:freelance_app/domain/models/specialty.dart';

class Service{
  int id;
  String name;
  List<Specialty> specialties;
  bool isValue;
  Service({this.id,this.name,this.isValue,this.specialties});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    isValue = true;
  }

  Service.fromJsonNoValue(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    specialties = (json['specialty'] as List)
        ?.map(
            (e) => e == null ? null : Specialty.fromJson(e as Map<String, dynamic>))
        ?.toList();
    isValue = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Service && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  Service copyWith({bool isValue, int id, String name}) {
    return Service(
      isValue: isValue ?? this.isValue,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return '{id: $id, name: $name}';
  }
}