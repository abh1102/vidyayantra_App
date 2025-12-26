import 'package:get_storage/get_storage.dart';
import '../constants/app_constants.dart';
import '../../routes/app_routes.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static String getInitialRoute() {
    final schoolCode = _storage.read(AppConstants.schoolCodeKey);
    final userToken = _storage.read(AppConstants.userTokenKey);
    final userRole = _storage.read(AppConstants.userRoleKey);

    if (schoolCode == null) {
      return AppRoutes.schoolCode;
    }

    if (userToken == null) {
      return AppRoutes.login;
    }

    switch (userRole) {
      case AppConstants.roleTeacher:
        return AppRoutes.teacherDashboard;
      case AppConstants.roleStudent:
        return AppRoutes.studentDashboard;
      case AppConstants.roleParent:
        return AppRoutes.parentDashboard;
      default:
        return AppRoutes.login;
    }
  }
}
