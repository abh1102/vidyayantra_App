import 'package:get_storage/get_storage.dart';
import '../models/school_model.dart';
import '../models/user_model.dart';
import '../../core/constants/app_constants.dart';

class AuthRepository {
  final GetStorage _storage = GetStorage();

  Future<SchoolModel?> verifySchoolCode(String code) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (code.toLowerCase() == 'demo123' || code.toLowerCase() == 'school001') {
      return SchoolModel(
        id: '1',
        code: code,
        name: 'VidyaYantra Academy',
        logo: null,
        address: '123 Education Lane, Knowledge City',
      );
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (email == 'teacher@demo.com' && password == 'password') {
      return UserModel(
        id: 't1',
        name: 'Mr. Sharma',
        email: email,
        role: AppConstants.roleTeacher,
        token: 'demo_token_teacher',
      );
    } else if (email == 'student@demo.com' && password == 'password') {
      return UserModel(
        id: 's1',
        name: 'Rahul Kumar',
        email: email,
        role: AppConstants.roleStudent,
        token: 'demo_token_student',
      );
    } else if (email == 'parent@demo.com' && password == 'password') {
      return UserModel(
        id: 'p1',
        name: 'Mr. Kumar',
        email: email,
        role: AppConstants.roleParent,
        token: 'demo_token_parent',
      );
    }
    return null;
  }

  Future<void> saveSchoolData(SchoolModel school) async {
    await _storage.write(AppConstants.schoolDataKey, school.toJson());
    await _storage.write(AppConstants.schoolCodeKey, school.code);
  }

  SchoolModel? getSchoolData() {
    final data = _storage.read(AppConstants.schoolDataKey);
    if (data != null) {
      return SchoolModel.fromJson(Map<String, dynamic>.from(data));
    }
    return null;
  }

  Future<void> saveLanguage(String language) async {
    await _storage.write(AppConstants.languageKey, language);
  }

  String getLanguage() {
    return _storage.read(AppConstants.languageKey) ?? AppConstants.languageEnglish;
  }

  Future<void> saveUserData(UserModel user) async {
    await _storage.write(AppConstants.userIdKey, user.id);
    await _storage.write(AppConstants.userRoleKey, user.role);
    await _storage.write(AppConstants.userTokenKey, user.token);
    await _storage.write('user_data', user.toJson());
  }

  String? getUserRole() {
    return _storage.read(AppConstants.userRoleKey);
  }

  String? getUserToken() {
    return _storage.read(AppConstants.userTokenKey);
  }

  UserModel? getCurrentUser() {
    final userId = _storage.read(AppConstants.userIdKey);
    final role = _storage.read(AppConstants.userRoleKey);
    final userData = _storage.read('user_data');
    
    if (userData != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userData));
    }
    
    if (userId != null && role != null) {
      return UserModel(
        id: userId,
        name: role == AppConstants.roleTeacher ? 'Mr. Sharma' 
            : role == AppConstants.roleStudent ? 'Rahul Kumar' 
            : 'Mr. Kumar',
        email: role == AppConstants.roleTeacher ? 'teacher@demo.com'
            : role == AppConstants.roleStudent ? 'student@demo.com'
            : 'parent@demo.com',
        role: role,
        phone: '+91 98765 43210',
      );
    }
    return null;
  }

  bool isLoggedIn() {
    return _storage.read(AppConstants.userTokenKey) != null;
  }

  bool hasSchoolCode() {
    return _storage.read(AppConstants.schoolCodeKey) != null;
  }

  Future<void> logout() async {
    await _storage.remove(AppConstants.userTokenKey);
    await _storage.remove(AppConstants.userRoleKey);
    await _storage.remove(AppConstants.userIdKey);
    await _storage.remove('user_data');
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
