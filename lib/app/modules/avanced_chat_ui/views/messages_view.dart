import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/controllers/avanced_chat_ui_controller.dart';
import 'package:ui_challenge/app/modules/avanced_chat_ui/views/custom_date_filter_dialog.dart';
import 'package:ui_challenge/app/widgets/image_viewer.dart';

import '../models/chat_message_model.dart';

class MessagesView extends StatelessWidget {
  final String currentUser;

  MessagesView({
    super.key,
    this.currentUser = 'John Doe',
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvancedChatUiController>(builder: (controller) {
      final sortedMessages = List<ChatMessage>.from(controller.messages.value)
        ..sort(
          (a, b) => a.timestamp.compareTo(b.timestamp),
        );
      if (sortedMessages.isEmpty) {
        return const Center(
          child: Text('Aucun message pour le moment'),
        );
      }
      return SafeArea(
        bottom: false,
        child: ListView.separated(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          itemCount: sortedMessages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          reverse: false,
          itemBuilder: (context, index) {
            final message = sortedMessages[index];
            final isCurrentUser = message.sender == currentUser;
            final nextMessage = index + 1 < sortedMessages.length
                ? sortedMessages[index + 1]
                : null;
            final showDateHeader = nextMessage == null ||
                !_isSameDay(message.timestamp, nextMessage.timestamp);
            final dateLabel =
                DateFormat.yMMMMd('fr_FR').format(message.timestamp);
            return _MessageBubble(
              message: message,
              isCurrentUser: isCurrentUser,
              showDateHeader: showDateHeader,
              dateLabel: dateLabel,
            );
          },
        ),
      );
    });
  }
}

bool _isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isCurrentUser;
  final bool showDateHeader;
  final String dateLabel;

  const _MessageBubble({
    required this.message,
    required this.isCurrentUser,
    required this.showDateHeader,
    required this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bubbleColor = isCurrentUser
        ? theme.colorScheme.primary
        : theme.colorScheme.surfaceContainerHighest;
    final textColor = isCurrentUser
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.onSurface;
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(18),
      topRight: const Radius.circular(18),
      bottomLeft:
          isCurrentUser ? const Radius.circular(18) : const Radius.circular(4),
      bottomRight:
          isCurrentUser ? const Radius.circular(4) : const Radius.circular(18),
    );
    final bubble = Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (showDateHeader)
          GestureDetector(
            onTap: () {
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel:
                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black12,
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const CustomDateFilterDialog();
                },
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ));
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      dateLabel,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        Align(
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: bubbleColor,
                shape: RoundedSuperellipseBorder(
                  borderRadius: borderRadius,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _MessageContent(
                      message: message,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(message.timestamp),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color:
                                isCurrentUser ? Colors.white : Colors.black45,
                          ),
                        ),
                        Icon(
                          Icons.check_rounded,
                          size: 12,
                          color: isCurrentUser ? Colors.white : Colors.black45,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return bubble
        .animate(
          key: ValueKey('message-bubble-${message.id}-$isCurrentUser'),
        )
        .slideX(
          begin: isCurrentUser ? 2 : -2,
          end: 0,
          curve: Curves.decelerate,
          duration: 800.ms,
        );
  }
}

class _MessageContent extends StatelessWidget {
  final ChatMessage message;
  final Color textColor;

  const _MessageContent({
    required this.message,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    switch (message.type) {
      case MessageType.text:
        return Text(
          message.content,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        );
      case MessageType.file:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => ImageViewer(
                      imageUrl: message.content,
                    ),
                    fullscreenDialog: true,
                    transition: Transition.fadeIn,
                  );
                },
                child: Hero(
                  tag: message.content,
                  child: Image.asset(
                    message.content,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }
}
