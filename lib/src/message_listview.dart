part of dash_chat;

class MessageListView extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final bool? showuserAvatar;
  final DateFormat? dateFormat;
  final DateFormat? timeFormat;
  final bool showAvatarForEverMessage;
  final Function(ChatUser)? onPressAvatar;
  final Function(ChatUser)? onLongPressAvatar;
  final bool? renderAvatarOnTop;
  final Function(ChatMessage)? onLongPressMessage;
  final Widget Function(ChatUser)? avatarBuilder;
  final Widget Function(ChatMessage)? messageBuilder;
  final Widget Function(ChatMessage)? messageTextBuilder;
  final Widget Function(ChatMessage)? messageImageBuilder;
  final Widget Function(String, ChatMessage)? messageTimeBuilder;
  final Widget Function(String)? dateBuilder;
  final Widget Function()? renderMessageFooter;
  final BoxDecoration? messageContainerDecoration;
  final List<MatchText> parsePatterns;
  final ScrollController? scrollController;
  final EdgeInsets messageContainerPadding;
  final Function? changeVisible;
  final bool? visible;
  final bool? showLoadMore;
  final bool? shouldShowLoadEarlier;
  final Widget Function()? showLoadEarlierWidget;
  final Function? onLoadEarlier;
  final Function(bool) defaultLoadCallback;
  final BoxConstraints? constraints;
  final List<Widget> Function(ChatMessage)? messageButtonsBuilder;
  final EdgeInsets messagePadding;
  final bool textBeforeImage;
  final double? avatarMaxSize;
  final BoxDecoration Function(ChatMessage)? messageDecorationBuilder;

  MessageListView({
    this.showLoadEarlierWidget,
    this.avatarMaxSize,
    this.shouldShowLoadEarlier,
    this.constraints,
    this.onLoadEarlier,
    required this.defaultLoadCallback,
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
    this.scrollController,
    this.parsePatterns = const [],
    this.messageContainerDecoration,
    required this.messages,
    required this.user,
    this.showuserAvatar,
    this.dateFormat,
    this.timeFormat,
    this.showAvatarForEverMessage = false,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.renderAvatarOnTop,
    this.messageBuilder,
    this.renderMessageFooter,
    this.avatarBuilder,
    this.dateBuilder,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.changeVisible,
    this.visible,
    this.showLoadMore,
    this.messageButtonsBuilder,
    this.messagePadding = const EdgeInsets.all(8.0),
    this.textBeforeImage = true,
    this.messageDecorationBuilder,
  });

  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  double previousPixelPostion = 0.0;

  bool scrollNotificationFunc(ScrollNotification scrollNotification) {
    double bottom = scrollNotification.metrics.maxScrollExtent;

    if (scrollNotification.metrics.pixels == bottom) {
      if (widget.visible!) {
        widget.changeVisible!(false);
      }
    } else if ((scrollNotification.metrics.pixels - bottom).abs() > 100) {
      if (!widget.visible!) {
        widget.changeVisible!(true);
      }
    }
    return false;
  }

  bool shouldShowAvatar(int index, List<ChatListItem> chatItems) {
    if (widget.showAvatarForEverMessage) {
      return true;
    }

    if (index + 1 < chatItems.length) {
      final chatItem = chatItems[index];
      final nextChatItem = chatItems[index + 1];
      return chatItem.message?.user.uid != nextChatItem.message?.user.uid;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final constraints = widget.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

    final messages = buildMessageList(widget.messages);

    return Flexible(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: widget.messageContainerPadding,
          child: NotificationListener<ScrollNotification>(
            onNotification: scrollNotificationFunc,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                ListView.builder(
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final bool showAvatar = shouldShowAvatar(i, messages);
                    final bool first = i == 0;
                    final bool last = i == messages.length - 1;
                    final chatItem = messages[i];

                    if (chatItem.type == ChatListItemType.date) {
                      return Center(
                        child: DateBuilder(
                          date: chatItem.dateTime,
                          customDateBuilder: widget.dateBuilder,
                          dateFormat: widget.dateFormat,
                        ),
                      );
                    }

                    final message = chatItem.message!;
                    final bool isUser = message.user.uid == widget.user.uid;

                    return Padding(
                      padding: EdgeInsets.only(
                        top: first ? 10.0 : 0.0,
                        bottom: last ? 10.0 : 0.0,
                      ),
                      child: Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          if (message.user.uid != widget.user.uid)
                            Opacity(
                              opacity: (widget.showAvatarForEverMessage ||
                                          showAvatar) &&
                                      message.user.uid != widget.user.uid
                                  ? 1
                                  : 0,
                              child: AvatarContainer(
                                user: message.user,
                                onPress: widget.onPressAvatar,
                                onLongPress: widget.onLongPressAvatar,
                                avatarBuilder: widget.avatarBuilder,
                                avatarMaxSize: widget.avatarMaxSize,
                              ),
                            ),
                          Expanded(
                            child: GestureDetector(
                              onLongPress: () {
                                if (widget.onLongPressMessage != null) {
                                  widget.onLongPressMessage!(message);
                                } else {
                                  showBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                ListTile(
                                                  leading:
                                                      Icon(Icons.content_copy),
                                                  title:
                                                      Text("Copy to clipboard"),
                                                  onTap: () {
                                                    Clipboard.setData(
                                                        ClipboardData(
                                                            text: widget
                                                                .messages[i]
                                                                .text));
                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ),
                                          ));
                                }
                              },
                              child: widget.messageBuilder != null
                                  ? widget.messageBuilder!(message)
                                  : Align(
                                      alignment: message.user.uid ==
                                              widget.user.uid
                                          ? AlignmentDirectional.centerEnd
                                          : AlignmentDirectional.centerStart,
                                      child: MessageContainer(
                                        messagePadding: widget.messagePadding,
                                        constraints: constraints,
                                        isUser:
                                            message.user.uid == widget.user.uid,
                                        message: message,
                                        timeFormat: widget.timeFormat,
                                        messageImageBuilder:
                                            widget.messageImageBuilder,
                                        messageTextBuilder:
                                            widget.messageTextBuilder,
                                        messageTimeBuilder:
                                            widget.messageTimeBuilder,
                                        messageContainerDecoration:
                                            widget.messageContainerDecoration,
                                        parsePatterns: widget.parsePatterns,
                                        buttons: message.buttons,
                                        messageButtonsBuilder:
                                            widget.messageButtonsBuilder,
                                        textBeforeImage: widget.textBeforeImage,
                                        messageDecorationBuilder:
                                            widget.messageDecorationBuilder,
                                      ),
                                    ),
                            ),
                          ),
                          if (widget.showuserAvatar!)
                            Opacity(
                              opacity: (widget.showAvatarForEverMessage ||
                                          showAvatar) &&
                                      message.user.uid == widget.user.uid
                                  ? 1
                                  : 0,
                              child: AvatarContainer(
                                user: message.user,
                                onPress: widget.onPressAvatar,
                                onLongPress: widget.onLongPressAvatar,
                                avatarBuilder: widget.avatarBuilder,
                                avatarMaxSize: widget.avatarMaxSize,
                              ),
                            )
                          else
                            SizedBox(
                              width: 10.0,
                            ),
                        ],
                      ),
                    );
                  },
                ),
                Container(
                  height: 100.0,
                ),
                AnimatedPositioned(
                  top: widget.showLoadMore! ? 8.0 : -50.0,
                  duration: Duration(milliseconds: 200),
                  child: widget.showLoadEarlierWidget != null
                      ? widget.showLoadEarlierWidget!()
                      : LoadEarlierWidget(
                          onLoadEarlier: widget.onLoadEarlier,
                          defaultLoadCallback: widget.defaultLoadCallback,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
