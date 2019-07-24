part of dash_chat;

class QuickReplies {
  List<Reply> values;
  bool keepIt;

  QuickReplies({this.keepIt, this.values = const <Reply>[]});
}
