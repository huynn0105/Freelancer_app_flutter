class Province{
  String provinceId;
  String name;
  String type;

  Province({this.provinceId,this.name,this.type});

  Province.fromJson(Map<String, dynamic> json) {
    provinceId = json['provinceId'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceId'] = this.provinceId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Province &&
          runtimeType == other.runtimeType &&
          provinceId == other.provinceId;

  @override
  int get hashCode => provinceId.hashCode;
}

