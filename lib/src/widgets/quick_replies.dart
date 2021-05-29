part of dash_chat;

class QuickRepliesWidget extends StatelessWidget {
  final QuickReplyOptions quickReplyOptions;
  final List<ChatMessage> messages;
  final double maxWidth;

  const QuickRepliesWidget({
    Key? key,
    required this.quickReplyOptions,
    required this.messages,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: quickReplyOptions.quickReplyPadding,
      constraints: BoxConstraints(
          maxHeight: quickReplyOptions.quickReplyScroll ? 50.0 : 100.0),
      width: quickReplyOptions.quickReplyScroll ? null : maxWidth,
      child: quickReplyOptions.quickReplyScroll
          ? ListView(
              scrollDirection: Axis.horizontal,
              children:
                  messages.last.quickReplies!.values!.map(_mapReply).toList(),
            )
          : Wrap(
              children: <Widget>[
                ...messages.last.quickReplies!.values!
                    .sublist(
                        0,
                        messages.last.quickReplies!.values!.length <= 3
                            ? messages.last.quickReplies!.values!.length
                            : 3)
                    .map(_mapReply)
                    .toList(),
              ],
            ),
    );
  }

  QuickReply _mapReply(Reply reply) => QuickReply(
        reply: reply,
        onReply: quickReplyOptions.onQuickReply,
        quickReplyBuilder: quickReplyOptions.quickReplyBuilder,
        quickReplyStyle: quickReplyOptions.quickReplyStyle,
        quickReplyTextStyle: quickReplyOptions.quickReplyTextStyle,
      );
}
