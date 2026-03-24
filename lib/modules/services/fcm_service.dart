import 'package:firebase_messaging/firebase_messaging.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    await _messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground Notification: ${message.notification?.title}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(" Notification Clicked");
      //
    });
  }

  static Future<String?> getToken() async {
    try {
      String? token = await _messaging.getToken();
      print(" FCM TOKEN: $token");
      return token;
    } catch (e) {
      print("FCM Error: $e");
      return null;
    }
  }
}
