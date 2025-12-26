import 'package:get/get.dart';
import '../../../data/models/homework_model.dart';
import '../../../data/repositories/student_repository.dart';
import '../../../routes/app_routes.dart';

class StudentTasksController extends GetxController {
  final StudentRepository _repository = StudentRepository();
  
  final RxList<HomeworkModel> homeworkList = <HomeworkModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString selectedFilter = 'all'.obs;

  @override
  void onInit() {
    super.onInit();
    loadHomework();
  }

  Future<void> loadHomework() async {
    isLoading.value = true;
    try {
      final result = await _repository.getHomeworkList();
      homeworkList.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load homework');
    } finally {
      isLoading.value = false;
    }
  }

  List<HomeworkModel> get filteredHomework {
    if (selectedFilter.value == 'all') {
      return homeworkList;
    }
    return homeworkList.where((h) => h.status.value == selectedFilter.value).toList();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void openHomeworkDetail(HomeworkModel homework) {
    Get.toNamed(
      AppRoutes.homeworkDetail,
      arguments: {'homework': homework},
    );
  }

  int get pendingCount => homeworkList.where((h) => h.status == HomeworkStatus.pending).length;
  int get completedCount => homeworkList.where((h) => h.status == HomeworkStatus.completed).length;
  int get overdueCount => homeworkList.where((h) => h.status == HomeworkStatus.overdue).length;
}
