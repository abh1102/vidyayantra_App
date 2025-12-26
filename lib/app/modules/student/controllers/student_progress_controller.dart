import 'package:get/get.dart';
import '../../../data/models/progress_model.dart';
import '../../../data/repositories/student_repository.dart';

class StudentProgressController extends GetxController {
  final StudentRepository _repository = StudentRepository();
  
  final Rx<ProgressModel?> progress = Rx<ProgressModel?>(null);
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProgress();
  }

  Future<void> loadProgress() async {
    isLoading.value = true;
    try {
      final result = await _repository.getProgress();
      progress.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load progress');
    } finally {
      isLoading.value = false;
    }
  }

  double get averageMarks {
    if (progress.value == null || progress.value!.subjectProgress.isEmpty) {
      return 0;
    }
    final total = progress.value!.subjectProgress.fold<double>(
      0,
      (sum, sp) => sum + sp.percentage,
    );
    return total / progress.value!.subjectProgress.length;
  }
}
