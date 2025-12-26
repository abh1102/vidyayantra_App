import 'package:get/get.dart';
import '../controllers/student_dashboard_controller.dart';
import '../controllers/student_tasks_controller.dart';
import '../controllers/student_progress_controller.dart';
import '../controllers/student_chat_controller.dart';
import '../controllers/student_profile_controller.dart';
import '../controllers/homework_detail_controller.dart';

class StudentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDashboardController>(() => StudentDashboardController());
    Get.lazyPut<StudentTasksController>(() => StudentTasksController());
    Get.lazyPut<StudentProgressController>(() => StudentProgressController());
    Get.lazyPut<StudentChatController>(() => StudentChatController());
    Get.lazyPut<StudentProfileController>(() => StudentProfileController());
  }
}

class HomeworkDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeworkDetailController>(() => HomeworkDetailController());
  }
}
