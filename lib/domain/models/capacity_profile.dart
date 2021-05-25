import 'package:freelance_app/domain/models/service.dart';

class CapacityProfile {
  int id;
  String name;
  String urlweb;
  String description;
  String imageName;
  String imageBase64;
  String imageUrl;
  List<Service> services;

  CapacityProfile({
    this.id,
    this.name,
    this.urlweb,
    this.description,
    this.imageName,
    this.services,
    this.imageBase64,
    this.imageUrl,
  });

  CapacityProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    urlweb = json['urlweb'];
    description = json['description'];
    imageName = json['imageName'];
    imageUrl = json['imageUrl'];
    services =  (json['services'] as List)
        ?.map((e) =>
    e == null ? null : Service.fromJson(e as Map<String, dynamic>))
        ?.toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['urlweb'] = this.urlweb;
    data['description'] = this.description;
    data['imageName'] = this.imageName;
    data['imageBase64'] = this.imageBase64;
    data['services'] = this.services;
    data['imageUrl'] = this.imageUrl;
    return data;
  }

}
