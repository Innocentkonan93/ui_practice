import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:record/record.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/models/chat_message_model.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/models/receiver_model.dart';
import 'package:waveform_recorder/waveform_recorder.dart';

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
  late final CameraController cameraController;
  late final WaveformRecorderController waveformRecorder;
  late final DraggableScrollableController draggableScrollableController;
  final recorder = AudioRecorder();
  final recordConfig = RecordConfig(
    sampleRate: 24000,
    encoder: AudioEncoder.pcm16bits,
    numChannels: 1,
  );
  final RxBool isCameraInitialized = false.obs;
  final RxBool isRecording = false.obs;
  final RxBool isRecordingPause = false.obs;

  @override
  void onInit() {
    super.onInit();
    initCamera();
    scrollController = ScrollController();
    pageController = PageController();
    draggableScrollableController = DraggableScrollableController();
    receivers.value = List.from(dummyReceivers);
    selectReceiver(receivers[0]);
    recorder.hasPermission();
    waveformRecorder = WaveformRecorderController(config: recordConfig);
    // Écouter les changements du contrôleur pour mettre à jour l'état
    waveformRecorder.addListener(() {
      isRecording.value = waveformRecorder.isRecording;
      update();
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    recorder.dispose();
    cameraController.dispose();
    waveformRecorder.dispose();
    super.onClose();
  }

  void initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.high,
      );
      await cameraController.initialize();
      isCameraInitialized.value = true;
    }
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
    if (messageController.text.isEmpty) return;
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

  Future<void> startRecording() async {
    try {
      // Démarrer l'enregistrement (le contrôleur gère les permissions et le chemin)
      await waveformRecorder.startRecording();
      isRecording.value = true;
      update();
    } catch (e) {
      log('Erreur lors du démarrage de l\'enregistrement: $e');
      Get.snackbar(
        'Erreur',
        'Impossible de démarrer l\'enregistrement',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> stopRecording({bool send = false}) async {
    print('sending');
    try {
      // if (!waveformRecorder.isRecording) return;

      // Arrêter l'enregistrement
      await waveformRecorder.stopRecording();
      // await waveformRecorder.stopRecording();
      isRecording.value = false;

      // Si send est true, envoyer le message audio
      if (send) {
        await sendAudio();
      } else {
        // Sinon, annuler l'enregistrement
        waveformRecorder.clear();
      }
      update();
    } catch (e) {
      log('Erreur lors de l\'arrêt de l\'enregistrement: $e');
      isRecording.value = false;
      update();
    }
  }

  Future<void> deleteRecording() async {
    await waveformRecorder.stopRecording();
    waveformRecorder.clear();
    update();
  }

  Future<void> pauseRecording() async {
    await waveformRecorder.pauseRecording();
    isRecordingPause.value = true;
    update();
  }

  Future<void> resumeRecording() async {
    await waveformRecorder.resumeRecording();
    isRecordingPause.value = false;

    update();
  }

  Future<void> sendAudio() async {
    final file = waveformRecorder.file;
    if (file == null) {
      Get.snackbar(
        'Erreur',
        'Aucun fichier audio à envoyer',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final message = ChatMessage(
      id: '${dummyChatMessages.length + 1}',
      content: file.path,
      type: MessageType.file,
      sender: 'John Doe',
      receiver: selectedReceiver.value!,
      timestamp: DateTime.now(),
    );

    messages.add(message);
    scrollToBottom();
    waveformRecorder.clear();
    update();
  }

  void toggleRecording() {
    if (!isRecordingPause.value) {
      pauseRecording();
    } else {
      resumeRecording();
    }
    update();
  }
}
