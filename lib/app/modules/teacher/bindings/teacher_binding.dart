import 'package:get/get.dart';
import '../controllers/teacher_dashboard_controller.dart';
import '../controllers/teacher_home_controller.dart';
import '../controllers/teacher_homework_controller.dart';
import '../controllers/teacher_notify_controller.dart';
import '../controllers/teacher_chat_controller.dart';
import '../controllers/student_list_controller.dart';
import '../controllers/student_detail_controller.dart';
import '../controllers/assign_homework_controller.dart';

class TeacherDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherDashboardController>(() => TeacherDashboardController());
    Get.lazyPut<TeacherHomeController>(() => TeacherHomeController());
    Get.lazyPut<TeacherHomeworkController>(() => TeacherHomeworkController());
    Get.lazyPut<TeacherNotifyController>(() => TeacherNotifyController());
    Get.lazyPut<TeacherChatController>(() => TeacherChatController());
  }
}

class StudentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentListController>(() => StudentListController());
  }
}

class StudentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentDetailController>(() => StudentDetailController());
  }
}

class AssignHomeworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignHomeworkController>(() => AssignHomeworkController());
  }
}

class TeacherNotifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherNotifyController>(() => TeacherNotifyController());
  }
}

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailController>(() => ChatDetailController());
  }
}
