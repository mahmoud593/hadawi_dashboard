class BalanceModel{


  String? userName;
  String? phone;
  String? accountNumber;
  String? iban;
  String? paymentAccount;
  String? date;
  String? paymentDescription;
  String? balanceId;


  BalanceModel({this.userName, this.phone, this.accountNumber, this.iban, this.paymentAccount, this.paymentDescription, this.date, this.balanceId});

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    userName: json['userName'],
    phone: json['phone'],
    accountNumber: json['accountNumber'],
    iban: json['iban'],
    paymentAccount: json['paymentAccount'],
    paymentDescription: json['paymentDescription'],
    balanceId: json['balanceId'],
    date: json['date'],

  );

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'phone': phone,
    'accountNumber': accountNumber,
    'iban': iban,
    'paymentAccount': paymentAccount,
    'date': date,
    'balanceId': balanceId,
    'paymentDescription': paymentDescription,
  };


}

