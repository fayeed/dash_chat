part of dash_chat;

/// MessageContainer is just a wrapper around [Text], [Image]
/// component to present the message
class MessageContainer extends StatelessWidget {
  /// Message Object that will be rendered
  /// Takes a [ChatMessage] object
  final ChatMessage message;

  /// [DateFormat] object to render the date in desired
  /// format, if no format is provided it use
  /// the default `HH:mm:ss`
  final DateFormat timeFormat;

  /// [messageTextBuilder] function takes a function with this
  /// structure [Widget Function(String)] to render the text inside
  /// the container.
  final Widget Function(String) messageTextBuilder;

  /// [messageImageBuilder] function takes a function with this
  /// structure [Widget Function(String)] to render the image inside
  /// the container.
  final Widget Function(String) messageImageBuilder;

  /// [messageTimeBuilder] function takes a function with this
  /// structure [Widget Function(String)] to render the time text inside
  /// the container.
  final Widget Function(String) messageTimeBuilder;

  /// Provides a custom style to the message container
  /// takes [BoxDecoration]
  final BoxDecoration messageContainerDecoration;

  /// Used to parse text to make it linkified text uses
  /// [flutter_parsed_text](https://pub.dev/packages/flutter_parsed_text)
  /// takes a list of [MatchText] in order to parse Email, phone, links
  /// and can also add custom pattersn using regex
  final List<MatchText> parsePatterns;

  /// A flag which is used for assiging styles
  final bool isUser;

  const MessageContainer(
      {@required this.message,
      @required this.timeFormat,
      this.messageImageBuilder,
      this.messageTextBuilder,
      this.messageTimeBuilder,
      this.messageContainerDecoration,
      this.parsePatterns = const <MatchText>[],
      this.isUser});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 220.0,
      ),
      child: Container(
        decoration: messageContainerDecoration != null
            ? messageContainerDecoration.copyWith(
                color: message.user.containerColor != null
                    ? message.user.containerColor
                    : messageContainerDecoration.color,
              )
            : BoxDecoration(
                color: message.user.containerColor != null
                    ? message.user.containerColor
                    : isUser ? Theme.of(context).accentColor : Colors.white70,
                borderRadius: BorderRadius.circular(5.0),
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
                style: TextStyle(
                    color: message.user.color != null
                        ? message.user.color
                        : isUser ? Colors.white70 : Colors.black87),
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
