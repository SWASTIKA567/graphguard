import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 🔥 App Title
                const Text(
                  "GraphGuard",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                /// Subtitle
                const Text(
                  "Secure your GitHub repositories",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 40),

                /// 🔥 GitHub Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.loginWithGithub,

                    icon: const Icon(Icons.code),

                    label: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Continue with GitHub"),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
