import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/models/class_model.dart';
import '../../../data/repositories/teacher_repository.dart';

class TeacherNotifyController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
  final TextEditingController messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  final RxString selectedType = 'student'.obs;
  final RxBool isLoading = false.obs;
  
  StudentModel? student;
  ClassModel? classModel;
  String? initialType;

  final List<Map<String, dynamic>> notifyOptions = [
    {'value': 'student', 'label': 'Notify Student', 'icon': Icons.person},
    {'value': 'parent', 'label': 'Notify Parent', 'icon': Icons.family_restroom},
    {'value': 'class', 'label': 'Notify Class', 'icon': Icons.groups},
  ];

  @override
  void onInit() {
    super.onInit();
    initialType = Get.arguments?['type'];
    student = Get.arguments?['recipient'] ?? Get.arguments?['student'];
    classModel = Get.arguments?['class'];
    
    if (initialType != null) {
      selectedType.value = initialType!;
    }
  }

  void selectType(String type) {
    selectedType.value = type;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a message';
    }
    if (value.length < 5) {
      return 'Message must be at least 5 characters';
    }
    return null;
  }

  Future<void> sendNotification() async {
    if (!formKey.currentState!.validate()) return;
    
    isLoading.value = true;
    
    try {
      final success = await _repository.sendNotification(
        type: selectedType.value,
        message: messageController.text,
        recipientId: student?.id,
        classId: classModel?.id,
      );
      
      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          'Notification sent successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar('Error', 'Failed to send notification');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
