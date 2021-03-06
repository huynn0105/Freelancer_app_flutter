


import 'package:freelance_app/domain/models/service.dart';

class Specialty{
   int id;
   String name;
   String image;
   bool isValue = false;
   List<Service> services;
   Specialty({this.id,this.name,this.isValue});


   Specialty.fromJson(Map<String, dynamic> json) {
     id = json['id'] as int;
     name = json['name']  as String;
     image = json['image'] as String;
     services =json['services'] == null ? null : (json['services'] as List)
         ?.map(
             (e) => e == null ? null : Service.fromJson(e as Map<String, dynamic>))
         ?.toList();
   }
   Specialty.fromJsonNoValue(Map<String, dynamic> json) {
     id = json['id'] as int;
     name = json['name'] as String;
   }


   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
     data['name'] = this.name;
     data['image'] = this.image;
     return data;
   }

   @override
  String toString() {
    return 'id: $id, name: $name';
  }

   @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Specialty && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

   Specialty copyWith({bool isValue, int id, String name}) {
     return Specialty(
       isValue: isValue ?? this.isValue,
       id: id ?? this.id,
       name: name ?? this.name,
     );
   }
}