import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:dio/dio.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
class NotificationServices {

  String fcmToken = '';

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "transport-app-d662f",
      "private_key_id": "cc1ae9d2266ad66dce62a9052854485acc507e0a",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCVOK3zDpWU3UcB\now72EQ8jfzX82qx0IEL8vi/ZdGs9/g/UJHDyAiTDF+tuJRNWpOSseLiTe8fpVB0J\nXsM7uFrZlPAEt2Zdy1uBLciFJVck4huKG8nwdtKCkiJy9dZ8gByz/mh5QwVwoabC\nlmwh7i8GH8psTaqFyhcRVOc8BmFwgmfMFJfl0GhP19viG6ltuKCRbOiwaYpwORcG\n/lDJu5q3I7T1AYTX44t0iaDB8LzlYWGZq71MrzKvNT+VtGQX4gJlDlF0g2gW1xfK\nA7Sq6deeWHD2SszIXLL6YiILUAJjCoWJFN+/GewhucDHmpT2a86/ishne7UvUt/v\nzugsyEy/AgMBAAECggEAHuSdHrTmQuuMx8n6Tvc5KyArDS44hdIoDCtTvLFdgngW\nztS8jV3kPn+1Phhu6IE61nonvGDkAmpnmIkF4ldId8Nd7ZwKlWCEkTnpSadxYzFs\ngis+o4n2CxI2D5bV0PC1AI6rEm/NsIPHAoIh4ORu19W9Eq8BnrE4FV5+gO7RPXlx\nFDB/hRuRfGVKIqpID0tQhAiE9kip2w+s+QD+jyRRI5XHVQeDPFk/p3G5BBF8SIaH\nyOK8Q0UnXO6jfamdM3NBgJW+11vQl3rzXA5brVJkn+ponVr+5y82OQ1ZFaRo4YjI\nHnbNKddIfMzs/cB0v+VFuHbBaKHqE6hN14BVxb0gAQKBgQDGIiDxBupdBFoTFole\njVf2b1yaHOP/DUL7jTkmPVENUkbByRe8QEhUUKBMdVC55X+v0m/EsCQL0ajkwoQC\n62rED3uzgRc47HMRXLDZ3pCIZY8m/Q3RgAM+tWMCCQns2/1b4Sfn3DwyAIm4w5su\n35rIbRO7nITsoYb0j/ts3XTRsQKBgQDAzYtuT+WeKdqkay+szxs79Ol+5pXX/ttj\nw8VTTPc57JTlFLCSLgMjznOVsxGDt2At3WAZtKrzgVwLf573kZbZITWljXxWC/v4\ntb57e8gQsAzAKq31NCiY8ZvDkzoJVwUhq5GUQF38KnGoav09BqCd6XmUp0dWCJ6b\nrgyW+AaxbwKBgAE6/wdgKp5vQ3vw3OOIby5pnKKcYVIZK/xR8TPql5FEnInhjNMv\ndwOHCKfQ5rJw2W0nGmiXS3IDWFArYRR/j8ct7W+88n75APHvqG2B81XVg6ETWz2c\n1OhTygyeL8CX0Sf76vqGpJ0O4cwS8ujEnLp36vJ0U2MA0cy9BCu16F7RAoGBALPq\nGsahv//Lxr/PVfnIef2FGa7VtdaNeGSsdyK4m6tt3bO3jt2aGkv7h1iWdS2YnSOv\nhNH4Cd6ZRC9mtA0Jyt5rYwhN80zIeiUoU8wfQh5wajWYniRGu+uc6mGirXGxxpQY\n6gyR1CJP6SfkTtP3r0IscMwLHUJnYLqdvBnU8Un5AoGAO6vPIyCNGPH67Bp3T8aY\n3aplmi//VLSFSPJtFY8NYUvCkYE7GPCOtNEI+PvOIFYtOiKhd7G5nINfSGz8NEiy\n7K2JP9gRnkHieRrg4jNYVNXSVRpFKukftZp0whJsp51yDBraHnMq1y/PTgRI5mfz\nUv5+554u7vTdfc8tC5lFs64=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-mwwf2@transport-app-d662f.iam.gserviceaccount.com",
      "client_id": "104445999927303610295",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mwwf2%40transport-app-d662f.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
      await auth.obtainAccessCredentialsViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
          scopes,
          client);

      client.close();
      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }


  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();

      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/transport-app-d662f/messages:send";


      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
          urlEndPoint,
          data: {
            "message": {
              "token": fcmToken,
              "notification": {"title": title, "body": body},
              "android": {
                "notification": {
                  "notification_priority": "PRIORITY_MAX",
                  "sound": "default"
                }
              },
              "apns": {
                "payload": {
                  "aps": {"content_available": true}
                }
              },
              "data": {
                "type": "",
                "id": userId,
                "click_action": "FLUTTER_NOTIFICATION_CLICK"
              }
            }
          }
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }




}