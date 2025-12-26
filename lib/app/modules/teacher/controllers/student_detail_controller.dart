import 'package:get/get.dart';
import '../../../data/models/class_model.dart';
import '../../../data/models/student_model.dart';
import '../../../data/repositories/teacher_repository.dart';
import '../../../routes/app_routes.dart';

class StudentDetailController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
  late StudentModel student;
  late ClassModel classModel;
  final Rx<StudentModel?> studentDetails = Rx<StudentModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    student = Get.arguments['student'] as StudentModel;
    classModel = Get.arguments['class'] as ClassModel;
    loadStudentDetails();
  }

  Future<void> loadStudentDetails() async {
    isLoading.value = true;
    try {
      final result = await _repository.getStudentDetails(student.id);
      studentDetails.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load student details');
    } finally {
      isLoading.value = false;
    }
  }

  void assignHomework() {
    Get.toNamed(
      AppRoutes.assignHomework,
      arguments: {'student': student, 'class': classModel, 'isClasswide': false},
    );
  }

  void viewPreviousTasks() {
    Get.snackbar('Coming Soon', 'Previous tasks feature will be available soon');
  }

  void notifyStudent() {
    Get.toNamed(
      AppRoutes.teacherNotify,
      arguments: {'type': 'student', 'recipient': student},
    );
  }

  void notifyParent() {
    Get.toNamed(
      AppRoutes.teacherNotify,
      arguments: {'type': 'parent', 'student': student},
    );
  }
}
