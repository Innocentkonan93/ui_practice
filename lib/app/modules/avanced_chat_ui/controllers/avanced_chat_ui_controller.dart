import 'dart:io';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/models/chat_message_model.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/models/receiver_model.dart';

class AvancedChatUiController extends GetxController {
  late final PageController pageController;
  Rxn<Receiver> selectedReceiver = Rxn<Receiver>();
  RxList<ChatMessage> messages = RxList<ChatMessage>.from([]);
  final RxDouble dragPercent = 0.0.obs;
  final RxBool showDateFilterDialog = false.obs;
  final RxList<Receiver> receivers = <Receiver>[].obs;
  final RxList<String> selectedImages = <String>[].obs;
  final RxList<String> selectedImagesPaths = <String>[].obs;
  final selectedMenu = 0.obs;
  final showMenu = false.obs;
  Rx<FocusNode> focusNode = FocusNode().obs;
  TextEditingController messageController = TextEditingController();
  late final ScrollController scrollController;
  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    pageController = PageController();
    receivers.value = List.from(dummyReceivers);
    selectReceiver(receivers[0]);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void selectReceiver(Receiver receiver) {
    selectedReceiver.value = receiver;
    messages.value = dummyChatMessages
        .where((element) => element.receiver.id == receiver.id)
        .toList();

    // Déplacer le receiver sélectionné à l'index 0
    final currentIndex = receivers.indexWhere((r) => r.id == receiver.id);
    if (currentIndex > 0) {
      receivers.removeAt(currentIndex);
      receivers.insert(0, receiver);
    }

    update();
  }

  void handleVerticalDrag({
    required double delta,
    required double screenHeight,
  }) {
    if (screenHeight == 0) return;
    print('delta: $delta');
    if (delta > 0) {
      resetDrag();
    } else {
      dragPercent.value = 0.1;
      // final updatedValue = dragPercent.value - delta / screenHeight;
    }
  }

  void resetDrag() {
    dragPercent.value = 0;
  }

  void sendFiles() {
    for (var image in selectedImagesPaths) {
      final message = ChatMessage(
        id: '${dummyChatMessages.length + 1}',
        content: image,
        type: MessageType.file,
        sender: 'John Doe',
        receiver: selectedReceiver.value!,
        timestamp: DateTime.now(),
      );
      log('message: ${message.content}');
      messages.add(message);
    }
    scrollToBottom();
    showMenu.value = false;
    receivers.value = List.from(dummyReceivers);
    selectedImages.value = [];
    selectedImagesPaths.value = [];
    update();
  }

  sendText() {
    final message = ChatMessage(
      id: '${dummyChatMessages.length + 1}',
      content: messageController.text,
      type: MessageType.text,
      sender: 'John Doe',
      receiver: selectedReceiver.value!,
      timestamp: DateTime.now(),
    );
    messages.add(message);
    showMenu.value = false;
    receivers.value = List.from(dummyReceivers);
    selectedImages.value = [];
    scrollToBottom();
    selectedImagesPaths.value = [];
    messageController.clear();
    update();
  }

  scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.decelerate,
      );
    });
  }
}
