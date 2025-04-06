import 'package:equatable/equatable.dart';

class UserEntities  extends Equatable{

  final String name;
  final String phone;
  final String email;
  final String brithDate;
  final String gender;
  final String uId;
  final String date;
  final String token;
  final bool block;

  const UserEntities({
    required this.name,
    required this.phone,
    required this.email,
    required this.brithDate,
    required this.gender,
    required this.uId,
    required this.date,
    required this.token,
    required this.block,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name,phone,email,brithDate,gender,uId,date,token,block];

}