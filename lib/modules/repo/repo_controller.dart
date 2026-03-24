import 'package:get/get.dart';
import '../services/api_service.dart';

class RepoController extends GetxController {
  var repos = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchRepos();
    super.onInit();
  }

  Future<void> fetchRepos() async {
    try {
      isLoading(true);

      var data = await ApiService.getRepos();

      repos.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
