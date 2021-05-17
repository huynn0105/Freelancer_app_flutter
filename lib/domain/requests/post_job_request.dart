class PostJobRequest {
   String name;
   String details;
   int typeId;
   int formId;
   int workatId;
   int payformId;
   int floorprice;
   int cellingprice;
   DateTime deadline;
   int isPrivate;
   int specialtyId;
   String provinceId;
   int serviceId;
   List skillIds;

  PostJobRequest({
    this.name,
    this.details,
    this.typeId,
    this.formId,
    this.workatId,
    this.payformId,
    this.floorprice,
    this.cellingprice,
    this.deadline,
    this.isPrivate,
    this.specialtyId,
    this.serviceId,
    this.provinceId,
    this.skillIds,
  });


  PostJobRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    details = json['details'];
    typeId = json['typeId'];
    formId = json['formId'];
    workatId = json['workatId'];
    payformId = json['payformId'];
    floorprice = json['floorprice'];
    cellingprice = json['cellingprice'];
    deadline = json['deadline'];
    isPrivate = json['isPrivate'];
    specialtyId = json['specialtyId'];
    serviceId = json['serviceId'];
    provinceId = json['provinceId'];
    skillIds = json['skillIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['details'] = this.details;
    data['typeId'] = this.typeId;
    data['formId'] = this.formId;
    data['workatId'] = this.workatId;
    data['payformId'] = this.payformId;
    data['floorprice'] = this.floorprice;
    data['cellingprice'] = this.cellingprice;
    data['deadline'] = this.deadline.toString();
    data['isPrivate'] = this.isPrivate;
    data['specialtyId'] = this.specialtyId;
    data['serviceId'] = this.serviceId;
    data['provinceId'] = this.provinceId;
    data['skillIds'] = this.skillIds;
    return data;
  }
}
