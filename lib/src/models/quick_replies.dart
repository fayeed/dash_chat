part of dash_chat;

/// Quick replies will contain all the replies that should
/// be shown to the user
class QuickReplies {
  /// [List] of replies that will be shown to the user
  List<Reply> values;

  /// Should the quick replies be dismissable or persist
  bool keepIt;

  QuickReplies({
    this.keepIt,
    this.values = const <Reply>[],
  });
}
