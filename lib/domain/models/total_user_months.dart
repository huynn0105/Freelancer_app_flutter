class TotalUserMonths{
  final String month;
  final int newUser;


  TotalUserMonths({
    this.month, this.newUser,
});

  factory TotalUserMonths.fromJson(Map<String, dynamic> json) {
    return TotalUserMonths(
      month: json['month'],
      newUser: json['newUser'],

    );
  }
}