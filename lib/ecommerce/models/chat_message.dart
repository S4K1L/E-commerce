enum ChatMessageType { text, voice, image }

class ChatMessageModel {
  final String id;
  final String senderName;
  final String senderAvatar;
  final bool isMe;
  final ChatMessageType type;
  final String content;
  final String time;
  final int? voiceDuration;

  const ChatMessageModel({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.isMe,
    required this.type,
    required this.content,
    required this.time,
    this.voiceDuration,
  });
}
