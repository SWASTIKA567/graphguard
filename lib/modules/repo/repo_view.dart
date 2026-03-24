import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../repo/repo_controller.dart';

class RepoListScreen extends StatelessWidget {
  RepoListScreen({super.key});

  final RepoController controller = Get.put(RepoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Repositories ")),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.repos.isEmpty) {
          return Center(child: Text("No Repositories Found"));
        }

        return ListView.builder(
          itemCount: controller.repos.length,
          itemBuilder: (context, index) {
            var repo = controller.repos[index];

            return Card(
              margin: EdgeInsets.all(10),
              color: index % 2 == 0
                  ? Colors.blue.shade50
                  : Colors.green.shade50,

              child: ListTile(
                leading: Icon(Icons.folder, color: Colors.blue),

                title: Text(
                  repo["name"],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                subtitle: Text(
                  "Risk: ${repo["riskScore"]} | Vulns: ${repo["vulnerabilityCount"]}",
                ),

                trailing: Icon(Icons.arrow_forward_ios),

                onTap: () {
                  //
                  Get.toNamed("/dashboard", arguments: repo["_id"]);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
