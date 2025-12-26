import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controllers/assign_homework_controller.dart';

class AssignHomeworkView extends GetView<AssignHomeworkController> {
  const AssignHomeworkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Assign Homework',
          style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Assign To Card
              CustomCard(
                hasGoldBorder: true,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        controller.isClasswide ? Icons.groups : Icons.person,
                        color: AppColors.primaryGold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Assigning to',
                            style: GoogleFonts.lora(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Text(
                            controller.assignTo,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Subject Dropdown
              Text(
                'Subject',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedSubject.value.isEmpty
                        ? null
                        : controller.selectedSubject.value,
                    hint: Text(
                      'Select Subject',
                      style: GoogleFonts.lora(color: AppColors.textMuted),
                    ),
                    isExpanded: true,
                    dropdownColor: AppColors.cardBackground,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGold),
                    items: controller.subjects.map((subject) {
                      return DropdownMenuItem(
                        value: subject,
                        child: Text(
                          subject,
                          style: GoogleFonts.lora(color: AppColors.textPrimary),
                        ),
                      );
                    }).toList(),
                    onChanged: controller.selectSubject,
                  ),
                ),
              )),

              const SizedBox(height: 24),

              // Description
              Text(
                'Homework Description',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                controller: controller.descriptionController,
                hintText: 'Enter homework details...',
                maxLines: 5,
                validator: controller.validateDescription,
              ),

              const SizedBox(height: 24),

              // Due Date
              Text(
                'Due Date',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => GestureDetector(
                onTap: () => controller.selectDueDate(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, color: AppColors.primaryGold),
                      const SizedBox(width: 12),
                      Text(
                        controller.dueDate.value != null
                            ? DateFormat('EEEE, MMM dd, yyyy').format(controller.dueDate.value!)
                            : 'Select due date',
                        style: GoogleFonts.lora(
                          fontSize: 16,
                          color: controller.dueDate.value != null
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

              const SizedBox(height: 24),

              // Attachment
              Text(
                'Attachment (Optional)',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => controller.attachment.value == null
                  ? GestureDetector(
                      onTap: controller.pickFile,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.border,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.cloud_upload_outlined,
                              size: 48,
                              color: AppColors.primaryGold,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap to upload PDF or Image',
                              style: GoogleFonts.lora(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.success.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.insert_drive_file,
                              color: AppColors.success,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.attachment.value!.name,
                                  style: GoogleFonts.lora(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${(controller.attachment.value!.size / 1024).toStringAsFixed(1)} KB',
                                  style: GoogleFonts.lora(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: AppColors.error),
                            onPressed: controller.removeAttachment,
                          ),
                        ],
                      ),
                    )),

              const SizedBox(height: 32),

              // Submit Button
              Obx(() => CustomButton(
                text: 'Assign Homework',
                isLoading: controller.isLoading.value,
                onPressed: controller.submitHomework,
                icon: Icons.send,
              )),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
