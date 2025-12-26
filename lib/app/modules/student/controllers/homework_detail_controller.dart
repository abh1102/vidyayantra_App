import 'package:get/get.dart';
import '../../../data/models/homework_model.dart';
import '../../../data/repositories/student_repository.dart';

class HomeworkDetailController extends GetxController {
  final StudentRepository _repository = StudentRepository();
  
  late HomeworkModel homework;
  final Rx<HomeworkModel?> homeworkDetails = Rx<HomeworkModel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isMarking = false.obs;

  @override
  void onInit() {
    super.onInit();
    homework = Get.arguments['homework'] as HomeworkModel;
    loadHomeworkDetails();
  }

  Future<void> loadHomeworkDetails() async {
    isLoading.value = true;
    try {
      final result = await _repository.getHomeworkDetails(homework.id);
      homeworkDetails.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load homework details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markAsCompleted() async {
    isMarking.value = true;
    try {
      final success = await _repository.markHomeworkComplete(homework.id);
      if (success) {
        Get.back();
        Get.snackbar(
          'Success',
          'Homework marked as completed',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar('Error', 'Failed to mark homework as completed');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isMarking.value = false;
    }
  }

  void downloadAttachment() {
    Get.snackbar('Download', 'Downloading attachment...');
  }
}
