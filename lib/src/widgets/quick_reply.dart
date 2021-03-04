part of dash_chat;

class QuickReply extends StatelessWidget {
  final Reply reply;

  final Function(Reply)? onReply;

  final BoxDecoration? quickReplyStyle;

  final TextStyle? quickReplyTextStyle;

  final Widget Function(Reply)? quickReplyBuilder;

  final BoxConstraints? constraints;

  const QuickReply({
    this.quickReplyBuilder,
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.constraints,
    this.onReply,
    required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);
    return GestureDetector(
      onTap: () {
        onReply?.call(reply);
      },
      child: quickReplyBuilder?.call(reply) ??
          Container(
            margin:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 5.0, bottom: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            decoration: quickReplyStyle ??
                BoxDecoration(
                  border: Border.all(
                      width: 1.0, color: Theme.of(context).accentColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
            constraints: BoxConstraints(maxWidth: constraints.maxWidth / 3),
            child: Text(
              reply.title,
              style: quickReplyTextStyle ??
                  TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 12.0,
                  ),
            ),
          ),
    );
  }
}
