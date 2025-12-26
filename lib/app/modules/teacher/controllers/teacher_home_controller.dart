import 'package:get/get.dart';
import '../../../data/models/class_model.dart';
import '../../../data/repositories/teacher_repository.dart';
import '../../../routes/app_routes.dart';

class TeacherHomeController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
  final RxList<ClassModel> classes = <ClassModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadClasses();
  }

  Future<void> loadClasses() async {
    isLoading.value = true;
    try {
      final result = await _repository.getAssignedClasses();
      classes.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load classes');
    } finally {
      isLoading.value = false;
    }
  }

  void openClass(ClassModel classModel) {
    Get.toNamed(
      AppRoutes.studentList,
      arguments: {'class': classModel},
    );
  }

  int get notificationCount => 3;
}
