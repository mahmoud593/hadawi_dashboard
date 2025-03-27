import 'package:hadawi_dathboard/features/banners/domain/banners_entity/banners_entity.dart';

class BannersModel extends BannersEntity{
  BannersModel({required super.id, required super.image, required super.bannerName});

  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      image: json['image']??'',
      bannerName: json['bannerName']??'',
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'bannerName': bannerName,
    };
  }
}