import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;
  final RxString errorMessage = ''.obs;
  
  String? schoolName;
  String? schoolLogo;

  @override
  void onInit() {
    super.onInit();
    _loadSchoolData();
  }

  void _loadSchoolData() {
    final school = _authRepository.getSchoolData();
    if (school != null) {
      schoolName = school.name;
      schoolLogo = school.logo;
    }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    
    errorMessage.value = '';
    isLoading.value = true;
    
    try {
      final user = await _authRepository.login(
        emailController.text.trim(),
        passwordController.text,
      );
      
      if (user != null) {
        await _authRepository.saveUserData(user);
        _navigateBasedOnRole(user.role);
      } else {
        errorMessage.value = 'Invalid email or password';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
    } finally {
      isLoading.value = false;
    }
  }

  void _navigateBasedOnRole(String role) {
    switch (role) {
      case AppConstants.roleTeacher:
        Get.offAllNamed(AppRoutes.teacherDashboard);
        break;
      case AppConstants.roleStudent:
        Get.offAllNamed(AppRoutes.studentDashboard);
        break;
      case AppConstants.roleParent:
        Get.offAllNamed(AppRoutes.parentDashboard);
        break;
      default:
        errorMessage.value = 'Unknown user role';
    }
  }

  void forgotPassword() {
    Get.snackbar(
      'Forgot Password',
      'Password reset functionality will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
