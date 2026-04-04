import 'dart:developer';
import 'package:get/get.dart';
import 'package:graph_guard/repomodel.dart';
import '../services/api_service.dart';
import '../dashboard/dashboard_model.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var dashboard = Rxn<DashboardModel>();
  var vulnerabilities = <dynamic>[].obs;
  late String repoId;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is RepoModel) {
      repoId = args.id;
      dashboard.value = DashboardModel.fromRepo(args); // instant data!
      log("Dashboard loaded from Repo: ${args.name}");
    } else {
      repoId = args as String; // fallback
    }

    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {
      isLoading(true);

      final results = await Future.wait([
        ApiService.getDashboard(repoId),
        ApiService.getVulnerabilities(repoId),
      ]);

      final data = results[0] as DashboardModel?;
      final vulns = results[1] as List<dynamic>;

      if (data != null) {
        dashboard.value = data;
        log("Risk: ${data.riskScore}");
        log("Dependencies: ${data.dependencies}");
        log("Vulnerabilities: ${data.vulnerabilities}");
      } else {
        log("Dashboard API returned null");
      }

      vulnerabilities.value = vulns;
      log("Vulnerabilities Loaded: ${vulns.length}");
    } catch (e) {
      log("Dashboard Controller Error: $e");
    } finally {
      isLoading(false);
    }
  }

  String getRiskLevel(double risk) {
    if (risk < 4) return "LOW";
    if (risk < 7) return "MEDIUM";
    return "HIGH";
  }

  getRiskColor(double risk) {
    if (risk < 4) return 0xFF4CAF50;
    if (risk < 7) return 0xFFFFA000;
    return 0xFFD32F2F;
  }

  Future<void> refreshDashboard() async {
    await loadDashboard();
  }
}
