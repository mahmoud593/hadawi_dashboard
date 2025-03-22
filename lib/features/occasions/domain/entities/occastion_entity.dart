class OccasionEntity {
  final String bankName;
  final String city;
  final String district;
  final String giftCard;
  final String ibanNumber;
  final String receiverName;
  final String receiverPhone;
  final String receivingDate;
  final bool isForMe;
  final String occasionName;
  final String occasionDate;
  final String occasionId;
  final String occasionType;
  final dynamic moneyGiftAmount;
  final String personId;
  final String personName;
  final String personPhone;
  final String personEmail;
  final String giftName;
  final String giftLink;
  final dynamic giftPrice;
  final String giftImage;
  final String giftType;
  final bool isSharing;

  OccasionEntity(
  {
    required this.bankName,
    required this.city,
    required this.district,
    required this.giftCard,
    required this.ibanNumber,
    required this.receiverName,
    required this.receiverPhone,
    required this.receivingDate,
    required this.isForMe,
    required this.occasionName,
    required this.occasionDate,
    required this.occasionId,
    required this.occasionType,
    required this.moneyGiftAmount,
    required this.personId,
    required this.personName,
    required this.personPhone,
    required this.personEmail,
    required this.giftImage,
    required this.giftName,
    required this.giftLink,
    required this.giftPrice,
    required this.giftType,
    required this.isSharing
  });
}
