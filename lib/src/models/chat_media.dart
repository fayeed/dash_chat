part of dash_chat;

enum MimeType {
  image,
  video,
  audio,
  other,
}

class ChatMedia {
  final String src;
  final MimeType mimeType;
  final Function(String src)? builder;
  final DateTime uploadedDate;

  ChatMedia({
    required this.src,
    required this.mimeType,
    required this.uploadedDate,
    this.builder,
  });
}
