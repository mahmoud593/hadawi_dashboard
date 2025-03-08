import 'package:hadawi_dathboard/features/auth/domain/user_entities/email_pass_entity.dart';

class EmailPassModel extends EmailPassEntity {
  EmailPassModel({required super.email, required super.password});

  factory EmailPassModel.fromJson(Map<String, dynamic> json) {
    return EmailPassModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
