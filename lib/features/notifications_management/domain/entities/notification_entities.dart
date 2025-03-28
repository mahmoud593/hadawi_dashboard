import 'package:equatable/equatable.dart';


class NotificationsEntities  extends Equatable{

  final String description;
  final bool status;
  final bool remind12;
  final bool remind24;
  final bool remind48;
  final String title;
  final String uId;

  const NotificationsEntities({
    required this.description,
    required this.status,
    required this.title,
    required this.remind12,
    required this.remind24,
    required this.remind48,
    required this.uId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [description,status,title,remind12,remind24,remind48,uId];

}