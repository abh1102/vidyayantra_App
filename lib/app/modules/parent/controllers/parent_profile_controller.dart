import 'package:get/get.dart';
import '../../../data/repositories/parent_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class ParentProfileController extends GetxController {
  final ParentRepository _repository = ParentRepository();
  final AuthRepository _authRepository = AuthRepository();
  
  final Rx<Map<String, dynamic>?> profile = Rx<Map<String, dynamic>?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      final result = await _repository.getParentProfile();
      profile.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }

  void openSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
