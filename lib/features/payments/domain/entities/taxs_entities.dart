import 'package:equatable/equatable.dart';

class TaxEntities extends Equatable{

  final String delivery_tax;
  final String packaging_tax;
  final String service_tax;

  const TaxEntities({
    required this.delivery_tax,
    required this.packaging_tax,
    required this.service_tax
  });

  @override
  List<Object?> get props => [
    delivery_tax,
    packaging_tax,
    service_tax
  ];



}