class TotalRating{
  final double avg;
  final int count;

  TotalRating({this.avg, this.count});

  factory TotalRating.fromJson(Map<String,dynamic> json)
    => TotalRating(
      count: json['count'],
      avg: json['avg']
    );

  Map<String, dynamic> toJson() => {
    'count': this.count,
    'avg' : this.avg,
  };

}