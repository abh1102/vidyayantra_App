import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../controllers/student_list_controller.dart';

class StudentListView extends GetView<StudentListController> {
  const StudentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          controller.classModel.displayName,
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'Assign Homework to All',
              icon: Icons.assignment_add,
              onPressed: controller.assignHomeworkToClass,
            ),
          ),
          
          SearchTextField(
            controller: controller.searchController,
            hintText: 'Search by name or roll number...',
            onChanged: controller.searchStudents,
          ),
          
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryGold),
                );
              }

              if (controller.filteredStudents.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.search_off,
                        size: 64,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No students found',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = controller.filteredStudents[index];
                  return CustomCard(
                    onTap: () => controller.openStudentDetail(student),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryGold.withOpacity(0.1),
                            border: Border.all(
                              color: AppColors.primaryGold.withOpacity(0.3),
                            ),
                          ),
                          child: student.profilePhoto != null
                              ? ClipOval(
                                  child: Image.network(
                                    student.profilePhoto!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    student.name.substring(0, 1).toUpperCase(),
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryGold,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Roll No: ${student.rollNumber ?? 'N/A'}',
                                    style: GoogleFonts.lora(
                                      fontSize: 13,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  if (student.attendancePercentage != null) ...[
                                    const SizedBox(width: 16),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getAttendanceColor(student.attendancePercentage!).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        '${student.attendancePercentage!.toStringAsFixed(0)}%',
                                        style: GoogleFonts.lora(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: _getAttendanceColor(student.attendancePercentage!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.primaryGold,
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return AppColors.success;
    if (percentage >= 75) return AppColors.warning;
    return AppColors.error;
  }
}
