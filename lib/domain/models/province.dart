class Province{
  String provinceId;
  String name;


  Province({this.provinceId,this.name});

  Province.fromJson(Map<String, dynamic> json) {
    provinceId = json['provinceId'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceId'] = this.provinceId;
    data['name'] = this.name;
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

