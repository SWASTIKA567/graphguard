import 'package:get/get.dart';
import '../services/api_service.dart';
import '../services/fcm_service.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email and Password required");
      return;
    }

    try {
      isLoading(true);

      await ApiService.login(email, password);
      await FCMService.init();
      String? fcmToken = await FCMService.getToken();

      if (fcmToken != null) {
        await ApiService.saveDeviceToken(fcmToken);
      }

      Get.offAllNamed("/repos");
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
