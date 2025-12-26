import 'package:get/get.dart';
import '../controllers/parent_dashboard_controller.dart';
import '../controllers/child_progress_controller.dart';
import '../controllers/parent_chat_controller.dart';
import '../controllers/parent_profile_controller.dart';

class ParentDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentDashboardController>(() => ParentDashboardController());
    Get.lazyPut<ChildProgressController>(() => ChildProgressController());
    Get.lazyPut<ParentChatController>(() => ParentChatController());
    Get.lazyPut<ParentProfileController>(() => ParentProfileController());
  }
}
