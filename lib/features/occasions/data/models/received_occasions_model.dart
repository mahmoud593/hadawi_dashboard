import 'package:hadawi_dathboard/features/occasions/domain/entities/recieved_occastions_entity.dart';

class ReceivedOccasionsModel extends ReceivedOccasionsEntities {
  ReceivedOccasionsModel(
      {required super.id, required super.imageUrls, required super.finalPrice});

  factory ReceivedOccasionsModel.fromJson(Map<String, dynamic> json) {
    return ReceivedOccasionsModel(
      id: json['occasionId'] as String,
      imageUrls: List<String>.from(json['imagesUrl'] as List),
      finalPrice: json['finalPrice'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'occasionId': id,
      'imagesUrl': imageUrls,
      'finalPrice': finalPrice,
    };
  }
}
