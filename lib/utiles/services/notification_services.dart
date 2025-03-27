// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:dio/dio.dart';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// class NotificationServices {
//
//   String fcmToken = '';
//   Future<String?> getAccessToken() async {
//     final serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "transport-app-d662f",
//       "private_key_id": "d91c2c4581d5ad995dfd4ef8ed95e43b23862d2d",
//       "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCd2zz0F+qaUSyq\nwTRuvM/SKurOQXlpjGDuD/ugYtKA9DhiBagLob51gr7P5znkxHZ/Nggjz7Ee4jBl\ni2D4xZZejuzsE7fZ5sa+kvA1BswgSoiVi3ASYpCLV2Ui+4OUteZ7nfZviknJIZDl\nnUfDfhDGwCEnSTVwm5agkpiMkuh9LO27c+IRgApKHbXpZSxtRoS+vz9OtroiLA9m\noIivWL+KU86TFuTIhHv+V0Z/tWR2gwTjjvM0r7pz8LMmg7RpYj7L0455TGSl70iJ\n8q+nMSJdPp5E3L99gAK8q9njfyaWmzbxt2BWk8jIhUsTgX24f4U/ueeEBdMXXGUi\n7UPNz15bAgMBAAECggEAGh9Q1RSXckWy7meTgtcZowNkIOatLf4Y1OcYh6A4NTZ0\n6s+vJoxJECQnPxCvar/nhhdNvd4IRv6SQ145xAvaiDepqvV7tqzzFaVg572CDmlB\nyfwtpcqMIJWWpcqDqe/MvjHT4/25RnXuBvlXNK7KHZcSGsYJeGLe8x/fQQqskM4Z\nzducmSNKeElCIFSoLMFsN7ckNw10qm4/fQptVUSS2mLAT64fwyUyayM+2i3irlVc\nO5c9hH4kPenvYWQ15oQ/tU9t22Qls2t9A+vL53XelXniXlkrvNx7QidJfitIL6xa\nDXB4B4B2VcezxqfNHVW2XmtvSxqgs2ACdySYG8kqrQKBgQDBxBpjSD8mcsGHvpiD\niW6SMnxs5JVhctJ1CZzKnL+ltnjlrPmgjRTCocz8QR6YFKjM3lnVrqZbU0WmVqz0\nLiPN+71CC69ZyTRH6PBN6nwbF2/OKNHcC5rpL2LMKYnTfUt6QfZLtqtWUEi5ESxK\nk2DSq7y/ARpyANHezaiVoV6mXwKBgQDQjo+pcDraOm/GSJIJX58xnv+z6pGeTn4w\nTaJP2zsXV5WOvsUwmCZfvsCzIpB3uMLVJObYtKMP4mXhaAmo85hm3qv3SAfAIpfE\nA3NR7XLr7hGiaqZvdwkfQ9pl2ktpVfixOS+ViDt+S0Kmt81byB3Nu4UkO+riXFYJ\n9G5tfq1xhQKBgQCgLFpf3dYOE2i1rLFocpALnF5MqbxuXLtqcjLBLkgiVS+lNJL5\nzAXwSk4n7DC9KL7M87UxNXlhHvoBYb8A7q88VDADy6L9RpzIIN+cmQxUXNBYjFfG\nXXWF81zpRiEfyYA+JQ7TUcJazG0BRxfk4eV04PBauC/DM7hJRJpqboXOYwKBgFxx\n9OhMYSn+oTEpVeJlynD6Y6nini2n6XOL1hjDusu7/QVLNqk1qDzklxJQje0jruk/\n9Du2xljyJ+rkbPPBFprytRNlkFnwe4ldZi64rCo8WwC9eY0LHLYJI7PmMWs9uoEE\nMj18J7LxtVelPZgjemKJbpkDHji8aT78ZD6Q2lzpAoGAbUD21Pc54+Apk8hZddYh\nhpsCbA+VEo1XH30xS+pGBGeuNiFZNtbax5UiN2/qbXddsCapZ64K9tp5hvYc81TK\nm+DWKfPeRv/2bBw5FXgglWdp2g4kUyEiLdbjh1imXnLlS7ZULJbfF+0r2SgZWZ1m\nGvmyzBZyloP7Dn6QUb25PNQ=\n-----END PRIVATE KEY-----\n",
//       "client_email": "firebase-adminsdk-mwwf2@transport-app-d662f.iam.gserviceaccount.com",
//       "client_id": "104445999927303610295",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mwwf2%40transport-app-d662f.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };
//
//     List<String> scopes = [
//       "https://www.googleapis.com/auth/userinfo.email",
//       "https://www.googleapis.com/auth/firebase.database",
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//
//     try {
//       http.Client client = await auth.clientViaServiceAccount(
//           auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);
//
//       auth.AccessCredentials credentials =
//       await auth.obtainAccessCredentialsViaServiceAccount(
//           auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//           scopes,
//           client);
//
//       client.close();
//       print(
//           "Access Token: ${credentials.accessToken.data}"); // Print Access Token
//       fcmToken = credentials.accessToken.data;
//       return credentials.accessToken.data;
//     } catch (e) {
//       print("Error getting access token: $e");
//       return null;
//     }
//   }
//
//   Map<String, dynamic> getBody({
//     required String fcmToken,
//     required String title,
//     required String body,
//     required String userId,
//     String? type,
//   }) {
//     return {
//       "message": {
//         "token": fcmToken,
//         "notification": {"title": title, "body": body},
//         "android": {
//           "notification": {
//             "notification_priority": "PRIORITY_MAX",
//             "sound": "default"
//           }
//         },
//         "apns": {
//           "payload": {
//             "aps": {"content_available": true}
//           }
//         },
//         "data": {
//           "type": type,
//           "id": userId,
//           "click_action": "FLUTTER_NOTIFICATION_CLICK"
//         }
//       }
//     };
//   }
//
//
//   Future<void> sendNotifications({
//     required String fcmToken,
//     required String title,
//     required String body,
//     required String userId,
//     String? type,
//   }) async {
//     try {
//       var serverKeyAuthorization = await getAccessToken();
//
//       // change your project id
//       const String urlEndPoint =
//           "https://fcm.googleapis.com/v1/projects/transport-app-d662f/messages:send";
//
//       Dio dio = Dio();
//       dio.options.headers['Content-Type'] = 'application/json';
//       dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';
//
//       var response = await dio.post(
//         urlEndPoint,
//         data: getBody(
//           userId: userId,
//           fcmToken: fcmToken,
//           title: title,
//           body: body,
//           type: type ?? "message",
//         ),
//       );
//
//       // Print response status code and body for debugging
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Data: ${response.data}');
//     } catch (e) {
//       print("Error sending notification: $e");
//     }
//   }
//
//
//
//
// }