import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/teacher_notify_controller.dart';

class TeacherNotifyView extends GetView<TeacherNotifyController> {
  const TeacherNotifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Send Notification',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notify To',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),

              // Notify Options
              Obx(() => Column(
                children: controller.notifyOptions.map((option) {
                  final isSelected = controller.selectedType.value == option['value'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => controller.selectType(option['value']),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryGold.withOpacity(0.1)
                              : AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? AppColors.primaryGold : AppColors.border,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryGold.withOpacity(0.2)
                                    : AppColors.backgroundLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                option['icon'],
                                color: isSelected ? AppColors.primaryGold : AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                option['label'],
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? AppColors.primaryGold : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Container(
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
                                  ? const Icon(Icons.check, size: 16, color: AppColors.primaryNavy)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),

              const SizedBox(height: 24),

              Text(
                'Message',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              CustomTextField(
                controller: controller.messageController,
                hintText: 'Type your message here...',
                maxLines: 6,
                validator: controller.validateMessage,
              ),

              const SizedBox(height: 32),

              Obx(() => CustomButton(
                text: 'Send Notification',
                isLoading: controller.isLoading.value,
                onPressed: controller.sendNotification,
                icon: Icons.send,
              )),

              const SizedBox(height: 24),

              // Info Card
              CustomCard(
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.info, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Notifications will be sent as push notifications to the selected recipients.',
                        style: GoogleFonts.lora(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
