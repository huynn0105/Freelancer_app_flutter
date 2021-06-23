import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';

class Rating{
  final int id;
  final String avatarRenter;
  final int star;
  final String comment;
  final Job job;
  final Account freelancer;
  final Account renter;


  Rating({
    this.id,
    this.job,
    this.star,
    this.renter,
    this.freelancer,
    this.comment,
    this.avatarRenter,
});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
      id: json['id'] as int,
      job: json['job'] == null ? null : Job.fromJs(json['job']),
      star: json['star'] as int,
      comment: json['comment'] as String,
    avatarRenter: json['avatarRenter'] as String,
      freelancer:json['freelancer'] == null ? null : Account.fromJs(json['freelancer']),
      renter:json['renter'] == null ? null : Account.fromJs(json['renter']),
  );
}