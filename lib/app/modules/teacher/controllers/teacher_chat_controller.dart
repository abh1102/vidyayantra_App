import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/chat_model.dart';
import '../../../data/repositories/teacher_repository.dart';
import '../../../routes/app_routes.dart';

class TeacherChatController extends GetxController {
  final TeacherRepository _repository = TeacherRepository();
  
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

  void createGroup() {
    Get.snackbar('Coming Soon', 'Group creation will be available soon');
  }
}

class ChatDetailController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  
  late ChatModel chat;
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    chat = Get.arguments['chat'] as ChatModel;
    loadMessages();
  }

  Future<void> loadMessages() async {
    isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      messages.assignAll([
        MessageModel(
          id: 'm1',
          chatId: chat.id,
          senderId: 'other',
          senderName: chat.name,
          content: 'Hello, I have a question about today\'s homework.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        MessageModel(
          id: 'm2',
          chatId: chat.id,
          senderId: 'me',
          senderName: 'You',
          content: 'Sure, what is your question?',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        ),
        MessageModel(
          id: 'm3',
          chatId: chat.id,
          senderId: 'other',
          senderName: chat.name,
          content: 'I didn\'t understand exercise 5.3',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        ),
        MessageModel(
          id: 'm4',
          chatId: chat.id,
          senderId: 'me',
          senderName: 'You',
          content: 'Let me explain it to you. First, you need to...',
          timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        ),
      ]);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load messages');
    } finally {
      isLoading.value = false;
    }
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    
    messages.add(MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: chat.id,
      senderId: 'me',
      senderName: 'You',
      content: messageController.text.trim(),
      timestamp: DateTime.now(),
    ));
    
    messageController.clear();
  }

  void attachFile() {
    Get.snackbar('Coming Soon', 'File attachment will be available soon');
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
