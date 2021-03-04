part of dash_chat;

class MessageListView extends StatefulWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final bool? showuserAvatar;
  final DateFormat? dateFormat;
  final DateFormat? timeFormat;
  final bool? showAvatarForEverMessage;
  final Function(ChatUser)? onPressAvatar;
  final Function(ChatUser)? onLongPressAvatar;
  final bool? renderAvatarOnTop;
  final Function(ChatMessage)? onLongPressMessage;
  final bool inverted;
  final Widget Function(ChatUser)? avatarBuilder;
  final Widget Function(ChatMessage)? messageBuilder;
  final Widget Function(String?, [ChatMessage])? messageTextBuilder;
  final Widget Function(String?, [ChatMessage])? messageImageBuilder;
  final Widget Function(String, [ChatMessage])? messageTimeBuilder;
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
  final BoxDecoration Function(ChatMessage, bool?)? messageDecorationBuilder;

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
    this.showAvatarForEverMessage,
    required this.inverted,
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
    double bottom =
        widget.inverted ? 0.0 : scrollNotification.metrics.maxScrollExtent;

    if (scrollNotification.metrics.pixels == bottom) {
      if (widget.visible!) {
        widget.changeVisible!(false);
      }
    } else if ((scrollNotification.metrics.pixels - bottom).abs() > 100) {
      if (!widget.visible!) {
        widget.changeVisible!(true);
      }
    }
    return true;
  }

  bool shouldShowAvatar(int index) {
    if (widget.showAvatarForEverMessage!) {
      return true;
    }
    if (!widget.inverted && index + 1 < widget.messages.length) {
      return widget.messages[index + 1].user.uid !=
          widget.messages[index].user.uid;
    } else if (widget.inverted && index - 1 >= 0) {
      return widget.messages[index - 1].user.uid !=
          widget.messages[index].user.uid;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    DateTime? currentDate;

    final constraints = widget.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

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
                  reverse: widget.inverted,
                  itemCount: widget.messages.length,
                  itemBuilder: (context, i) {
                    bool showAvatar = shouldShowAvatar(i);
                    bool first = false;
                    bool last = false;
                    bool showDate;

                    if (widget.messages.length == 0) {
                      first = true;
                    } else if (widget.messages.length - 1 == i) {
                      last = true;
                    }

                    DateTime messageDate = DateTime(
                      widget.messages[i].createdAt.year,
                      widget.messages[i].createdAt.month,
                      widget.messages[i].createdAt.day,
                    );

                    // Needed for inverted list
                    DateTime previousDate = currentDate ?? messageDate;

                    if (currentDate == null) {
                      currentDate = messageDate;
                      showDate =
                          !widget.inverted || widget.messages.length == 1;
                    } else if (currentDate!.difference(messageDate).inDays !=
                        0) {
                      showDate = true;
                      currentDate = messageDate;
                    } else if (i == widget.messages.length - 1 &&
                        widget.inverted) {
                      showDate = true;
                    } else {
                      showDate = false;
                    }

                    return Align(
                      child: Column(
                        children: <Widget>[
                          if (showDate &&
                              (!widget.inverted ||
                                  widget.messages.length == 1 ||
                                  (last && widget.inverted)))
                            DateBuilder(
                              date:
                                  widget.inverted ? previousDate : currentDate!,
                              customDateBuilder: widget.dateBuilder,
                              dateFormat: widget.dateFormat,
                            ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: first ? 10.0 : 0.0,
                              bottom: last ? 10.0 : 0.0,
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  widget.messages[i].user.uid == widget.user.uid
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.02,
                                  ),
                                  child: Opacity(
                                    opacity:
                                        (widget.showAvatarForEverMessage! ||
                                                    showAvatar) &&
                                                widget.messages[i].user.uid !=
                                                    widget.user.uid
                                            ? 1
                                            : 0,
                                    child: AvatarContainer(
                                      user: widget.messages[i].user,
                                      onPress: widget.onPressAvatar,
                                      onLongPress: widget.onLongPressAvatar,
                                      avatarBuilder: widget.avatarBuilder,
                                      avatarMaxSize: widget.avatarMaxSize,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onLongPress: () {
                                      if (widget.onLongPressMessage != null) {
                                        widget.onLongPressMessage!(
                                            widget.messages[i]);
                                      } else {
                                        showBottomSheet(
                                            context: context,
                                            builder: (context) => Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      ListTile(
                                                        leading: Icon(
                                                            Icons.content_copy),
                                                        title: Text(
                                                            "Copy to clipboard"),
                                                        onTap: () {
                                                          Clipboard.setData(
                                                              ClipboardData(
                                                                  text: widget
                                                                      .messages[
                                                                          i]
                                                                      .text));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ));
                                      }
                                    },
                                    child: widget.messageBuilder != null
                                        ? widget
                                            .messageBuilder!(widget.messages[i])
                                        : Align(
                                            alignment: widget
                                                        .messages[i].user.uid ==
                                                    widget.user.uid
                                                ? AlignmentDirectional.centerEnd
                                                : AlignmentDirectional
                                                    .centerStart,
                                            child: MessageContainer(
                                              messagePadding:
                                                  widget.messagePadding,
                                              constraints: constraints,
                                              isUser:
                                                  widget.messages[i].user.uid ==
                                                      widget.user.uid,
                                              message: widget.messages[i],
                                              timeFormat: widget.timeFormat,
                                              messageImageBuilder:
                                                  widget.messageImageBuilder,
                                              messageTextBuilder:
                                                  widget.messageTextBuilder,
                                              messageTimeBuilder:
                                                  widget.messageTimeBuilder,
                                              messageContainerDecoration: widget
                                                  .messageContainerDecoration,
                                              parsePatterns:
                                                  widget.parsePatterns,
                                              buttons:
                                                  widget.messages[i].buttons,
                                              messageButtonsBuilder:
                                                  widget.messageButtonsBuilder,
                                              textBeforeImage:
                                                  widget.textBeforeImage,
                                              messageDecorationBuilder: widget
                                                  .messageDecorationBuilder,
                                            ),
                                          ),
                                  ),
                                ),
                                if (widget.showuserAvatar!)
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth * 0.02,
                                    ),
                                    child: Opacity(
                                      opacity:
                                          (widget.showAvatarForEverMessage! ||
                                                      showAvatar) &&
                                                  widget.messages[i].user.uid ==
                                                      widget.user.uid
                                              ? 1
                                              : 0,
                                      child: AvatarContainer(
                                        user: widget.messages[i].user,
                                        onPress: widget.onPressAvatar,
                                        onLongPress: widget.onLongPressAvatar,
                                        avatarBuilder: widget.avatarBuilder,
                                        avatarMaxSize: widget.avatarMaxSize,
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(
                                    width: 10.0,
                                  ),
                              ],
                            ),
                          ),
                          if (showDate &&
                              widget.inverted &&
                              widget.messages.length > 1 &&
                              !last)
                            DateBuilder(
                              date:
                                  widget.inverted ? previousDate : currentDate!,
                              customDateBuilder: widget.dateBuilder,
                              dateFormat: widget.dateFormat,
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
