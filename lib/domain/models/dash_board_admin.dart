import 'package:freelance_app/domain/models/total_job_months.dart';
import 'package:freelance_app/domain/models/total_user_months.dart';

class DashboardAdmin{
  final int totalJob;
  final int totalAssigned;
  final int totalDone;
  final int totalCancelled;
  final int totalUser;
  final int userConfirmed;
  final List<TotalJobMonths> totalJobMonths;
  final List<TotalUserMonths> totalUserMonths;


  DashboardAdmin({
    this.totalJob,
    this.totalAssigned,
    this.totalDone,
    this.totalCancelled,
    this.totalUser,
    this.userConfirmed,
    this.totalJobMonths,
    this.totalUserMonths,
});

  factory DashboardAdmin.fromJson(Map<String, dynamic> json) {
    return DashboardAdmin(
      totalJob: json['totalJob'],
      totalAssigned: json['totalAssigned'],
      totalDone: json['totalDone'],
      totalCancelled: json['totalCancelled'],
      totalUser: json['totalUser'],
      userConfirmed: json['userConfirmed'],
      totalJobMonths: (json['totalJobMonths'] as List)
          ?.map((e) =>
      e == null ? null : TotalJobMonths.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      totalUserMonths: (json['totalUserMonths'] as List)
          ?.map((e) =>
      e == null ? null : TotalUserMonths.fromJson(e as Map<String, dynamic>))
          ?.toList(),
    );
  }
}