import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ApiService {

  static const String baseUrl = "http://10.0.2.2:5000";

  static final box = GetStorage();

  static String? get token => box.read("token");

  
  static Map<String, String> get headers {
    final t = token;

    return {
      "Content-Type": "application/json",
      if (t != null) "Authorization": "Bearer $t",
    };
  }

  
  static Future<Map<String, dynamic>> login(
      String email, String password) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        
        box.write("token", data["token"]);
        box.write("user", data["user"]);

        return data;
      } else {
        throw Exception(data["message"] ?? "Login failed");
      }
    } catch (e) {
      throw Exception("Login Error: $e");
    }
  }

  
  static Future<List<dynamic>> getRepos() async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/api/repos"),
        headers: headers,
      );

      final data = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return data["repos"];
      } else {
        throw Exception(data["message"] ?? "Failed to fetch repos");
      }
    } catch (e) {
      throw Exception("Repo Error: $e");
    }
  }

  
  static Future<void> saveDeviceToken(String fcmToken) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUrl/api/user/save-device-token"),
        headers: headers,
        body: jsonEncode({"token": fcmToken}),
      );

      if (res.statusCode != 200) {
        throw Exception("Failed to save FCM token");
      }
    } catch (e) {
      print("FCM Save Error: $e");
    }
  }


  static void logout() {
    box.remove("token");
    box.remove("user");
  }
}