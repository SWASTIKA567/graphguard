import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:graph_guard/modules/auth/login_controller.dart';

import 'routes/app_routes.dart';
import 'modules/services/fcm_service.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  await FCMService.init();
  final loginController = Get.put(LoginController());

  initDeepLinks(loginController);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      getPages: AppRoutes.routes,
    );
  }
}

void initDeepLinks(LoginController controller) {
  // 🔹 Cold start (app closed → opened via link)
  getInitialUri().then((uri) {
    if (uri != null) {
      log("📥 Initial URI: $uri");
      controller.handleGithubCallback(uri);
    }
  });

  // 🔹 Background / running app
  uriLinkStream.listen(
    (Uri? uri) {
      if (uri != null) {
        log("🔗 Incoming URI: $uri");
        controller.handleGithubCallback(uri);
      }
    },
    onError: (err) {
      log("❌ Deep Link Error: $err");
    },
  );
}
