import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../data/models/homework_model.dart';
import '../controllers/student_tasks_controller.dart';

class StudentTasksView extends GetView<StudentTasksController> {
  const StudentTasksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'My Tasks',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Stats Cards
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(() => Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Pending',
                    controller.pendingCount,
                    AppColors.warning,
                    Icons.pending_actions,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Completed',
                    controller.completedCount,
                    AppColors.success,
                    Icons.check_circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Overdue',
                    controller.overdueCount,
                    AppColors.error,
                    Icons.warning,
                  ),
                ),
              ],
            )),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Obx(() => Row(
              children: [
                _buildFilterChip('All', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Pending', 'pending'),
                const SizedBox(width: 8),
                _buildFilterChip('Completed', 'completed'),
                const SizedBox(width: 8),
                _buildFilterChip('Overdue', 'overdue'),
              ],
            )),
          ),

          const SizedBox(height: 16),

          // Homework List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryGold),
                );
              }

              final homework = controller.filteredHomework;

              if (homework.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.task_alt, size: 64, color: AppColors.textMuted),
                      const SizedBox(height: 16),
                      Text(
                        'No tasks found',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: controller.loadHomework,
                color: AppColors.primaryGold,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: homework.length,
                  itemBuilder: (context, index) {
                    final item = homework[index];
                    return _buildHomeworkCard(item);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            '$count',
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.lora(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = controller.selectedFilter.value == value;
    return GestureDetector(
      onTap: () => controller.setFilter(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGold : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryGold : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.lora(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppColors.primaryNavy : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildHomeworkCard(HomeworkModel homework) {
    final statusColor = _getStatusColor(homework.status);
    
    return CustomCard(
      onTap: () => controller.openHomeworkDetail(homework),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  homework.status.value.toUpperCase(),
                  style: GoogleFonts.lora(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
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
              const Icon(Icons.person_outline, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                homework.teacherName ?? 'Unknown',
                style: GoogleFonts.lora(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.calendar_today, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 4),
              Text(
                homework.dueDate != null
                    ? 'Due: ${DateFormat('MMM dd').format(homework.dueDate!)}'
                    : 'No due date',
                style: GoogleFonts.lora(
                  fontSize: 12,
                  color: homework.status == HomeworkStatus.overdue
                      ? AppColors.error
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(HomeworkStatus status) {
    switch (status) {
      case HomeworkStatus.completed:
        return AppColors.success;
      case HomeworkStatus.overdue:
        return AppColors.error;
      case HomeworkStatus.pending:
        return AppColors.warning;
    }
  }
}
