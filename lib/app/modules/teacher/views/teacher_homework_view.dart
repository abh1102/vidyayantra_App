import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../controllers/teacher_homework_controller.dart';

class TeacherHomeworkView extends GetView<TeacherHomeworkController> {
  const TeacherHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Homework & Guides',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Tab Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    label: 'Homework',
                    isSelected: controller.selectedTab.value == 0,
                    onTap: () => controller.changeTab(0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton(
                    label: 'Exam Guides',
                    isSelected: controller.selectedTab.value == 1,
                    onTap: () => controller.changeTab(1),
                  ),
                ),
              ],
            )),
          ),

          // Content
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryGold),
                );
              }

              if (controller.selectedTab.value == 0) {
                return _buildHomeworkList();
              } else {
                return _buildExamGuidesList();
              }
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: controller.uploadContent,
        backgroundColor: AppColors.primaryGold,
        icon: const Icon(Icons.add, color: AppColors.primaryNavy),
        label: Text(
          'Upload',
          style: GoogleFonts.lora(
            color: AppColors.primaryNavy,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : AppColors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.playfairDisplay(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeworkList() {
    if (controller.homeworkList.isEmpty) {
      return _buildEmptyState('No homework assigned yet');
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.homeworkList.length,
      itemBuilder: (context, index) {
        final homework = controller.homeworkList[index];
        return CustomCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      homework.subject,
                      style: GoogleFonts.lora(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryGold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${homework.className ?? ''} ${homework.section ?? ''}',
                    style: GoogleFonts.lora(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                homework.description,
                style: GoogleFonts.lora(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  Text(
                    homework.dueDate != null
                        ? 'Due: ${DateFormat('MMM dd, yyyy').format(homework.dueDate!)}'
                        : 'No due date',
                    style: GoogleFonts.lora(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExamGuidesList() {
    if (controller.examGuides.isEmpty) {
      return _buildEmptyState('No exam guides uploaded yet');
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: controller.examGuides.length,
      itemBuilder: (context, index) {
        final guide = controller.examGuides[index];
        return CustomCard(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.info.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.description,
                  color: AppColors.info,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guide['title'],
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          guide['subject'],
                          style: GoogleFonts.lora(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat('MMM dd').format(guide['date']),
                          style: GoogleFonts.lora(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.download, color: AppColors.primaryGold),
                onPressed: () => controller.downloadContent(guide['id']),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.folder_open,
            size: 64,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.lora(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
