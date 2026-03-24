import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    await Future.delayed(Duration(seconds: 2));

    String? token = box.read("token");

    if (token != null) {
      Get.offAllNamed("/repos");
    } else {
      Get.offAllNamed("/login");
    }
  }
}
