import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/student_profile_controller.dart';

class StudentProfileView extends GetView<StudentProfileController> {
  const StudentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: controller.openSettings,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGold),
          );
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return Center(
            child: Text(
              'Failed to load profile',
              style: GoogleFonts.lora(color: AppColors.textSecondary),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Card
              CustomCard(
                hasGoldBorder: true,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryGold.withOpacity(0.1),
                        border: Border.all(
                          color: AppColors.primaryGold,
                          width: 3,
                        ),
                      ),
                      child: profile.profilePhoto != null
                          ? ClipOval(
                              child: Image.network(
                                profile.profilePhoto!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Text(
                                profile.name.substring(0, 1).toUpperCase(),
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryGold,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      profile.name,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.primaryGold.withOpacity(0.3)),
                      ),
                      child: Text(
                        'Student',
                        style: GoogleFonts.lora(
                          fontSize: 14,
                          color: AppColors.primaryGold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Details Card
              CustomCard(
                child: Column(
                  children: [
                    _buildDetailRow(Icons.class_, 'Class', '${profile.className ?? ''} ${profile.section ?? ''}'),
                    const Divider(color: AppColors.border),
                    _buildDetailRow(Icons.numbers, 'Roll Number', profile.rollNumber ?? 'N/A'),
                    if (profile.attendancePercentage != null) ...[
                      const Divider(color: AppColors.border),
                      _buildDetailRow(
                        Icons.event_available,
                        'Attendance',
                        '${profile.attendancePercentage!.toStringAsFixed(1)}%',
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Parent Details
              if (profile.parentName != null)
                CustomCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.info.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.family_restroom, color: AppColors.info),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Parent Details',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(Icons.person_outline, 'Name', profile.parentName!),
                      if (profile.parentPhone != null) ...[
                        const Divider(color: AppColors.border),
                        _buildDetailRow(Icons.phone_outlined, 'Phone', profile.parentPhone!),
                      ],
                    ],
                  ),
                ),

              const SizedBox(height: 32),

              // Logout Button
              CustomButton(
                text: 'Logout',
                isOutlined: true,
                icon: Icons.logout,
                onPressed: () => _showLogoutDialog(context),
              ),

              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.textMuted),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.lora(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.lora(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Logout',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.lora(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.lora(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: Text(
              'Logout',
              style: GoogleFonts.lora(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
