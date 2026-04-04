import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_guard/modules/services/api_service.dart';
import '../repo/repo_controller.dart';

class RepoListScreen extends StatelessWidget {
  RepoListScreen({super.key});

  final RepoController controller = Get.put(RepoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Repositories"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ApiService.logout();
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.repos.isEmpty) {
          return const Center(child: Text("No Repositories Found"));
        }

        return ListView.builder(
          itemCount: controller.repos.length,
          itemBuilder: (context, index) {
            var repo = controller.repos[index];

            return Card(
              margin: const EdgeInsets.all(10),
              color: index % 2 == 0
                  ? Colors.blue.shade50
                  : Colors.green.shade50,

              child: ListTile(
                leading: const Icon(Icons.folder, color: Colors.blue),

                title: Text(
                  repo.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Text(
                  "Risk: ${repo.riskLevel} | Vulns: ${repo.vulnerabilityCount}",
                ),

                trailing: const Icon(Icons.arrow_forward_ios),

                onTap: () {
                  log("RepoId clicked: ${repo}");
                  Get.toNamed("/dashboard", arguments: repo);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
