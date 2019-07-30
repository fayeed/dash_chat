part of dash_chat;

/// A complete chat UI which is inspired by [react-native-gifted-chat]
/// Highly customizable and helps developing chat UI faster
class DashChat extends StatefulWidget {
  /// Flex value for the messeage container defaults to 1
  /// Made so that the message container takes as much as possible
  /// if no height or width is passed explicity
  final int messageContainerFlex;

  /// Height for the Dash chat Widget
  final double height;

  // Width for the Dash chat Widget
  final double width;

  /// List of messages to display in the chat container
  /// Takes a [List] of [ChatMessage]
  final List<ChatMessage> messages;

  /// If provided will stop using the default controller
  /// i.e [TextEditingController] and will use this to update the
  /// text input field.
  final String text;

  /// If the text parameter is passed then onTextChange must also
  /// be passed.
  final Function(String) onTextChange;

  /// Used to provide input decoration to the text as default only
  /// to the input placeholder for the chat input
  /// "Add Message here...".
  final InputDecoration inputDecoration;

  /// Usually new message added by the user gets [Uuid] String
  /// Can be override by proving this parameter
  final String Function() messageIdGenerator;

  /// The current user object [ChatUser].
  final ChatUser user;

  /// To function where you can make api calls and play
  /// with the [ChatMessage] obeject before make calls.
  final Function(ChatMessage) onSend;

  /// Should the send button be always active it defaults to false
  /// Usually it will only become active if some text is entered.
  final bool alwaysShowSend;

  /// [DateFormat] object for formatting date to show in [MessageListView]
  /// defaults to `HH:mm:ss`.
  final DateFormat dateFormat;

  /// [DateFormat] object for formatting time to show in [MessageContainer]
  /// defaults to `yyyy-MM-dd`.
  final DateFormat timeFormat;

  /// Should the user avatar be shown defaults to false and will not
  /// show the user avatar.
  final bool showUserAvatar;

  /// avatarBuilder will override the the default avatar which uses
  /// [CircleAvatar].
  final Widget Function(ChatUser) avatarBuilder;

  /// Should the avatar be shown for every message defaulst to false.
  final bool showAvatarForEveryMessage;

  /// [onPressAvatar] function takes a function with this structure
  /// [Function(ChatUser)] will trigger when the avatar
  /// is tapped on
  final Function(ChatUser) onPressAvatar;

  /// [onLongPressAvatar] function takea a function with this structure
  /// [Function(ChatUser)] will trigger when the avatar
  /// is long pressed
  final Function(ChatUser) onLongPressAvatar;

  /// [onLongPressMessage] function takea a function with this structure
  /// [Function(ChatMessage)] will trigger when the message
  /// is long pressed.
  final Function(ChatMessage) onLongPressMessage;

  /// Should the messages be shown in reversed order.
  final bool inverted;

  /// messageBuilder will override the the default chat container which uses
  /// and you will need to build complete message Widget it will not accept
  /// and include any other builder functions.
  final Widget Function(ChatMessage) messageBuilder;

  /// messageTextBuilder will override the the default message text.
  final Widget Function(String) messageTextBuilder;

  /// messageImageBuilder will override the the default Image.
  final Widget Function(String url) messageImageBuilder;

  /// messageTimeBuilder will override the the default text.
  final Widget Function(String url) messageTimeBuilder;

  /// dateBuilder will override the the default time text.
  final Widget Function(String) dateBuilder;

  /// A Widget that will be shown below the [MessageListView] like you can
  /// show a "tying..." at the end.
  final Widget Function() chatFooterBuilder;

  /// Main input length of the input text box defaulst to no limit.
  final int maxInputLength;

  /// Used to parse text to make it linkified text uses
  /// [flutter_parsed_text](https://pub.dev/packages/flutter_parsed_text)
  /// takes a list of [MatchText] in order to parse Email, phone, links
  /// and can also add custom pattersn using regex
  final List<MatchText> parsePatterns;

  /// Provides a custom style to the message container
  /// takes [BoxDecoration]
  final BoxDecoration messageContainerDecoration;

  /// [List] of [Widget] to show before the [TextField].
  final List<Widget> leading;

  /// [List] of [Widget] to show after the [TextField].will remove the
  /// send button and will have to implement that yourself.
  final List<Widget> trailing;

  /// sendButtonBuilder will override the the default [IconButton].
  final Widget Function(Function) sendButtonBuilder;

  /// Style for the [TextField].
  final TextStyle inputTextStyle;

  /// [TextField] container style.
  final BoxDecoration inputContainerStyle;

  /// Max length of the input lines default to 1.
  final int inputMaxLines;

  /// Should the input cursor be shown defaults to true.
  final bool showInputCursor;

  /// Width of the text input defaults to 2.0.
  final double inputCursorWidth;

  /// Color of the input cursor defaults to theme.
  final Color inputCursorColor;

  /// ScrollController for the [MessageListView] will use the default
  /// scrollcontroller in the Widget.
  final ScrollController scrollController;

  /// A Widget that will be shown below the [ChatInputToolbar] like you can
  /// show a list of buttons like file image just like in Slack app.
  final Widget Function() inputFooterBuilder;

  /// Padding for the [MessageListView].
  final EdgeInsetsGeometry messageContainerPadding;

  /// Callback method when the quickReply was tapped on
  /// will pass [Reply] as a paramter to function.
  final Function(Reply) onQuickReply;

  /// Container style for the QuickReply Container [BoxDecoration].
  final BoxDecoration quickReplyStyle;

  /// [TextStyle] for QuickReply textstyle.
  final TextStyle quickReplyTextStyle;

  /// quickReplyBuilder will override the the default QuickReply Widget.
  final Widget Function(Reply) quickReplyBuilder;

  /// Should the [trailling] Widgets be shown before the send button
  /// As default it will be shown before the send button.
  final bool showTraillingBeforeSend;

  DashChat({
    Key key,
    this.onQuickReply,
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.quickReplyBuilder,
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, left: 2.0, right: 2.0),
    this.scrollController,
    this.inputCursorColor,
    this.inputCursorWidth = 2.0,
    this.showInputCursor = true,
    this.inputMaxLines = 1,
    this.inputContainerStyle,
    this.inputTextStyle,
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
    @required this.onSend,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.avatarBuilder,
    this.showAvatarForEveryMessage = false,
    this.showUserAvatar = false,
    this.inverted = false,
    this.maxInputLength,
    this.parsePatterns = const <MatchText>[],
    this.chatFooterBuilder,
    this.messageBuilder,
    this.inputFooterBuilder,
    this.sendButtonBuilder,
    this.dateBuilder,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.showTraillingBeforeSend = true,
  }) : super(key: key);

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
  void initState() {
    Timer(Duration(milliseconds: 500), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: widget.height != null
              ? widget.height
              : MediaQuery.of(context).size.height - 80.0,
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
              if (widget.messages[widget.messages.length - 1].user.uid !=
                  widget.user.uid)
                Container(
                    constraints: BoxConstraints(maxHeight: 100.0),
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: <Widget>[
                        if (widget.messages[widget.messages.length - 1]
                                .quickReplies !=
                            null)
                          ...widget.messages[widget.messages.length - 1]
                              .quickReplies.values
                              .sublist(0, 3)
                              .map(
                                (reply) => QuickReply(
                                  reply: reply,
                                  onReply: widget.onQuickReply,
                                  quickReplyBuilder: widget.quickReplyBuilder,
                                  quickReplyStyle: widget.quickReplyStyle,
                                  quickReplyTextStyle:
                                      widget.quickReplyTextStyle,
                                ),
                              )
                              .toList(),
                      ],
                    )),
              if (widget.chatFooterBuilder != null) widget.chatFooterBuilder(),
              ChatInputToolbar(
                showTraillingBeforeSend: widget.showTraillingBeforeSend,
                inputMaxLines: widget.inputMaxLines,
                controller: _controller,
                inputDecoration: widget.inputDecoration,
                onSend: widget.onSend,
                user: widget.user,
                messageIdGenerator: widget.messageIdGenerator,
                maxInputLength: widget.maxInputLength,
                sendButtonBuilder: widget.sendButtonBuilder,
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
        ),
      ),
    );
  }
}
