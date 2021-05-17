class Service{
  int id;
  String name;
  bool isValue = false;
  Service({this.id,this.name,this.isValue});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
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
}