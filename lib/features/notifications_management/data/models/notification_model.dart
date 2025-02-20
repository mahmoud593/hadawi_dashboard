
import 'package:hadawi_dathboard/features/notifications_management/domain/entities/notification_entities.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';

class NotificationModel extends NotificationsEntities{

  const NotificationModel({
    required super.description,
    required super.title,
    required super.status,
  });


  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
      description: json['description'],
      title: json['title'],
      status: json['status'],
  );

  Map<String, dynamic> toMap() => {
    'description': description,
    'title': title,
    'status': status,
  };


}