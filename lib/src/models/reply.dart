part of dash_chat;

/// Used for providing replies in quick replies
class Reply {
  /// Message shown to the user
  String title;

  /// Actual value underneath the message
  /// It's an [optioanl] paramter
  String value;

  /// If no messageId is provided it will use [UUID v4] to
  /// set a default id for that message
  dynamic messageId;

  Reply({
    this.title,
    String messageId,
    this.value,
  }) {
    this.messageId = messageId != null ? messageId : Uuid().v4().toString();
  }
}
