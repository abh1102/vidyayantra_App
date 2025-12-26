import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/language_controller.dart';

class LanguageSelectionView extends GetView<LanguageController> {
  const LanguageSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.navyGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                
                // Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primaryGold, width: 2),
                    color: AppColors.cardBackground,
                  ),
                  child: const Icon(
                    Icons.translate,
                    size: 50,
                    color: AppColors.primaryGold,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Title
                Text(
                  'Choose Language',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'भाषा चुनें',
                  style: GoogleFonts.lora(
                    fontSize: 20,
                    color: AppColors.primaryGold,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  'Select your preferred language for the app',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Language Options
                Expanded(
                  child: Row(
                    children: [
                      // Hindi
                      Expanded(
                        child: Obx(() => _LanguageCard(
                          title: 'हिंदी',
                          subtitle: 'Hindi',
                          icon: 'अ',
                          isSelected: controller.selectedLanguage.value == AppConstants.languageHindi,
                          onTap: () => controller.selectLanguage(AppConstants.languageHindi),
                        )),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // English
                      Expanded(
                        child: Obx(() => _LanguageCard(
                          title: 'English',
                          subtitle: 'अंग्रेज़ी',
                          icon: 'A',
                          isSelected: controller.selectedLanguage.value == AppConstants.languageEnglish,
                          onTap: () => controller.selectLanguage(AppConstants.languageEnglish),
                        )),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Text(
                  'You can change the language later in settings',
                  style: GoogleFonts.lora(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Continue Button
                CustomButton(
                  text: 'Continue',
                  onPressed: controller.confirmLanguage,
                  icon: Icons.arrow_forward,
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primaryGold.withOpacity(0.1) 
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primaryGold.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected 
                    ? AppColors.primaryGold.withOpacity(0.2)
                    : AppColors.backgroundLight,
                border: Border.all(
                  color: isSelected ? AppColors.primaryGold : AppColors.border,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppColors.primaryGold : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryGold : AppColors.textPrimary,
              ),
            ),
            
            const SizedBox(height: 4),
            
            Text(
              subtitle,
              style: GoogleFonts.lora(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Selection Indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryGold : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primaryGold : AppColors.textMuted,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.primaryNavy,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
