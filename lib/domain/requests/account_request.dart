class AccountRequest {
   String name;
   int roleId;
   String phone;
   String tile;
   String description;
   String website;
   int speccializeid;
   int levelId;
   bool onReady;
   int formOnWorkId;
   List skills;
   List services;

  AccountRequest({
    this.name,
    this.roleId,
    this.phone,
    this.website,
    this.tile,
    this.description,
    this.speccializeid,
    this.levelId,
    this.onReady,
    this.formOnWorkId,
    this.skills,
    this.services,
  });

  AccountRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    roleId = json['roleId'];
    phone = json['phone'];
    tile = json['tile'];
    description = json['description'];
    speccializeid = json['speccializeid'];
    levelId = json['levelId'];
    onReady = json['onReady'];
    formOnWorkId = json['formOnWorkId'];
    skills = json['skills'];
    services = json['services'];
  }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['name'] = this.name;
     data['roleId'] = this.roleId;
     data['phone'] = this.phone;
     data['tile'] = this.tile;
     data['description'] = this.description;
     data['speccializeid'] = this.speccializeid;
     data['website'] = this.website;
     data['levelId'] = this.levelId;
     data['onReady'] = this.onReady;
     data['formOnWorkId'] = this.formOnWorkId;
     data['skills'] = this.skills;
     data['services'] = this.services;
     return data;
   }
}
