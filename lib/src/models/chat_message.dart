part of dash_chat;

class ChatMessage {
  String id;
  String text;
  DateTime createdAt;
  ChatUser user;
  String image;
  String vedio;
  QuickReplies quickReplies;

  ChatMessage(
      {@required this.text,
      @required this.user,
      this.image,
      this.vedio,
      this.quickReplies,
      String Function() messageIdGenerator,
      DateTime createdAt}) {
    this.createdAt = createdAt != null ? createdAt : DateTime.now();
    this.id = messageIdGenerator != null
        ? messageIdGenerator()
        : Uuid().v4().toString();
  }
}
