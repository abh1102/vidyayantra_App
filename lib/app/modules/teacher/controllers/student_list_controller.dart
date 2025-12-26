import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/class_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/repositories/teacher_repository.dart';
import '../../../routes/app_routes.dart';

class StudentListController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
  final TextEditingController searchController = TextEditingController();
  
  late ClassModel classModel;
  final RxList<StudentModel> students = <StudentModel>[].obs;
  final RxList<StudentModel> filteredStudents = <StudentModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    classModel = Get.arguments['class'] as ClassModel;
    loadStudents();
  }

  Future<void> loadStudents() async {
    isLoading.value = true;
    try {
      final result = await _repository.getStudentsByClass(classModel.id);
      students.assignAll(result);
      filteredStudents.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load students');
    } finally {
      isLoading.value = false;
    }
  }

  void searchStudents(String query) {
    if (query.isEmpty) {
      filteredStudents.assignAll(students);
    } else {
      filteredStudents.assignAll(
        students.where((s) => 
          s.name.toLowerCase().contains(query.toLowerCase()) ||
          (s.rollNumber?.contains(query) ?? false)
        ).toList(),
      );
    }
  }

  void openStudentDetail(StudentModel student) {
    Get.toNamed(
      AppRoutes.studentDetail,
      arguments: {'student': student, 'class': classModel},
    );
  }

  void assignHomeworkToClass() {
    Get.toNamed(
      AppRoutes.assignHomework,
      arguments: {'class': classModel, 'isClasswide': true},
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
