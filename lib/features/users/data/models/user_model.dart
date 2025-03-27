
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';

class UserModel extends UserEntities{

  const UserModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.brithDate,
    required super.gender,
    required super.date,
    required super.uId
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      brithDate: json['brithDate'],
      gender: json['gender'],
      date: json['date'],
      uId: json['uId']
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'email': email,
    'brithDate': brithDate,
    'gender': gender,
    'date': date,
    'uId': uId,
  };


}