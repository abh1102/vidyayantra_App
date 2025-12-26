import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/repositories/student_repository.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class StudentProfileController extends GetxController {
  final StudentRepository _repository = StudentRepository();
  final AuthRepository _authRepository = AuthRepository();
  
  final Rx<StudentModel?> profile = Rx<StudentModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      final result = await _repository.getProfile();
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
