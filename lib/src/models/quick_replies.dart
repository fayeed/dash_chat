part of dash_chat;

/// Quick replies will contain all the replies that should
/// be shown to the user
class QuickReplies {
  /// [List] of replies that will be shown to the user
  List<Reply>? values;

  /// Should the quick replies be dismissable or persist
  bool? keepIt;

  QuickReplies({
    this.keepIt,
    this.values = const <Reply>[],
  });

  QuickReplies.fromJson(Map<dynamic, dynamic> json) {
    keepIt = json['keepIt'];

    if (json['values'] != null) {
      List<Reply> replies = <Reply>[];

      for (var i = 0; i < json['values'].length; i++) {
        replies.add(Reply.fromJson(json['values'][i]));
      }

      values = replies;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['keepIt'] = keepIt;
    data['values'] = values!.map((e) => e.toJson()).toList();

    return data;
  }
}
