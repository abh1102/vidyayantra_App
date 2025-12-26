import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../../data/models/class_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/models/homework_model.dart';
import '../../../data/repositories/teacher_repository.dart';

class AssignHomeworkController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  ClassModel? classModel;
  StudentModel? student;
  bool isClasswide = true;
  
  final RxString selectedSubject = ''.obs;
  final Rx<DateTime?> dueDate = Rx<DateTime?>(null);
  final Rx<PlatformFile?> attachment = Rx<PlatformFile?>(null);
  final RxBool isLoading = false.obs;

  final List<String> subjects = [
    'Mathematics',
    'Science',
    'English',
    'Hindi',
    'Social Studies',
    'Computer Science',
    'Physics',
    'Chemistry',
    'Biology',
  ];

  @override
  void onInit() {
    super.onInit();
    classModel = Get.arguments?['class'] as ClassModel?;
    student = Get.arguments?['student'] as StudentModel?;
    isClasswide = Get.arguments?['isClasswide'] ?? true;
  }

  String get assignTo {
    if (isClasswide && classModel != null) {
      return 'Entire ${classModel!.displayName}';
    } else if (student != null) {
      return student!.name;
    }
    return 'Unknown';
  }

  void selectSubject(String? subject) {
    if (subject != null) {
      selectedSubject.value = subject;
    }
  }

  Future<void> selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      dueDate.value = picked;
    }
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
    );
    if (result != null && result.files.isNotEmpty) {
      attachment.value = result.files.first;
    }
  }

  void removeAttachment() {
    attachment.value = null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter homework description';
    }
    if (value.length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }

  Future<void> submitHomework() async {
    if (!formKey.currentState!.validate()) return;
    
    if (selectedSubject.value.isEmpty) {
      Get.snackbar('Error', 'Please select a subject');
      return;
    }
    
    if (dueDate.value == null) {
      Get.snackbar('Error', 'Please select a due date');
      return;
    }
    
    isLoading.value = true;
    
    try {
      final homework = HomeworkModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        subject: selectedSubject.value,
        description: descriptionController.text,
        dueDate: dueDate.value,
        createdAt: DateTime.now(),
        className: classModel?.name,
        section: classModel?.section,
      );
      
      final success = await _repository.assignHomework(homework);
      
      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          'Homework assigned successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar('Error', 'Failed to assign homework');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    super.onClose();
  }
}
