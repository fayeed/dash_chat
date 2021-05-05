part of dash_chat;

/// A complete chat UI which is inspired by [react-native-gifted-chat]
/// Highly customizable and helps developing chat UI faster
class DashChat extends StatefulWidget {
  /// Set the chat into read only mode, meaning no way to send messages
  /// default to false
  final bool readOnly;

  /// Height for the Dash chat Widget
  final double? height;

  // Width for the Dash chat Widget
  final double? width;

  /// List of messages to display in the chat container
  /// Takes a [List] of [ChatMessage]
  final List<ChatMessage> messages;

  /// If provided will stop using the default controller
  /// i.e [TextEditingController] and will use this to update the
  /// text input field.
  final String? text;

  final Function(ChatMessage) onSend;

  /// Usually new message added by the user gets [Uuid] String
  /// Can be override by proving this parameter
  final String Function()? messageIdGenerator;

  /// The current user object [ChatUser].
  final ChatUser user;

  late final ScrollToBottomStyle scrollToBottomStyle;

  late final InputOptions inputOptions;

  late final MessageOptions messageOptions;

  late final MessageListOptions messageListOptions;

  late final QuickReplyOptions quickReplyOptions;

  late final ScrollToBottomOptions scrollToBottomOptions;

  late final DashchatStyle style;

  DashChat({
    Key? key,
    required this.user,
    required this.onSend,
    required this.messages,
    InputOptions? inputOptions,
    MessageOptions? messageOptions,
    MessageListOptions? messageListOptions,
    QuickReplyOptions? quickReplyOptions,
    ScrollToBottomOptions? scrollToBottomOptions,
    DashchatStyle? style,
    ScrollToBottomStyle? scrollToBottomStyle,
    this.height,
    this.width,
    this.readOnly = false,
    this.messageIdGenerator,
    this.text,
  }) : super(key: key) {
    this.scrollToBottomStyle = scrollToBottomStyle ?? new ScrollToBottomStyle();
    this.inputOptions = inputOptions ?? new InputOptions();
    this.messageOptions = messageOptions ?? new MessageOptions();
    this.messageListOptions = messageListOptions ?? new MessageListOptions();
    this.quickReplyOptions = quickReplyOptions ?? new QuickReplyOptions();
    this.scrollToBottomOptions =
        scrollToBottomOptions ?? new ScrollToBottomOptions();
    this.style = style ?? new DashchatStyle();
  }

  String? getVal() {
    return text;
  }

  @override
  DashChatState createState() => DashChatState();
}

class DashChatState extends State<DashChat> {
  late FocusNode? inputFocusNode;
  late TextEditingController? textController;
  late ScrollController scrollController;
  String _text = "";
  bool visible = false;
  GlobalKey inputKey = GlobalKey();
  double height = 48.0;
  bool showLoadMore = false;
  String get messageInput => _text;
  bool _initialLoad = true;
  Timer? _timer;
  final inverted = false;

  void onTextChange(String text) {
    if (visible) {
      changeVisible(false);
    }
    setState(() {
      this._text = text;
    });
  }

  void changeVisible(bool value) {
    if (!widget.scrollToBottomOptions.disabled) {
      setState(() {
        visible = value;
      });
    }
  }

  void changeDefaultLoadMore(bool value) {
    setState(() {
      showLoadMore = value;
    });
  }

  @override
  void initState() {
    scrollController =
        widget.messageListOptions.scrollController ?? ScrollController();
    textController = widget.inputOptions.textEditingController ??
        TextEditingController(text: '');
    inputFocusNode = widget.inputOptions.focusNode;
    WidgetsBinding.instance!.addPostFrameCallback(widgetBuilt);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void widgetBuilt(Duration d) {
    double initPos =
        inverted ? 0.0 : scrollController.position.maxScrollExtent + 25.0;

    scrollController
        .animateTo(
      initPos,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    )
        .whenComplete(() {
      _timer = Timer(Duration(milliseconds: 1000), () {
        if (this.mounted) {
          setState(() {
            _initialLoad = false;
          });
        }
      });
    });

    scrollController.addListener(() {
      bool topReached = inverted
          ? scrollController.offset >=
                  scrollController.position.maxScrollExtent &&
              !scrollController.position.outOfRange
          : scrollController.offset <=
                  scrollController.position.minScrollExtent &&
              !scrollController.position.outOfRange;

      if (widget.messageListOptions.shouldStartMessageFromTop) {
        if (topReached) {
          setState(() {
            showLoadMore = true;
          });
        } else {
          setState(() {
            showLoadMore = false;
          });
        }
      } else if (topReached) {
        widget.messageListOptions.onLoadEarlier!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.width
            : constraints.maxWidth;
        final maxHeight = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.height
            : constraints.maxHeight;
        var chatInputToolbar = ChatInputToolbar(
          key: inputKey,
          sendOnEnter: widget.inputOptions.sendOnEnter,
          textInputAction: widget.inputOptions.textInputAction,
          inputToolbarPadding: widget.inputOptions.inputToolbarPadding,
          textDirection: widget.inputOptions.inputTextDirection,
          inputToolbarMargin: widget.inputOptions.inputToolbarMargin,
          showTraillingBeforeSend: widget.inputOptions.showTraillingBeforeSend,
          inputMaxLines: widget.inputOptions.inputMaxLines,
          controller: textController,
          inputDecoration: widget.inputOptions.inputDecoration,
          textCapitalization: widget.inputOptions.textCapitalization,
          onSend: widget.onSend,
          user: widget.user,
          messageIdGenerator: widget.messageIdGenerator,
          maxInputLength: widget.inputOptions.maxInputLength,
          // TODO : change this
          // sendButtonBuilder:
          //     widget.inputOptions.sendButtonBuilder,
          text: widget.text != null ? widget.text : _text,
          onTextChange: widget.inputOptions.onTextChange != null
              ? widget.inputOptions.onTextChange
              : onTextChange,
          inputDisabled: widget.inputOptions.inputDisabled,
          leading: widget.inputOptions.leading,
          trailling: widget.inputOptions.trailing,
          inputContainerStyle: widget.inputOptions.inputContainerStyle,
          inputTextStyle: widget.inputOptions.inputTextStyle,
          inputFooterBuilder: widget.inputOptions.inputFooterBuilder,
          inputCursorColor: widget.inputOptions.cursorStyle.color,
          inputCursorWidth: widget.inputOptions.cursorStyle.width,
          showInputCursor: !widget.inputOptions.cursorStyle.hide,
          alwaysShowSend: widget.inputOptions.alwayShowSend,
          scrollController: scrollController,
          focusNode: inputFocusNode,
          reverse: inverted,
        );
        return Container(
          height: widget.height != null ? widget.height : maxHeight,
          width: widget.width != null ? widget.width : maxWidth,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment:
                    widget.messageListOptions.shouldStartMessageFromTop
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                children: <Widget>[
                  MessageListView(
                    avatarMaxSize: widget.messageOptions.avatarMaxSize,
                    messagePadding: widget.messageOptions.messagePadding,
                    constraints: constraints,
                    shouldShowLoadEarlier:
                        widget.messageListOptions.shouldShowLoadEarlier,
                    showLoadEarlierWidget:
                        widget.messageListOptions.showLoadEarlierBuilder,
                    onLoadEarlier: widget.messageListOptions.onLoadEarlier,
                    defaultLoadCallback: changeDefaultLoadMore,
                    messageContainerPadding:
                        widget.messageOptions.messageContainerPadding,
                    scrollController: scrollController,
                    user: widget.user,
                    messages: widget.messages,
                    showuserAvatar: widget.messageOptions.showCurrentUserAvatar,
                    dateFormat: widget.messageListOptions.dateSperatorFormat,
                    timeFormat: widget.messageOptions.timeFormat,
                    inverted: inverted,
                    showAvatarForEverMessage:
                        widget.messageListOptions.showAvatarForEveryMessage,
                    onLongPressAvatar: widget.messageOptions.onLongPressAvatar,
                    onPressAvatar: widget.messageOptions.onPressAvatar,
                    onLongPressMessage:
                        widget.messageOptions.onLongPressMessage,
                    avatarBuilder: widget.messageOptions.avatarBuilder,
                    messageBuilder: widget.messageOptions.messageBuilder,
                    messageTextBuilder:
                        widget.messageOptions.messageTextBuilder,
                    messageImageBuilder:
                        widget.messageOptions.messageImageBuilder,
                    messageTimeBuilder:
                        widget.messageOptions.messageTimeBuilder,
                    dateBuilder: widget.messageListOptions.dateSeperatorBuilder,
                    messageContainerDecoration:
                        widget.messageOptions.messageContainerDecoration,
                    parsePatterns: widget.messageOptions.parsePatterns,
                    changeVisible: changeVisible,
                    visible: visible,
                    showLoadMore: showLoadMore,
                    messageButtonsBuilder:
                        widget.messageOptions.messageButtonsBuilder,
                    messageDecorationBuilder:
                        widget.messageOptions.messageDecorationBuilder,
                  ),
                  if (widget.messages.length != 0 &&
                      widget.messages.last.user.uid != widget.user.uid &&
                      widget.messages.last.quickReplies != null)
                    Container(
                      padding: widget.quickReplyOptions.quickReplyPadding,
                      constraints: BoxConstraints(
                          maxHeight: widget.quickReplyOptions.quickReplyScroll
                              ? 50.0
                              : 100.0),
                      width: widget.quickReplyOptions.quickReplyScroll
                          ? null
                          : maxWidth,
                      child: widget.quickReplyOptions.quickReplyScroll
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: widget
                                  .messages.last.quickReplies!.values!
                                  .map(_mapReply)
                                  .toList(),
                            )
                          : Wrap(
                              children: <Widget>[
                                ...widget.messages.last.quickReplies!.values!
                                    .sublist(
                                        0,
                                        widget.messages.last.quickReplies!
                                                    .values!.length <=
                                                3
                                            ? widget.messages.last.quickReplies!
                                                .values!.length
                                            : 3)
                                    .map(_mapReply)
                                    .toList(),
                              ],
                            ),
                    ),
                  if (widget.inputOptions.inputFooterBuilder != null)
                    widget.inputOptions.inputFooterBuilder!(),
                  if (!widget.readOnly)
                    SafeArea(
                      child: chatInputToolbar,
                    )
                ],
              ),
              if (visible && !_initialLoad)
                Positioned(
                  right: widget.scrollToBottomStyle.right,
                  left: widget.scrollToBottomStyle.left,
                  bottom: widget.scrollToBottomStyle.bottom,
                  top: widget.scrollToBottomStyle.top,
                  child: widget.scrollToBottomOptions.scrollToBottomBuilder !=
                          null
                      ? widget.scrollToBottomOptions.scrollToBottomBuilder!()
                      : ScrollToBottom(
                          onScrollToBottomPress: widget
                              .scrollToBottomOptions.onScrollToBottomPress,
                          scrollToBottomStyle: widget.scrollToBottomStyle,
                          scrollController: scrollController,
                          inverted: inverted, // TODO: change this
                        ),
                ),
            ],
          ),
        );
      },
    );
  }

  QuickReply _mapReply(Reply reply) => QuickReply(
        reply: reply,
        onReply: widget.quickReplyOptions.onQuickReply,
        quickReplyBuilder: widget.quickReplyOptions.quickReplyBuilder,
        quickReplyStyle: widget.quickReplyOptions.quickReplyStyle,
        quickReplyTextStyle: widget.quickReplyOptions.quickReplyTextStyle,
      );
}
