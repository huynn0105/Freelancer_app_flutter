class Renter{
  int id;
  String name;
  String avatarRenter;
  Renter({this.name,this.id,this.avatarRenter});

  Renter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarRenter = json['avatarRenter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatarRenter'] = this.avatarRenter;
    return data;
  }
}