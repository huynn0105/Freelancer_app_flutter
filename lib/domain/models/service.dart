class Service{
  int id;
  String name;
  bool isValue;
  Service({this.id,this.name,this.isValue});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    isValue = true;
  }

  Service.fromJsonNoValue(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    isValue = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

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