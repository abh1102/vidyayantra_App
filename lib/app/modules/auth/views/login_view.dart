import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.navyGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // School Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryGold, width: 2),
                      color: AppColors.cardBackground,
                    ),
                    child: controller.schoolLogo != null
                        ? ClipOval(
                            child: Image.network(
                              controller.schoolLogo!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.school,
                            size: 50,
                            color: AppColors.primaryGold,
                          ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // School Name
                  Text(
                    controller.schoolName ?? 'VidyaYantra Academy',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Login Title
                  Text(
                    'Welcome Back',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Sign in to continue',
                    style: GoogleFonts.lora(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Email Field
                  CustomTextField(
                    controller: controller.emailController,
                    hintText: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Password Field
                  Obx(() => CustomTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.obscurePassword.value,
                    suffixIcon: controller.obscurePassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onSuffixTap: controller.togglePasswordVisibility,
                    validator: controller.validatePassword,
                  )),
                  
                  const SizedBox(height: 12),
                  
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.forgotPassword,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.lora(
                          color: AppColors.primaryGold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Error Message
                  Obx(() => controller.errorMessage.value.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.error.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.errorMessage.value,
                                  style: GoogleFonts.lora(
                                    color: AppColors.error,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()),
                  
                  // Login Button
                  Obx(() => CustomButton(
                    text: 'Login',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.login,
                  )),
                  
                  const SizedBox(height: 40),
                  
                  // Demo Credentials
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline, color: AppColors.primaryGold, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Demo Credentials',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildCredentialRow('Teacher', 'teacher@demo.com'),
                        _buildCredentialRow('Student', 'student@demo.com'),
                        _buildCredentialRow('Parent', 'parent@demo.com'),
                        const SizedBox(height: 8),
                        Text(
                          'Password: password',
                          style: GoogleFonts.lora(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCredentialRow(String role, String email) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(
              '$role:',
              style: GoogleFonts.lora(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            email,
            style: GoogleFonts.lora(
              fontSize: 12,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
