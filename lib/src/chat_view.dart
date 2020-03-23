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

  /// If provided, this text editing controller will be used for
  /// the text input.
  final TextEditingController textController;

  /// If provided, this focus node will be used for the text input.
  final FocusNode focusNode;

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

  ///Configures how the platform keyboard will select an uppercase or lowercase keyboard.
  ///Only supports text keyboards, other keyboard types will ignore this configuration. Capitalization is locale-aware.
  ///Defaults to [TextCapitalization.none]. Must not be null.
  final TextCapitalization textCapitalization;

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

  /// Should the scroll to bottom widget be shown
  /// default to true.
  final bool scrollToBottom;

  /// Overrides the default [scrollToBottomWidget] with a custom widget
  final Widget Function() scrollToBottomWidget;

  /// Override the default behaviour of the onScrollToBottom Widget
  final Function onScrollToBottomPress;

  /// Should the LoadEarlier Floating widget be shown or use
  /// load as you scroll scheme whcih will call the [onLoadEarlier]
  /// function as default it is set to this scheme which is false.
  /// false - load as you scroll scheme
  /// true - shows a loadEarlier Widget
  final bool shouldShowLoadEarlier;

  /// Override the default behaviour of the onScrollToBottom Widget
  final Widget Function() showLoadEarlierWidget;

  /// Override the default behaviour of the onLoadEarleir Widget
  /// or used as a callback when the listView reaches the top
  final Function onLoadEarlier;

  /// Padding for the default input toolbar
  /// by default it padding is set 0.0
  final EdgeInsets inputToolbarPadding;

  /// Margin for the default input toolbar
  /// by default it padding is set 0.0
  final EdgeInsets inputToolbarMargin;

  DashChat({
    Key key,
    this.inputToolbarMargin = const EdgeInsets.all(0.0),
    this.inputToolbarPadding = const EdgeInsets.all(0.0),
    this.shouldShowLoadEarlier = false,
    this.showLoadEarlierWidget,
    this.onLoadEarlier,
    this.scrollToBottom = true,
    this.scrollToBottomWidget,
    this.onScrollToBottomPress,
    this.onQuickReply,
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.quickReplyBuilder,
    this.messageContainerPadding = const EdgeInsets.only(
      left: 2.0,
      right: 2.0,
    ),
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
    this.textController,
    this.focusNode,
    this.inputDecoration,
    this.textCapitalization = TextCapitalization.none,
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
  FocusNode inputFocusNode;
  TextEditingController textController;
  ScrollController scrollController;
  String _text = "";
  bool visible = false;
  OverlayEntry _overlayEntry;
  GlobalKey inputKey = GlobalKey();
  double height = 48.0;
  bool showLoadMore = false;

  String get messageInput => _text;

  void onTextChange(String text) {
    if (visible) {
      changeVisible(false);
    }
    setState(() {
      this._text = text;
    });
  }

  void changeVisible(bool value) {
    if (widget.scrollToBottom) {
      if (value != visible) {
        setState(() {
          visible = value;
        });
      }

      if (this._overlayEntry == null) {
        // height = inputKey.currentContext.size.height;
        this._overlayEntry = this._createOverlayEntry(height);

        if (value) {
          Timer(Duration(milliseconds: 120), () {
            try {
              Overlay.of(context).insert(this._overlayEntry);
            } catch (e) {}
          });
        }
      } else {
        try {
          if (!value) {
            this._overlayEntry.remove();
            this._overlayEntry = null;
          }
        } catch (e) {
          this._overlayEntry = null;
        }
      }
    }
  }

  void changeDefaultLoadMore(bool value) {
    setState(() {
      showLoadMore = value;
    });
  }

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    textController = widget.textController ?? TextEditingController();
    inputFocusNode = widget.focusNode ?? FocusNode();

    Timer(Duration(milliseconds: 500), () {
      double initPos = widget.inverted ? 0.0 : scrollController.position.maxScrollExtent;
      scrollController.jumpTo(initPos);

      scrollController.addListener(() {
        if (widget.shouldShowLoadEarlier) {
          if (scrollController.offset <=
                  scrollController.position.minScrollExtent &&
              !scrollController.position.outOfRange) {
            setState(() {
              showLoadMore = true;
            });
          } else {
            setState(() {
              showLoadMore = false;
            });
          }
        } else {
          if (scrollController.offset <=
                  scrollController.position.minScrollExtent &&
              !scrollController.position.outOfRange) {
            widget.onLoadEarlier();
          }
        }
      });
    });

    super.initState();
  }

  OverlayEntry _createOverlayEntry(double height) {
    return OverlayEntry(
      builder: (context) => Positioned(
        bottom: height + 12.0,
        right: 10.0,
        child: widget.scrollToBottomWidget != null
            ? widget.scrollToBottomWidget()
            : ScrollToBottom(
                onScrollToBottomPress: widget.onScrollToBottomPress,
                scrollController: scrollController,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
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
              shouldShowLoadEarlier: widget.shouldShowLoadEarlier,
              showLoadEarlierWidget: widget.showLoadEarlierWidget,
              onLoadEarlier: widget.onLoadEarlier,
              defaultLoadCallback: changeDefaultLoadMore,
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
              changeVisible: changeVisible,
              visible: visible,
              showLoadMore: showLoadMore,
            ),
            if (widget.messages.length != 0 &&
                widget.messages[widget.messages.length - 1].user.uid !=
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
                          .sublist(
                              0,
                              widget.messages[widget.messages.length - 1]
                                          .quickReplies.values.length <=
                                      3
                                  ? widget.messages[widget.messages.length - 1]
                                      .quickReplies.values.length
                                  : 3)
                          .map(
                            (reply) => QuickReply(
                              reply: reply,
                              onReply: widget.onQuickReply,
                              quickReplyBuilder: widget.quickReplyBuilder,
                              quickReplyStyle: widget.quickReplyStyle,
                              quickReplyTextStyle: widget.quickReplyTextStyle,
                            ),
                          )
                          .toList(),
                  ],
                ),
              ),
            if (widget.chatFooterBuilder != null) widget.chatFooterBuilder(),
            ChatInputToolbar(
              key: inputKey,
              inputToolbarPadding: widget.inputToolbarPadding,
              inputToolbarMargin: widget.inputToolbarMargin,
              showTraillingBeforeSend: widget.showTraillingBeforeSend,
              inputMaxLines: widget.inputMaxLines,
              controller: textController,
              inputDecoration: widget.inputDecoration,
              textCapitalization: widget.textCapitalization,
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
              focusNode: inputFocusNode,
            )
          ],
        ),
      ),
    );
  }
}
