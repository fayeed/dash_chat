part of dash_chat;

/// A message data structure used by dash chat to handle messages
/// and also to handle quick replies
class ChatMessage {
  /// Id of the message if no id is supplied a new id is assigned
  /// using a [UUID v4] this behaviour could be overriden by provind
  /// and [optional] paramter called [messageIdGenerator].
  /// [messageIdGenerator] take a function with this
  /// signature [String Function()]
  String id;

  /// Actual text message.
  String text;

  /// It's a [non-optional] pararmter which specifies the time the
  /// message was delivered takes a [DateTime] object.
  DateTime createdAt;

  /// Takes a [ChatUser] object which is used to distinguish between
  /// users and also provide avaatar URLs and name.
  ChatUser user;

  /// A [non-optional] parameter which is used to display images
  /// takes a [Sring] as a url
  String image;

  /// A [non-optional] parameter which is used to display vedio
  /// takes a [Sring] as a url
  String vedio;

  /// A [non-optional] parameter which is used to show quick replies
  /// to the user
  QuickReplies quickReplies;

  ChatMessage({
    String id,
    @required this.text,
    @required this.user,
    this.image,
    this.vedio,
    this.quickReplies,
    String Function() messageIdGenerator,
    DateTime createdAt,
  }) {
    this.createdAt = createdAt != null ? createdAt : DateTime.now();
    this.id = id != null
        ? id
        : messageIdGenerator != null
            ? messageIdGenerator()
            : Uuid().v4().toString();
  }
}
