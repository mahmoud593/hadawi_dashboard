import 'package:hadawi_dathboard/features/promocode/domain/entities/code_entity.dart';

class CodeModel extends CodeEntity {
  CodeModel(
      {required super.id,
      required super.discount,
      required super.code,
      required super.used,
      required super.maxUsage,
      required super.expiryDate,
      required super.occasions});

  factory CodeModel.fromJson(Map<String, dynamic> json) {
    return CodeModel(
      id: json['id'],
      discount: json['discount']??0,
      code: json['code']??'',
      used: json['used']??0,
      maxUsage: json['maxUsage']??0,
      expiryDate: json['expiryDate']??'',
      occasions: json['occasions']??[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'discount': discount,
      'code': code,
      'used': used,
      'maxUsage': maxUsage,
      'expiryDate': expiryDate,
    };
  }
}
