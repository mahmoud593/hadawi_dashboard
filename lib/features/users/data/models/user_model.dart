
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';

class UserModel extends UserEntities{

  const UserModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.brithDate,
    required super.gender,
    required super.date,
    required super.uId,
    required super.token,
    required super.block

  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      brithDate: json['brithDate'],
      gender: json['gender'],
      date: json['date'],
      token: json['token'],
      uId: json['uId'],
      block: json['block'],
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'email': email,
    'brithDate': brithDate,
    'gender': gender,
    'token': token,
    'date': date,
    'uId': uId,
    'block': block,
  };


}