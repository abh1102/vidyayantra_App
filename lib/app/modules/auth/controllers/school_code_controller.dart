import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class SchoolCodeController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  final TextEditingController codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter school code';
    }
    if (value.length < 4) {
      return 'School code must be at least 4 characters';
    }
    return null;
  }

  Future<void> verifySchoolCode() async {
    if (!formKey.currentState!.validate()) return;
    
    errorMessage.value = '';
    isLoading.value = true;
    
    try {
      final school = await _authRepository.verifySchoolCode(codeController.text.trim());
      
      if (school != null) {
        await _authRepository.saveSchoolData(school);
        Get.offAllNamed(AppRoutes.languageSelection);
      } else {
        errorMessage.value = 'Invalid or expired school code. Please try again.';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
