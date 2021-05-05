part of dash_chat;

enum MessageStatus {
  none,
  read,
  received,
  pending,
}

/// A message data structure used by dash chat to handle messages
/// and also to handle quick replies
///
/// You can extend this class to add custom properties.
class ChatMessage {
  /// Id of the message if no id is supplied a new id is assigned
  /// using a [UUID v4] this behaviour could be overriden by provind
  /// and [optional] paramter called [messageIdGenerator].
  /// [messageIdGenerator] take a function with this
  /// signature [String Function()]
  String? id;

  /// Actual text message.
  String? text;

  /// It's a [non-optional] pararmter which specifies the time the
  /// message was delivered takes a [DateTime] object.
  late DateTime createdAt;

  /// Takes a [ChatUser] object which is used to distinguish between
  /// users and also provide avaatar URLs and name.
  late ChatUser user;

  /// A [non-optional] parameter which is used to display images
  /// takes a [ChatMedia] as a url
  List<ChatMedia>? media;

  MessageStatus? status;

  /// A [non-optional] parameter which is used to show quick replies
  /// to the user
  QuickReplies? quickReplies;

  /// Allows to set buttons that could help with implementing custom
  /// actions in message container.
  List<Widget>? buttons;

  bool? isSystem;

  ChatMessage({
    String? id,
    required this.text,
    required this.user,
    this.media,
    this.quickReplies,
    status = MessageStatus.none,
    String Function()? messageIdGenerator,
    DateTime? createdAt,
    this.buttons,
    this.isSystem = false,
  }) {
    this.createdAt = createdAt != null ? createdAt : DateTime.now();
    this.id = id ?? messageIdGenerator?.call() ?? Uuid().v4().toString();
  }

  ChatMessage.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    text = json['text'];
    media = json['media'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(json['createdAt']);
    user = ChatUser.fromJson(json['user']);
    quickReplies = json['quickReplies'] != null
        ? QuickReplies.fromJson(json['quickReplies'])
        : null;
    isSystem = json['isSystem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    try {
      data['id'] = this.id;
      data['text'] = this.text;
      data['media'] = this.media;
      data['createdAt'] = this.createdAt.millisecondsSinceEpoch;
      data['user'] = user.toJson();
      data['quickReplies'] = quickReplies?.toJson();
      data['isSystem'] = this.isSystem;
    } catch (e, stack) {
      print('ERROR caught when trying to convert ChatMessage to JSON:');
      print(e);
      print(stack);
    }
    return data;
  }
}
