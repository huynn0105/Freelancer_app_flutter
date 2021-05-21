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
   List skills;

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
    this.skills,
  });




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
    data['skills'] = this.skills;
    return data;
  }
}
