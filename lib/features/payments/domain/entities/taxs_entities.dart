import 'package:equatable/equatable.dart';

class TaxEntities extends Equatable{

  final String delivery_tax;
  final List<String> packaging_tax;
  final List<String> pakaging_image;
  final String service_tax;

  const TaxEntities({
    required this.delivery_tax,
    required this.packaging_tax,
    required this.pakaging_image,
    required this.service_tax
  });

  @override
  List<Object?> get props => [
    delivery_tax,
    packaging_tax,
    pakaging_image,
    service_tax
  ];



}