import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/school_code_controller.dart';

class SchoolCodeView extends GetView<SchoolCodeController> {
  const SchoolCodeView({super.key});

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
                  const SizedBox(height: 60),
                  
                  // Logo Placeholder
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primaryGold, width: 3),
                      color: AppColors.cardBackground,
                    ),
                    child: const Icon(
                      Icons.school,
                      size: 60,
                      color: AppColors.primaryGold,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Title
                  Text(
                    'Welcome to',
                    style: GoogleFonts.lora(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'VidyaYantra',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGold,
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Enter School Code Title
                  Text(
                    'Enter School Code',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Please enter the unique code provided by your school',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // School Code Input
                  CustomTextField(
                    controller: controller.codeController,
                    hintText: 'School Code',
                    prefixIcon: Icons.vpn_key_outlined,
                    keyboardType: TextInputType.text,
                    validator: controller.validateCode,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Error Message
                  Obx(() => controller.errorMessage.value.isNotEmpty
                      ? Container(
                          padding: const EdgeInsets.all(12),
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
                  
                  const SizedBox(height: 32),
                  
                  // Submit Button
                  Obx(() => CustomButton(
                    text: 'Continue',
                    isLoading: controller.isLoading.value,
                    onPressed: controller.verifySchoolCode,
                    icon: Icons.arrow_forward,
                  )),
                  
                  const SizedBox(height: 40),
                  
                  // Demo hint
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline, color: AppColors.primaryGold, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Demo Codes',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryGold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try: DEMO123 or SCHOOL001',
                          style: GoogleFonts.lora(
                            fontSize: 13,
                            color: AppColors.textSecondary,
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
}
