part of dash_chat;

/// ChatUser used to show distinguish between different people
/// in a chat conversation or a chat group
class ChatUser {
  /// Unique id of the user if no unique is provided a [UUID v4]
  /// is automatically assigned to the chat user.
  String? uid;

  /// An [optional] parameter to set the user name.
  String? name;

  /// An [optional] parameter to set the user first name, if set will override the name property.
  String? firstName;

  /// An [optional] parameter to set the user last name, if set will override the name property.
  String? lastName;

  /// An [optional] parameter to set the user avatar.
  String? avatar;

  /// An [optional] parameter to set Text Color
  Color? color;

  /// An [optional] parameter to set The Message bubble Color
  Color? containerColor;

  /// Allows to set custom-properties that could help with implementing custom
  /// functionality to dashchat.
  Map<String, dynamic>? customProperties;

  ChatUser({
    String? uid,
    String? name,
    this.avatar,
    this.containerColor,
    this.color,
    this.customProperties,
    this.firstName,
    this.lastName,
  }) {
    this.name = name == null ? "$firstName $lastName" : name;
    this.uid = uid != null ? uid : Uuid().v4().toString();
  }

  ChatUser.fromJson(Map<dynamic, dynamic> json) {
    final pName = json["name"] as String?;

    uid = json['uid'];
    name = pName == null ? "$firstName $lastName" : pName;
    firstName = json['firstName'];
    lastName = json['lastName'];
    avatar = json['avatar'];
    containerColor =
        json['containerColor'] != null ? Color(json['containerColor']) : null;
    color = json['color'] != null ? Color(json['color']) : null;
    customProperties = json['customProperties'] as Map<String, dynamic>?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    try {
      data['uid'] = uid;
      data['name'] = name;
      data['firstName'] = firstName;
      data['lastName'] = lastName;
      data['avatar'] = avatar;
      data['containerColor'] =
          containerColor != null ? containerColor!.value : null;
      data['color'] = color != null ? color!.value : null;
      data['customProperties'] = this.customProperties;
    } catch (e) {
      print(e);
    }

    return data;
  }
}
