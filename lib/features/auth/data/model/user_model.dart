import 'package:hadawi_dathboard/features/auth/domain/user_entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.uId, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(email: json['email'], uId: json['uId'], name: '');

  Map<String, dynamic> toJson() => {'email': email, 'uId': uId, 'name': name};
}
