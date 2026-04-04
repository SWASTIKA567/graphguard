import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../dashboard/dashboard_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DashboardController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final data = controller.dashboard.value;

        final risk = data?.riskScore ?? 0;
        final deps = data?.dependencies ?? 0;
        final vulns = data?.vulnerabilities ?? 0;

        final riskColor = Color(controller.getRiskColor(risk));

        return RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔥 RISK CARD
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: riskColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: riskColor, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text("Risk Score", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text(
                        risk.toString(),
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: riskColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        controller.getRiskLevel(risk),
                        style: TextStyle(color: riskColor),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                /// 📊 STATS ROW
                Row(
                  children: [
                    Expanded(
                      child: statCard("Dependencies", deps, Icons.storage),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: statCard("Vulnerabilities", vulns, Icons.warning),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                /// 📈 GRAPH PLACEHOLDER
                sectionTitle("Trend"),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text("Graph Coming Soon 📊")),
                ),

                SizedBox(height: 20),

                /// 🚨 TOP VULNERABILITIES - ✅ REAL DATA
                sectionTitle("Top Vulnerabilities"),

                Obx(() {
                  if (controller.vulnerabilities.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "No vulnerabilities found ✅",
                        style: TextStyle(color: Colors.green),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.vulnerabilities.length > 3
                        ? 3
                        : controller.vulnerabilities.length,
                    itemBuilder: (context, i) {
                      final v = controller.vulnerabilities[i];
                      final severity = v['severity'] ?? 'LOW';
                      final package = v['package'] ?? 'Unknown';
                      final fix = v['fix'] ?? 'No fix available';

                      final color = severity == 'HIGH'
                          ? Colors.red
                          : severity == 'MEDIUM'
                          ? Colors.orange
                          : Colors.yellow[700]!;

                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: color.withOpacity(0.4)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.warning, color: color, size: 20),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    package,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    fix,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                severity,
                                style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(
                      "/vulnerabilities",
                      arguments: controller.repoId,
                    );
                  },
                  child: Text("View All Vulnerabilities"),
                ),

                SizedBox(height: 20),

                /// 🔔 ALERTS
                sectionTitle("Alerts"),
                Obx(() {
                  if (controller.vulnerabilities.isEmpty) {
                    return alertTile("No active alerts ✅");
                  }
                  return Column(
                    children: controller.vulnerabilities
                        .take(3)
                        .map(
                          (v) => alertTile(
                            "${v['package'] ?? 'Unknown'} - ${v['severity'] ?? ''}",
                          ),
                        )
                        .toList(),
                  );
                }),

                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/alerts", arguments: controller.repoId);
                  },
                  child: Text("View All Alerts"),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        );
      }),
    );
  }

  /// 📦 STAT CARD
  Widget statCard(String title, int value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28),
          SizedBox(height: 8),
          Text(title),
          SizedBox(height: 6),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// 🔹 SECTION TITLE
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 🔔 ALERT TILE
  Widget alertTile(String text) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.warning, color: Colors.red),
      title: Text(text),
    );
  }
}
