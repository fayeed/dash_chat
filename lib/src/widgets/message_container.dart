part of dash_chat;

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    @required this.message,
    @required this.timeFormat,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.messageContainerDecoration,
    this.parsePatterns = const [],
  });

  final ChatMessage message;
  final DateFormat timeFormat;
  final Widget Function(String) messageTextBuilder;
  final Widget Function(String url) messageImageBuilder;
  final Widget Function(String) messageTimeBuilder;
  final BoxDecoration messageContainerDecoration;
  final List<MatchText> parsePatterns;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 220.0,
      ),
      child: Container(
        decoration: messageContainerDecoration != null
            ? messageContainerDecoration
            : BoxDecoration(
                color: Colors.blue,
              ),
        margin: EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            if (messageTextBuilder != null)
              messageTextBuilder(message.text)
            else
              ParsedText(
                parse: parsePatterns,
                text: message.text,
                style: TextStyle(color: Colors.white),
              ),
            if (message.image != null)
              if (messageImageBuilder != null)
                messageImageBuilder(message.image)
              else
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Image.network(
                    message.image,
                  ),
                ),
            if (messageTimeBuilder != null)
              messageTimeBuilder(
                timeFormat != null
                    ? timeFormat.format(message.createdAt)
                    : DateFormat('HH:mm:ss').format(message.createdAt),
              )
            else
              Text(
                timeFormat != null
                    ? timeFormat.format(message.createdAt)
                    : DateFormat('HH:mm:ss').format(message.createdAt),
                style: TextStyle(fontSize: 8.0, color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
