part of dash_chat;

class QuickReply extends StatelessWidget {
  final Reply reply;

  final Function(Reply) onReply;

  final BoxDecoration quickReplyStyle;

  final TextStyle quickReplyTextStyle;

  final Widget Function(Reply) quickReplyBuilder;

  const QuickReply({
    this.quickReplyBuilder,
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.onReply,
    this.reply,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onReply(reply);
      },
      child: quickReplyBuilder != null
          ? quickReplyBuilder(reply)
          : Container(
              margin: EdgeInsets.only(
                  left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: quickReplyStyle != null
                  ? quickReplyStyle
                  : BoxDecoration(
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 3),
              child: Text(
                reply.title,
                style: quickReplyTextStyle != null
                    ? quickReplyTextStyle
                    : TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 12.0,
                      ),
              ),
            ),
    );
  }
}
