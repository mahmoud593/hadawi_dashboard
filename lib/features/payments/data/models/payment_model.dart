class PaymentModel{

  String? occasionId;
  String? occasionName;
  String? payerName;
  int? paymentAmount;
  String? paymentDate;
  String? paymentId;
  String? paymentStatus;
  String? personEmail;
  String? personId;
  String? personName;
  String? personPhone;

  PaymentModel({this.occasionId,this.occasionName, this.payerName, this.paymentAmount, this.paymentDate, this.paymentId, this.paymentStatus, this.personEmail, this.personId, this.personName, this.personPhone});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    occasionId = json['occasionId'];
    occasionName = json['occasionName'];
    payerName = json['payerName'];
    paymentAmount = json['paymentAmount'];
    paymentDate = json['paymentDate'];
    paymentId = json['paymentId'];
    paymentStatus = json['paymentStatus'];
    personEmail = json['personEmail'];
    personId = json['personId'];
    personName = json['personName'];
    personPhone = json['personPhone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'occasionId': occasionId,
      'occasionName': occasionName,
      'payerName': payerName,
      'paymentAmount': paymentAmount,
      'paymentDate': paymentDate,
      'paymentId': paymentId,
      'paymentStatus': paymentStatus,
      'personEmail': personEmail,
      'personId': personId,
      'personName': personName,
      'personPhone': personPhone,
      };
  }


}

