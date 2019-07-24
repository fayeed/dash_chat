part of dash_chat;

class ChatUser {
  String uid;
  String name;
  String avatar;

  ChatUser({String uid, this.name, this.avatar}) {
    this.uid = uid != null ? uid : Uuid().v4().toString();
  }
}
