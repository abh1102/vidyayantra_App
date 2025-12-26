import 'package:get/get.dart';
import 'app_routes.dart';

// Auth
import '../modules/auth/views/school_code_view.dart';
import '../modules/auth/views/language_selection_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/bindings/auth_binding.dart';

// Teacher
import '../modules/teacher/views/teacher_dashboard_view.dart';
import '../modules/teacher/views/student_list_view.dart';
import '../modules/teacher/views/student_detail_view.dart';
import '../modules/teacher/views/assign_homework_view.dart';
import '../modules/teacher/views/teacher_notify_view.dart';
import '../modules/teacher/views/chat_detail_view.dart';
import '../modules/teacher/bindings/teacher_binding.dart';

// Student
import '../modules/student/views/student_dashboard_view.dart';
import '../modules/student/views/homework_detail_view.dart';
import '../modules/student/bindings/student_binding.dart';

// Parent
import '../modules/parent/views/parent_dashboard_view.dart';
import '../modules/parent/bindings/parent_binding.dart';

// Common
import '../modules/common/views/profile_view.dart';
import '../modules/common/bindings/common_binding.dart';

// Settings
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/bindings/settings_binding.dart';

class AppPages {
  static final pages = [
    // Auth Pages
    GetPage(
      name: AppRoutes.schoolCode,
      page: () => const SchoolCodeView(),
      binding: SchoolCodeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.languageSelection,
      page: () => const LanguageSelectionView(),
      binding: LanguageSelectionBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
    ),
    
    // Teacher Pages
    GetPage(
      name: AppRoutes.teacherDashboard,
      page: () => const TeacherDashboardView(),
      binding: TeacherDashboardBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.studentList,
      page: () => const StudentListView(),
      binding: StudentListBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.studentDetail,
      page: () => const StudentDetailView(),
      binding: StudentDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.assignHomework,
      page: () => const AssignHomeworkView(),
      binding: AssignHomeworkBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.teacherNotify,
      page: () => const TeacherNotifyView(),
      binding: TeacherNotifyBinding(),
      transition: Transition.rightToLeft,
    ),
    
    // Student Pages
    GetPage(
      name: AppRoutes.studentDashboard,
      page: () => const StudentDashboardView(),
      binding: StudentDashboardBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.homeworkDetail,
      page: () => const HomeworkDetailView(),
      binding: HomeworkDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    
    // Parent Pages
    GetPage(
      name: AppRoutes.parentDashboard,
      page: () => const ParentDashboardView(),
      binding: ParentDashboardBinding(),
      transition: Transition.fadeIn,
    ),
    
    // Common Pages
    GetPage(
      name: AppRoutes.chatDetail,
      page: () => const ChatDetailView(),
      binding: ChatDetailBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
