part of dash_chat;

/// ChatUser used to show distinguish between different people
/// in a chat conversation or a chat group
class ChatUser {
  /// Unique id of the user if no unique is provided a [UUID v4]
  /// is automatically assigned to the chat user.
  String uid;

  /// An [optional] parameter to set the user name.
  String name;

  /// An [optional] parameter to set the user avatar.
  String avatar;

  /// An [optional] parameter to set Text Color
  Color color;

  /// An [optional] parameter to set The Message bubble Color
  Color containerColor;

  ChatUser({
    String uid,
    this.name,
    this.avatar,
    this.containerColor,
    this.color,
  }) {
    this.uid = uid != null ? uid : Uuid().v4().toString();
  }

  ChatUser.fromJson(Map<dynamic, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    avatar = json['avatar'];
    containerColor = json['containerColor'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['uid'] = uid;
    data['name'] = name;
    data['avatar'] = avatar;
    data['containerColor'] = containerColor;
    data['color'] = color;

    return data;
  }
}
