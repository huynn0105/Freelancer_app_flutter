import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawController extends GetxController{
  TextEditingController ctrlBalance = TextEditingController();
  RxString balance = '0.0'.obs;
}