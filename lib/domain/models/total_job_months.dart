class TotalJobMonths{
  final String month;
  final int newJob;
  final int assigned;
  final int done;
  final int cancelled;
  final int money;

  TotalJobMonths({
    this.month, this.newJob, this.assigned, this.done, this.cancelled,
    this.money,
});

  factory TotalJobMonths.fromJson(Map<String, dynamic> json) {
    return TotalJobMonths(
      month: json['month'],
      newJob: json['newJob'],
      assigned: json['assigned'],
      done: json['done'],
      cancelled: json['cancelled'],
      money: json['money'],
    );
  }
}