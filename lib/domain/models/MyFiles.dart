
import 'package:flutter/material.dart';
import 'package:freelance_app/constant.dart';

class JobM {
  final String title;
  final int num;
  final Color color;

  JobM({
      this.title,
      this.num,
      this.color});
}

List<JobM> demoJobM = [
  JobM(
    title: "Tổng công việc",
    color: primaryColor,
    num: 35,
  ),
  JobM(
    title: "Hiện có",
    color: Color(0xFFFFA113),
    num: 35,
  ),
  JobM(
    title: "Đã hoàn thành",
    color: Color(0xFF528D31),
    num: 10,
  ),
  JobM(
    title: "Đã huỷ bỏ",
    color: Color(0xFFC21111),
    num: 78,
  ),
];


List<JobM> demoUserM = [
  JobM(
    title: "Tổng số",
    color: primaryColor,
    num: 35,
  ),
  JobM(
    title: "Đã xác thực",
    color: Color(0xFFFFA113),
    num: 20,
  ),

];
