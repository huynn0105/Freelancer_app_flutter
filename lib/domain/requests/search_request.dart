class SearchRequest {
  String search;
  int floorPrice;
  int cellingPrice;
  int levelId;
  int specialtyId;
  int serviceId;
  int payFormId;
  int formOfWorkId;
  int typeOfWorkId;
  String provinceId;

  SearchRequest(
      {this.search,
      this.floorPrice,
      this.cellingPrice,
      this.specialtyId,
      this.serviceId,
      this.levelId,
      this.payFormId,
      this.formOfWorkId,
      this.typeOfWorkId,
      this.provinceId});



  Map<String, dynamic> toJsonJob() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search ?? '';
    data['floorPrice'] = '${this.floorPrice}';
    data['cellingPrice'] = '${this.cellingPrice}';
    data['specialtyId'] = '${this.specialtyId}';
    data['serviceId'] = '${this.serviceId}';
    data['payFormId'] = '${this.payFormId}';
    data['formOfWorkId'] = '${this.formOfWorkId}';
    data['typeOfWorkId'] = '${this.typeOfWorkId}';
    data['provinceId'] = this.provinceId;
    return data;
  }

  Map<String, dynamic> toJsonFreelancer() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['specialtyId'] = '${this.specialtyId}';
    data['serviceId'] = '${this.serviceId}';
    data['provinceId'] = this.provinceId;
    data['levelId'] = '${this.levelId}';
    return data;
  }
}
