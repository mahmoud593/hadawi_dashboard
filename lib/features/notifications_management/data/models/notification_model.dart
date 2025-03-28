
import 'package:hadawi_dathboard/features/notifications_management/domain/entities/notification_entities.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';

class NotificationModel extends NotificationsEntities{

  const NotificationModel({
    required super.description,
    required super.title,
    required super.status,
    required super.remind12,
    required super.remind24,
    required super.remind48,
    required super.uId,
  });


  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
      description: json['description'],
      title: json['title'],
      status: json['status'],
      remind12: json['remind12'],
      remind24: json['remind24'],
      remind48: json['remind48'],
    uId: json['uId'],
  );

  Map<String, dynamic> toMap() => {
    'description': description,
    'title': title,
    'status': status,
    'remind12': remind12,
    'remind24': remind24,
    'remind48': remind48,
    'uId': uId,
  };


}