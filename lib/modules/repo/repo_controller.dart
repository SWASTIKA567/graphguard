import 'dart:developer';

import 'package:get/get.dart';
import '../services/api_service.dart';
import 'package:graph_guard/repomodel.dart';

class RepoController extends GetxController {
  var repos = <RepoModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    log(" STORED TOKEN: ${ApiService.token}");
    fetchRepos();
    super.onInit();
  }

  Future<void> fetchRepos() async {
    try {
      isLoading(true);
      log(" Fetching repos...");

      repos.value = await ApiService.getRepos();
      log("Repos fetched: ${repos.length}");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
