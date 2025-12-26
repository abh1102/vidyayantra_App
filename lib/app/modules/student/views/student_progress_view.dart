import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../controllers/student_progress_controller.dart';

class StudentProgressView extends GetView<StudentProgressController> {
  const StudentProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'My Progress',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryGold),
          );
        }

        final progress = controller.progress.value;
        if (progress == null) {
          return Center(
            child: Text(
              'No progress data available',
              style: GoogleFonts.lora(color: AppColors.textSecondary),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadProgress,
          color: AppColors.primaryGold,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overview Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildOverviewCard(
                        'Attendance',
                        '${progress.attendancePercentage.toStringAsFixed(1)}%',
                        Icons.event_available,
                        _getAttendanceColor(progress.attendancePercentage),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildOverviewCard(
                        'Avg. Marks',
                        '${controller.averageMarks.toStringAsFixed(1)}%',
                        Icons.grade,
                        AppColors.primaryGold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildOverviewCard(
                        'Homework',
                        '${progress.completedHomework}/${progress.totalHomework}',
                        Icons.assignment_turned_in,
                        AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildOverviewCard(
                        'Completion',
                        '${progress.homeworkCompletionRate.toStringAsFixed(0)}%',
                        Icons.pie_chart,
                        AppColors.info,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Subject Wise Marks
                Text(
                  'Subject-wise Performance',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 16),

                ...progress.subjectProgress.map((sp) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildSubjectCard(sp),
                )),

                const SizedBox(height: 24),

                // Performance Summary
                CustomCard(
                  hasGoldBorder: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryGold.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.insights,
                              color: AppColors.primaryGold,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Performance Summary',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Overall Grade', _getOverallGrade(controller.averageMarks)),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Attendance Status', _getAttendanceStatus(progress.attendancePercentage)),
                      const SizedBox(height: 8),
                      _buildSummaryRow('Homework Status', _getHomeworkStatus(progress.homeworkCompletionRate)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildOverviewCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.lora(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(dynamic sp) {
    final color = _getGradeColor(sp.percentage);
    
    return CustomCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  sp.subject,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  sp.grade ?? _getGrade(sp.percentage),
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: sp.percentage / 100,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${sp.marks.toStringAsFixed(0)}/${sp.totalMarks.toStringAsFixed(0)}',
                style: GoogleFonts.lora(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.lora(
            fontSize: 14,
            color: AppColors.textSecondary,
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
    );
  }

  Color _getAttendanceColor(double percentage) {
    if (percentage >= 90) return AppColors.success;
    if (percentage >= 75) return AppColors.warning;
    return AppColors.error;
  }

  Color _getGradeColor(double percentage) {
    if (percentage >= 90) return AppColors.success;
    if (percentage >= 75) return AppColors.info;
    if (percentage >= 60) return AppColors.warning;
    return AppColors.error;
  }

  String _getGrade(double percentage) {
    if (percentage >= 90) return 'A+';
    if (percentage >= 80) return 'A';
    if (percentage >= 70) return 'B+';
    if (percentage >= 60) return 'B';
    if (percentage >= 50) return 'C';
    return 'D';
  }

  String _getOverallGrade(double avgMarks) {
    if (avgMarks >= 90) return 'Excellent (A+)';
    if (avgMarks >= 80) return 'Very Good (A)';
    if (avgMarks >= 70) return 'Good (B+)';
    if (avgMarks >= 60) return 'Average (B)';
    return 'Needs Improvement';
  }

  String _getAttendanceStatus(double percentage) {
    if (percentage >= 90) return 'Excellent';
    if (percentage >= 75) return 'Good';
    return 'Needs Improvement';
  }

  String _getHomeworkStatus(double rate) {
    if (rate >= 90) return 'Outstanding';
    if (rate >= 75) return 'Good';
    return 'Needs Attention';
  }
}
