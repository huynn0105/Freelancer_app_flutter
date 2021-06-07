import 'package:freelance_app/domain/models/bank.dart';

class PaymentMethod{
  int id;
  int accountId;
  int bankId;
  String ownerName;
  String accountNumber;
  String branchName;
  Bank bank;

  PaymentMethod({
    this.id, this.accountId, this.bankId, this.ownerName,
    this.accountNumber, this.branchName, this.bank,
});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    bankId = json['bankId'];
    ownerName = json['ownerName'];
    accountNumber = json['accountNumber'];
    branchName = json['branchName'];
    bank = json['bank'] == null
        ? null
        : Bank.fromJson(json['bank'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountId'] = this.accountId;
    data['bankId'] = this.bankId;
    data['ownerName'] = this.ownerName;
    data['accountNumber'] = this.accountNumber;
    data['branchName'] = this.branchName;
    data['bank'] = this.bank;
    return data;
  }
}