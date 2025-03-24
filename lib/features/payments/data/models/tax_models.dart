import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';

class TaxModels extends TaxEntities {

  const TaxModels({
    required super.delivery_tax,
    required super.packaging_tax,
    required super.pakaging_image,
    required super.occasionType,
    required super.service_tax
  });

  factory TaxModels.fromJson(Map<String, dynamic> json) {
    return TaxModels(
      delivery_tax: json['delivery_tax'],
      packaging_tax: List<String>.from(json['packaging_tax'].map((x) => x)).toList(),
      pakaging_image: List<String>.from(json['pakaging_image'].map((x) => x)).toList(),
      occasionType: List<String>.from(json['occasionType'].map((x) => x)).toList(),
      service_tax: json['service_tax'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_tax': delivery_tax,
      'packaging_tax': packaging_tax,
      'pakaging_image': pakaging_image,
      'occasionType': occasionType,
      'service_tax': service_tax,
    };
  }

}