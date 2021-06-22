import 'package:freelance_app/domain/models/account.dart';
import 'package:freelance_app/domain/models/job.dart';

class Rating{
  final int id;
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
    this.comment
});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
      id: json['id'] as int,
      job: Job.fromJs(json['job']),
      star: json['star'] as int,
      comment: json['comment'] as String,
      freelancer:  Account.fromJs(json['freelancer']),
      renter: Account.fromJs(json['renter']),
  );
}