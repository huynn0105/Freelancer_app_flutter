class RatingRequest{
  int jobID;
  int freelancerId;
  int star;
  String comment;

  RatingRequest({
    this.jobID, this.freelancerId, this.star, this.comment,
});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobID'] = this.jobID;
    data['freelancerId'] = this.freelancerId;
    data['star'] = this.star;
    data['comment'] = this.comment;
    return data;
  }
}