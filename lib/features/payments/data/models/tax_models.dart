import 'package:hadawi_dathboard/features/payments/domain/entities/taxs_entities.dart';

class TaxModels extends TaxEntities {

  const TaxModels({
    required super.delivery_tax,
    required super.packaging_tax,
    required super.service_tax
  });

  factory TaxModels.fromJson(Map<String, dynamic> json) {
    return TaxModels(
      delivery_tax: json['delivery_tax'],
      packaging_tax: json['packaging_tax'],
      service_tax: json['service_tax'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_tax': delivery_tax,
      'packaging_tax': packaging_tax,
      'service_tax': service_tax,
    };
  }

}