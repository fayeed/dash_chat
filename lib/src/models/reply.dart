part of dash_chat;

/// Used for providing replies in quick replies
class Reply {
  /// Message shown to the user
  late String title;

  /// Actual value underneath the message
  /// It's an [optioanl] paramter
  String? value;

  /// If no messageId is provided it will use [UUID v4] to
  /// set a default id for that message
  dynamic messageId;

  Reply({
    required this.title,
    String? messageId,
    this.value,
  }) {
    this.messageId = messageId ?? Uuid().v4().toString();
  }

  Reply.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    value = json['value'];
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['messageId'] = messageId;
    data['title'] = title;
    data['value'] = value;

    return data;
  }
}
