import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  final Rx<Map<String, dynamic>?> profile = Rx<Map<String, dynamic>?>(null);
  final RxBool isLoading = true.obs;
  final RxString userRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      final user = _authRepository.getCurrentUser();
      userRole.value = _authRepository.getUserRole() ?? '';
      
      if (user != null) {
        profile.value = {
          'name': user.name,
          'email': user.email,
          'phone': user.phone,
          'role': user.role,
          'profilePhoto': user.profilePhoto,
        };
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }

  String get roleDisplay {
    switch (userRole.value) {
      case AppConstants.roleTeacher:
        return 'Teacher';
      case AppConstants.roleStudent:
        return 'Student';
      case AppConstants.roleParent:
        return 'Parent';
      default:
        return 'User';
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
