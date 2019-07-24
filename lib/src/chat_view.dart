part of dash_chat;

class DashChat extends StatefulWidget {
  final Key key;

  // flex value for the messeage container defaults to 1
  final int messageContainerFlex;

  // height of the whole chat view
  final double height;

  // width of the chat view
  final double width;

  // list of messages to display in the chat container
  final List<ChatMessage> messages;

  // if provided will stop using the controller
  final String text;

  // will need to provide this if text is not provided
  final Function(String) onTextChange;

  // placeholder for the chat message defaults "Add Message here..."
  final InputDecoration inputDecoration;

  // generates id for the message defaults to uuid
  final String Function() messageIdGenerator;

  // user chat object
  final ChatUser user;

  // to add message to the list and make calls
  final Function(ChatMessage) onSend;

  // either to disabel send button if nothing is provided / false
  final bool alwaysShowSend;

  final Locale locale;

  final DateFormat dateFormat;

  final DateFormat timeFormat;

  final bool showUserAvatar;
  final Widget Function(ChatUser) avatarBuilder;
  final bool showAvatarForEveryMessage;
  final Function(ChatUser) onPressAvatar;
  final Function(ChatUser) onLongPressAvatar;
  final bool renderAvatarOnTop;
  final Function(ChatMessage) onLongPressMessage;
  final bool inverted;
  final Widget Function(ChatMessage) messageBuilder;
  final Widget Function(String) messageTextBuilder;
  final Widget Function(String url) messageImageBuilder;
  final Widget Function(String url) messageTimeBuilder;
  final Widget Function(String) dateBuilder;
  final Widget Function() chatFooterBuilder;
  final int maxInputLength;
  final List<MatchText> parsePatterns;
  final BoxDecoration messageContainerDecoration;
  final List<Widget> leading;
  final List<Widget> trailing;
  final Widget Function(Function) sendButtonBuilder;
  final TextStyle inputTextStyle;
  final BoxDecoration inputContainerStyle;
  final int inputMaxLines;
  final bool showInputCursor;
  final double inputCursorWidth;
  final Color inputCursorColor;
  final ScrollController scrollController;
  final Widget Function() inputFooterBuilder;
  final EdgeInsetsGeometry messageContainerPadding;

  // TODO: Implement features
  final double bottomOffset;
  final double minToolBarHeight;
  final bool scrollToBottom;
  final Widget Function() scrollToBottomWidget;
  final double scrollToBottomOffset;
  final Function(String) onQuickReply;
  final Widget Function(QuickReplies) renderQuickReplies;
  final BoxDecoration quickReplyStyle;
  final TextStyle quickReplyTextStyle;

  DashChat({
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
    this.scrollController,
    this.inputCursorColor,
    this.inputCursorWidth = 2.0,
    this.showInputCursor,
    this.inputMaxLines = 1,
    this.inputContainerStyle,
    this.inputTextStyle,
    this.key,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.messageContainerDecoration,
    this.messageContainerFlex = 1,
    this.height,
    this.width,
    @required this.messages,
    this.onTextChange,
    this.text,
    this.inputDecoration,
    this.alwaysShowSend = false,
    this.messageIdGenerator,
    this.dateFormat,
    this.timeFormat,
    @required this.user,
    this.onSend,
    this.locale,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.renderAvatarOnTop = false,
    this.avatarBuilder,
    this.showAvatarForEveryMessage = false,
    this.showUserAvatar = false,
    this.bottomOffset = 0.0,
    this.inverted = false,
    this.maxInputLength,
    this.minToolBarHeight = 44.0,
    this.onQuickReply,
    this.parsePatterns = const <MatchText>[],
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.chatFooterBuilder,
    this.messageBuilder,
    this.inputFooterBuilder,
    this.renderQuickReplies,
    this.sendButtonBuilder,
    this.scrollToBottom = false,
    this.scrollToBottomOffset,
    this.scrollToBottomWidget,
    this.dateBuilder,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
  });

  String getVal() {
    return text;
  }

  @override
  DashChatState createState() => DashChatState();
}

class DashChatState extends State<DashChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String _text = "";

  String get messageInput => _text;

  void onTextChange(String text) {
    setState(() {
      this._text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height != null
          ? widget.height
          : MediaQuery.of(context).size.height,
      width: widget.width != null
          ? widget.width
          : MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          MessageListView(
            messageContainerPadding: widget.messageContainerPadding,
            scrollController: widget.scrollController != null
                ? widget.scrollController
                : scrollController,
            user: widget.user,
            messages: widget.messages,
            showuserAvatar: widget.showUserAvatar,
            dateFormat: widget.dateFormat,
            timeFormat: widget.timeFormat,
            inverted: widget.inverted,
            showAvatarForEverMessage: widget.showAvatarForEveryMessage,
            onLongPressAvatar: widget.onLongPressAvatar,
            onPressAvatar: widget.onPressAvatar,
            onLongPressMessage: widget.onLongPressMessage,
            avatarBuilder: widget.avatarBuilder,
            messageBuilder: widget.messageBuilder,
            messageTextBuilder: widget.messageTextBuilder,
            messageImageBuilder: widget.messageImageBuilder,
            messageTimeBuilder: widget.messageTimeBuilder,
            dateBuilder: widget.dateBuilder,
            messageContainerDecoration: widget.messageContainerDecoration,
            parsePatterns: widget.parsePatterns,
          ),
          if (widget.chatFooterBuilder != null) widget.chatFooterBuilder(),
          ChatInputToolbar(
            inputMaxLines: widget.inputMaxLines,
            controller: _controller,
            inputDecoration: widget.inputDecoration,
            onSend: widget.onSend,
            user: widget.user,
            messageIdGenerator: widget.messageIdGenerator,
            maxInputLength: widget.maxInputLength,
            sendButtonBuilder: widget.sendButtonBuilder,
            minToolBarHeight: widget.minToolBarHeight,
            bottomOffset: widget.bottomOffset,
            text: widget.text != null ? widget.text : _text,
            onTextChange: widget.onTextChange != null
                ? widget.onTextChange
                : onTextChange,
            leading: widget.leading,
            trailling: widget.trailing,
            inputContainerStyle: widget.inputContainerStyle,
            inputTextStyle: widget.inputTextStyle,
            inputFooterBuilder: widget.inputFooterBuilder,
            inputCursorColor: widget.inputCursorColor,
            inputCursorWidth: widget.inputCursorWidth,
            showInputCursor: widget.showInputCursor,
            alwaysShowSend: widget.alwaysShowSend,
            scrollController: widget.scrollController != null
                ? widget.scrollController
                : scrollController,
          )
        ],
      ),
    );
  }
}
