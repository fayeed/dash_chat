part of dash_chat;

class MessageListView extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final BoxDecoration? messageContainerDecoration;
  final ScrollController? scrollController;
  final Function? changeVisible;
  final bool? visible;
  final bool? showLoadMore;
  final Function(bool) defaultLoadCallback;
  final BoxConstraints? constraints;
  final MessageOptions messageOptions;
  final MessageListOptions messageListOptions;

  MessageListView({
    required this.messageOptions,
    required this.messageListOptions,
    required this.defaultLoadCallback,
    this.scrollController,
    this.messageContainerDecoration,
    required this.messages,
    required this.user,
    this.changeVisible,
    this.visible,
    this.showLoadMore,
    this.constraints,
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
    if (widget.messageListOptions.showAvatarForEveryMessage) {
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
          padding: widget.messageOptions.messageContainerPadding,
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
                          customDateBuilder:
                              widget.messageListOptions.dateSeperatorBuilder,
                          dateFormat:
                              widget.messageListOptions.dateSperatorFormat,
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
                              opacity: (widget.messageListOptions
                                              .showAvatarForEveryMessage ||
                                          showAvatar) &&
                                      message.user.uid != widget.user.uid
                                  ? 1
                                  : 0,
                              child: AvatarContainer(
                                user: message.user,
                                onPress: widget.messageOptions.onPressAvatar,
                                onLongPress:
                                    widget.messageOptions.onLongPressAvatar,
                                avatarBuilder:
                                    widget.messageOptions.avatarBuilder,
                                avatarMaxSize:
                                    widget.messageOptions.avatarMaxSize,
                              ),
                            ),
                          Expanded(
                            child: GestureDetector(
                              onLongPress: () {
                                if (widget.messageOptions.onLongPressMessage !=
                                    null) {
                                  widget.messageOptions
                                      .onLongPressMessage!(message);
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
                              child: widget.messageOptions.messageBuilder !=
                                      null
                                  ? widget
                                      .messageOptions.messageBuilder!(message)
                                  : Align(
                                      alignment: message.user.uid ==
                                              widget.user.uid
                                          ? AlignmentDirectional.centerEnd
                                          : AlignmentDirectional.centerStart,
                                      child: MessageContainer(
                                        messagePadding: widget
                                            .messageOptions.messagePadding,
                                        constraints: constraints,
                                        isUser:
                                            message.user.uid == widget.user.uid,
                                        message: message,
                                        timeFormat:
                                            widget.messageOptions.timeFormat,
                                        messageImageBuilder: widget
                                            .messageOptions.messageImageBuilder,
                                        messageTextBuilder: widget
                                            .messageOptions.messageTextBuilder,
                                        messageTimeBuilder: widget
                                            .messageOptions.messageTimeBuilder,
                                        messageContainerDecoration:
                                            widget.messageContainerDecoration,
                                        parsePatterns:
                                            widget.messageOptions.parsePatterns,
                                        buttons: message.buttons,
                                        messageButtonsBuilder: widget
                                            .messageOptions
                                            .messageButtonsBuilder,
                                        textBeforeImage: widget
                                            .messageOptions.textBeforeImage,
                                        messageDecorationBuilder: widget
                                            .messageOptions
                                            .messageDecorationBuilder,
                                      ),
                                    ),
                            ),
                          ),
                          if (widget.messageListOptions.showCurrentUserAvatar)
                            Opacity(
                              opacity: (widget.messageListOptions
                                              .showAvatarForEveryMessage ||
                                          showAvatar) &&
                                      message.user.uid == widget.user.uid
                                  ? 1
                                  : 0,
                              child: AvatarContainer(
                                user: message.user,
                                onPress: widget.messageOptions.onPressAvatar,
                                onLongPress:
                                    widget.messageOptions.onLongPressAvatar,
                                avatarBuilder:
                                    widget.messageOptions.avatarBuilder,
                                avatarMaxSize:
                                    widget.messageOptions.avatarMaxSize,
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
                  child:
                      widget.messageListOptions.showLoadEarlierBuilder != null
                          ? widget.messageListOptions.showLoadEarlierBuilder!()
                          : LoadEarlierWidget(
                              onLoadEarlier:
                                  widget.messageListOptions.onLoadEarlier,
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
