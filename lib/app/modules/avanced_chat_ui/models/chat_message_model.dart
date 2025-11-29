import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/models/receiver_model.dart';

enum MessageType { text, file }

class ChatMessage {
  final String id;
  final String content;
  final MessageType type;
  final String sender;
  final Receiver receiver;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.type,
    required this.sender,
    required this.receiver,
    required this.timestamp,
  });
}

RxList<ChatMessage> dummyChatMessages = RxList<ChatMessage>.from([
  // first receiver
  ChatMessage(
    id: '1',
    content: 'Hello, how are you?',
    type: MessageType.text,
    sender: 'John Doe',
    receiver: dummyReceivers[0],
    timestamp: DateTime.now().subtract(const Duration(minutes: 10, days: 1)),
  ),
  ChatMessage(
    id: '2',
    content: 'I am fine, thank you!',
    type: MessageType.text,
    sender: 'Jane Doe',
    receiver: dummyReceivers[0],
    timestamp: DateTime.now().subtract(const Duration(minutes: 9, days: 2)),
  ),
  ChatMessage(
    id: '3',
    content: 'assets/images/1.png',
    type: MessageType.file,
    sender: 'John Doe',
    receiver: dummyReceivers[0],
    timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
  ),
  ChatMessage(
    id: '4',
    content: 'My name is John Doe',
    type: MessageType.text,
    sender: 'Jane Doe',
    receiver: dummyReceivers[0],
    timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
  ChatMessage(
    id: '5',
    content: 'assets/images/4.png',
    type: MessageType.file,
    sender: 'Jane Doe',
    receiver: dummyReceivers[0],
    timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
  ),
  // second receiver
  ChatMessage(
    id: '6',
    content: 'Hello, how are you?',
    type: MessageType.text,
    sender: 'John Doe',
    receiver: dummyReceivers[1],
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  ChatMessage(
    id: '7',
    content: 'I am fine, thank you!',
    type: MessageType.text,
    sender: 'Jane Doe',
    receiver: dummyReceivers[1],
    timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
  ),
  ChatMessage(
    id: '8',
    content: 'assets/images/1.png',
    type: MessageType.file,
    sender: 'John Doe',
    receiver: dummyReceivers[1],
    timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
  ),
  ChatMessage(
    id: '9',
    content: 'My name is John Doe',
    type: MessageType.text,
    sender: 'Jane Doe',
    receiver: dummyReceivers[1],
    timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
  ChatMessage(
    id: '10',
    content: 'assets/images/3.png',
    type: MessageType.file,
    sender: 'Jane Doe',
    receiver: dummyReceivers[1],
    timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
  ),
  ChatMessage(
    id: '11',
    content: 'Hello, how are you?',
    type: MessageType.text,
    sender: 'John Doe',
    receiver: dummyReceivers[1],
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  // third receiver
  ChatMessage(
    id: '12',
    content: 'Hello, how are you?',
    type: MessageType.text,
    sender: 'John Doe',
    receiver: dummyReceivers[2],
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  ChatMessage(
    id: '13',
    content: 'I am fine, thank you!',
    type: MessageType.text,
    sender: 'Jane Doe',
    receiver: dummyReceivers[2],
    timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
  ),
  ChatMessage(
    id: '14',
    content: 'assets/images/1.png',
    type: MessageType.file,
    sender: 'John Doe',
    receiver: dummyReceivers[2],
    timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
  ),
  ChatMessage(
    id: '15',
    content: 'My name is John Doe',
    type: MessageType.text,
    sender: 'Jane Doe',
    receiver: dummyReceivers[2],
    timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
  ),
  ChatMessage(
    id: '16',
    content: 'assets/images/1.png',
    type: MessageType.file,
    sender: 'Jane Doe',
    receiver: dummyReceivers[2],
    timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
  ),
]);
