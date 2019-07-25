part of dash_chat;

/// ChatUser used to show distinguish between different people
/// in a chat conversation or a chat group
class ChatUser {
  /// Unique id of the user if no unique is provided a [UUID v4]
  /// is automatically assigned to the chat user.
  String uid;

  /// A [optional] parameter to set the user name.
  String name;

  /// A [optional] parameter to set the user avatar.
  String avatar;

  ChatUser({
    String uid,
    this.name,
    this.avatar,
  }) {
    this.uid = uid != null ? uid : Uuid().v4().toString();
  }
}
