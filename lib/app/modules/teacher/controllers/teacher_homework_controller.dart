import 'package:get/get.dart';
import '../../../data/models/homework_model.dart';
import '../../../data/repositories/teacher_repository.dart';

class TeacherHomeworkController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
  final RxInt selectedTab = 0.obs;
  final RxList<HomeworkModel> homeworkList = <HomeworkModel>[].obs;
  final RxList<Map<String, dynamic>> examGuides = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomework();
  }

  void changeTab(int index) {
    selectedTab.value = index;
    if (index == 0) {
      loadHomework();
    } else {
      loadExamGuides();
    }
  }

  Future<void> loadHomework() async {
    isLoading.value = true;
    try {
      final result = await _repository.getAssignedHomework();
      homeworkList.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load homework');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadExamGuides() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      examGuides.assignAll([
        {
          'id': 'eg1',
          'title': 'Mid-Term Exam Guide',
          'subject': 'Mathematics',
          'date': DateTime.now().subtract(const Duration(days: 5)),
        },
        {
          'id': 'eg2',
          'title': 'Chapter 5 Practice Paper',
          'subject': 'Science',
          'date': DateTime.now().subtract(const Duration(days: 10)),
        },
        {
          'id': 'eg3',
          'title': 'Final Exam Preparation',
          'subject': 'English',
          'date': DateTime.now().subtract(const Duration(days: 15)),
        },
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load exam guides');
    } finally {
      isLoading.value = false;
    }
  }

  void uploadContent() {
    Get.snackbar('Coming Soon', 'Upload feature will be available soon');
  }

  void downloadContent(String id) {
    Get.snackbar('Download', 'Downloading content...');
  }
}
