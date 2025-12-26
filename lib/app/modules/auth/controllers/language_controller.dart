import 'dart:ui';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class LanguageController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  final RxString selectedLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedLanguage.value = _authRepository.getLanguage();
  }

  void selectLanguage(String language) {
    selectedLanguage.value = language;
  }

  Future<void> confirmLanguage() async {
    if (selectedLanguage.value.isEmpty) {
      Get.snackbar(
        'Select Language',
        'Please select a language to continue',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    
    await _authRepository.saveLanguage(selectedLanguage.value);
    
    // Update locale
    if (selectedLanguage.value == AppConstants.languageHindi) {
      Get.updateLocale(const Locale('hi', 'IN'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
    
    Get.offAllNamed(AppRoutes.login);
  }
}
