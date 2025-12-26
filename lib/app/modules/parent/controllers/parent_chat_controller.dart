import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/repositories/parent_repository.dart';
import '../../../routes/app_routes.dart';

class ParentChatController extends GetxController {
  final ParentRepository _repository = ParentRepository();
  
  final RxList<ChatModel> chats = <ChatModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadChats();
  }

  Future<void> loadChats() async {
    isLoading.value = true;
    try {
      final result = await _repository.getChats();
      chats.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chats');
    } finally {
      isLoading.value = false;
    }
  }

  void openChat(ChatModel chat) {
    Get.toNamed(
      AppRoutes.chatDetail,
      arguments: {'chat': chat},
    );
  }
}
