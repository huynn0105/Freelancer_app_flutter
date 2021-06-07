class OfferRequest {
  int jobId;
  int freelancerId;
  int offerPrice;
  String expectedDay;
  String description;
  String todoList;

  OfferRequest({
    this.jobId,
    this.freelancerId,
    this.offerPrice,
    this.expectedDay,
    this.description,
    this.todoList,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobId'] = this.jobId;
    data['freelancerId'] = this.freelancerId;
    data['offerPrice'] = this.offerPrice;
    data['expectedDay'] = this.expectedDay;
    data['description'] = this.description;
    data['todoList'] = this.todoList;
    return data;
  }
}
