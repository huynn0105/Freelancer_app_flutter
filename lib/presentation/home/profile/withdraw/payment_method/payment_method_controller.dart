import 'package:freelance_app/constant.dart';
import 'package:freelance_app/domain/models/bank.dart';
import 'package:freelance_app/domain/models/payment_method.dart';
import 'package:freelance_app/domain/repositories/api_repository.dart';
import 'package:freelance_app/domain/requests/bank_account_request.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PaymentMethodController extends GetxController{
  final ApiRepositoryInterface apiRepositoryInterface;

  PaymentMethodController({this.apiRepositoryInterface});
  RxList banks = <Bank>[].obs;
  RxInt bankId = 0.obs;
  var progress = sState.initial.obs;

  RxList paymentMethods = <PaymentMethod>[].obs;

  TextEditingController ctrlBank = TextEditingController();
  TextEditingController ctrlAccountNumber = TextEditingController();
  TextEditingController ctrlOwnerName = TextEditingController();
  TextEditingController ctrlBranchName = TextEditingController();

  void loadBanks() async {
    try{
      var result = await apiRepositoryInterface.getBanks();
      banks.assignAll(result);
    }catch(e){
      print('lỗi $e');
    }
  }

  Future<bool> sendBankAccount() async {
    progress(sState.loading);
    try{
      await apiRepositoryInterface.postBankAccounts(BankAccountRequest(
        accountId: 15,
        accountNumber: ctrlAccountNumber.text,
        bankId: bankId.value,
        branchName: ctrlBranchName.text,
        ownerName: ctrlOwnerName.text,
      ));
      progress(sState.initial);
      return true;
    }catch(e){
      print('lỗi $e');
      progress(sState.initial);
      return false;
    }
  }

  void loadPaymentMethod() async{
    progress(sState.loading);
    try{
      var result = await apiRepositoryInterface.getBankAccounts();
      paymentMethods.assignAll(result);
      progress(sState.initial);
    }catch(e){
      print('Lỗi $e');
      progress(sState.initial);
    }
  }

  @override
  void onReady() {
    loadPaymentMethod();
    super.onReady();
  }
}