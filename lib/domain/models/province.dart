class Province{
  String provinceId;
  String name;
  String type;

  Province({this.provinceId,this.name,this.type});

  Province.fromJson(Map<String, dynamic> json) {
    provinceId = json['id'];
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
}

