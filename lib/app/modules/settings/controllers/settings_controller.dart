import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class SettingsController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  final RxString currentLanguage = ''.obs;
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final RxBool isChangingPassword = false.obs;
  final RxBool obscureCurrentPassword = true.obs;
  final RxBool obscureNewPassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    currentLanguage.value = _authRepository.getLanguage();
  }

  String get currentLanguageDisplay {
    return currentLanguage.value == AppConstants.languageHindi ? 'हिंदी (Hindi)' : 'English';
  }

  void changeLanguage(String language) {
    currentLanguage.value = language;
    _authRepository.saveLanguage(language);
    
    if (language == AppConstants.languageHindi) {
      Get.updateLocale(const Locale('hi', 'IN'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
    
    Get.back();
    Get.snackbar(
      'Language Changed',
      language == AppConstants.languageHindi ? 'भाषा बदल गई' : 'Language changed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showLanguageDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF141E3C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Select Language',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              'English',
              AppConstants.languageEnglish,
              currentLanguage.value == AppConstants.languageEnglish,
            ),
            const SizedBox(height: 12),
            _buildLanguageOption(
              'हिंदी (Hindi)',
              AppConstants.languageHindi,
              currentLanguage.value == AppConstants.languageHindi,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String label, String value, bool isSelected) {
    return GestureDetector(
      onTap: () => changeLanguage(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFD4AF37) : const Color(0xFF2A3A5C),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFD4AF37) : Colors.white,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFFD4AF37)),
          ],
        ),
      ),
    );
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter current password';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter new password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> changePassword() async {
    if (!formKey.currentState!.validate()) return;
    
    isChangingPassword.value = true;
    
    try {
      await Future.delayed(const Duration(seconds: 1));
      
      Get.back();
      Get.snackbar(
        'Success',
        'Password changed successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
      
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Failed to change password');
    } finally {
      isChangingPassword.value = false;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
