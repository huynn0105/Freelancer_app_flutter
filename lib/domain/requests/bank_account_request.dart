class BankAccountRequest {
  int accountId;
  int bankId;
  String ownerName;
  String accountNumber;
  String branchName;

  BankAccountRequest({
    this.accountId,
    this.bankId,
    this.ownerName,
    this.accountNumber,
    this.branchName,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountId'] = this.accountId;
    data['bankId'] = this.bankId;
    data['ownerName'] = this.ownerName;
    data['accountNumber'] = this.accountNumber;
    data['branchName'] = this.branchName;
    return data;
  }
}
