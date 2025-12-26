import 'package:get/get.dart';
import '../controllers/school_code_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/login_controller.dart';

class SchoolCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchoolCodeController>(() => SchoolCodeController());
  }
}

class LanguageSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(() => LanguageController());
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
