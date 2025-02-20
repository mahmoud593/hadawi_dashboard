import 'package:equatable/equatable.dart';


class NotificationsEntities  extends Equatable{

  final String description;
  final bool status;
  final String title;

  const NotificationsEntities({
    required this.description,
    required this.status,
    required this.title,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [description,status,title];

}