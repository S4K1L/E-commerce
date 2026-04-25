import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/chat_message.dart';
import '../../widgets/app_back_button.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messages = List.of(SampleData.chatMessages);
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: const CachedNetworkImageProvider(
                  'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?w=200&q=80'),
              backgroundColor: AppColors.surface,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Esther Howard',
                    style: AppTextStyles.subtitle.copyWith(
                        fontWeight: FontWeight.w600)),
                Text('Online',
                    style: AppTextStyles.caption
                        .copyWith(color: AppColors.success)),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.call_outlined, color: AppColors.primary),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _bubble(_messages[i]),
            ),
          ),
          _inputBar(),
        ],
      ),
    );
  }

  Widget _bubble(ChatMessageModel m) {
    final me = m.isMe;
    final align = me ? Alignment.centerRight : Alignment.centerLeft;
    final bubbleColor = me ? AppColors.primary : AppColors.surface;
    final textColor = me ? Colors.white : AppColors.textPrimary;

    Widget content;
    switch (m.type) {
      case ChatMessageType.text:
        content = Text(m.content,
            style: AppTextStyles.body.copyWith(color: textColor));
        break;
      case ChatMessageType.image:
        content = ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: m.content,
            width: 180,
            height: 180,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) =>
                Container(width: 180, height: 180, color: AppColors.surface),
          ),
        );
        break;
      case ChatMessageType.voice:
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_arrow,
                color: me ? Colors.white : AppColors.primary),
            const SizedBox(width: 6),
            Container(
              width: 110,
              height: 4,
              decoration: BoxDecoration(
                color: me
                    ? Colors.white.withValues(alpha: 0.5)
                    : AppColors.border,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 6),
            Text('0:${(m.voiceDuration ?? 0).toString().padLeft(2, '0')}',
                style: AppTextStyles.caption.copyWith(color: textColor)),
          ],
        );
        break;
    }

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: m.type == ChatMessageType.image
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7),
        decoration: BoxDecoration(
          color: m.type == ChatMessageType.image
              ? Colors.transparent
              : bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomRight: Radius.circular(me ? 4 : 16),
            bottomLeft: Radius.circular(me ? 16 : 4),
          ),
        ),
        child: content,
      ),
    );
  }

  Widget _inputBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ctrl,
                decoration: InputDecoration(
                  hintText: 'Type a message here',
                  prefixIcon: const Icon(Icons.emoji_emotions_outlined,
                      color: AppColors.textSecondary),
                  suffixIcon: const Icon(Icons.attach_file,
                      color: AppColors.textSecondary),
                  fillColor: AppColors.surface,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (_ctrl.text.trim().isEmpty) return;
                setState(() {
                  _messages.add(ChatMessageModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    senderName: 'You',
                    senderAvatar: '',
                    isMe: true,
                    type: ChatMessageType.text,
                    content: _ctrl.text.trim(),
                    time: 'now',
                  ));
                  _ctrl.clear();
                });
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
