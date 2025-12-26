import 'package:get/get.dart';
import '../../../data/models/student_model.dart';
import '../../../data/models/progress_model.dart';
import '../../../data/repositories/parent_repository.dart';

class ChildProgressController extends GetxController {
  final ParentRepository _repository = ParentRepository();
  
  final RxList<StudentModel> children = <StudentModel>[].obs;
  final Rx<StudentModel?> selectedChild = Rx<StudentModel?>(null);
  final Rx<ProgressModel?> childProgress = Rx<ProgressModel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isLoadingProgress = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadChildren();
  }

  Future<void> loadChildren() async {
    isLoading.value = true;
    try {
      final result = await _repository.getChildren();
      children.assignAll(result);
      if (result.isNotEmpty) {
        selectedChild.value = result.first;
        await loadChildProgress(result.first.id);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load children');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadChildProgress(String childId) async {
    isLoadingProgress.value = true;
    try {
      final result = await _repository.getChildProgress(childId);
      childProgress.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load progress');
    } finally {
      isLoadingProgress.value = false;
    }
  }

  void selectChild(StudentModel child) {
    selectedChild.value = child;
    loadChildProgress(child.id);
  }

  double get averageMarks {
    if (childProgress.value == null || childProgress.value!.subjectProgress.isEmpty) {
      return 0;
    }
    final total = childProgress.value!.subjectProgress.fold<double>(
      0,
      (sum, sp) => sum + sp.percentage,
    );
    return total / childProgress.value!.subjectProgress.length;
  }
}
