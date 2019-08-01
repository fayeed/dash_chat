part of dash_chat;

class MessageListView extends StatelessWidget {
  final List<ChatMessage> messages;
  final ChatUser user;
  final bool showuserAvatar;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final bool showAvatarForEverMessage;
  final Function(ChatUser) onPressAvatar;
  final Function(ChatUser) onLongPressAvatar;
  final bool renderAvatarOnTop;
  final Function(ChatMessage) onLongPressMessage;
  final bool inverted;
  final Widget Function(ChatUser) avatarBuilder;
  final Widget Function(ChatMessage) messageBuilder;
  final Widget Function(String) messageTextBuilder;
  final Widget Function(String url) messageImageBuilder;
  final Widget Function(String) messageTimeBuilder;
  final Widget Function(String) dateBuilder;
  final Widget Function() renderMessageFooter;
  final BoxDecoration messageContainerDecoration;
  final List<MatchText> parsePatterns;
  final ScrollController scrollController;
  final EdgeInsets messageContainerPadding;
  final Function changeVisible;
  final bool visible;
  final bool showLoadMore;
  final bool shouldShowLoadEarlier;
  final Widget Function() showLoadEarlierWidget;
  final Function onLoadEarlier;
  final Function(bool) defaultLoadCallback;

  double previousPixelPostion = 0.0;

  MessageListView({
    this.showLoadEarlierWidget,
    this.shouldShowLoadEarlier,
    this.onLoadEarlier,
    this.defaultLoadCallback,
    this.messageContainerPadding =
        const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
    this.scrollController,
    this.parsePatterns = const [],
    this.messageContainerDecoration,
    this.messages,
    this.user,
    this.showuserAvatar,
    this.dateFormat,
    this.timeFormat,
    this.showAvatarForEverMessage,
    this.inverted,
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
  });

  bool scrollNotificationFunc(ScrollNotification scrollNotification) {
    if (previousPixelPostion == 0.0) {
      previousPixelPostion = scrollNotification.metrics.maxScrollExtent;
    }

    if (scrollNotification.metrics.pixels ==
        scrollNotification.metrics.maxScrollExtent) {
      changeVisible(false);
    } else {
      if (previousPixelPostion < scrollNotification.metrics.pixels) {
        changeVisible(true);
      }

      previousPixelPostion = scrollNotification.metrics.pixels;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;

    return ScrollConfiguration(
      behavior: CustomScrollBehaviour(),
      child: Flexible(
        child: Padding(
          padding: messageContainerPadding,
          child: NotificationListener<ScrollNotification>(
            onNotification: scrollNotificationFunc,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  reverse: inverted,
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final j = i + 1;
                    bool showAvatar = false;
                    bool showDate;
                    if (j < messages.length) {
                      showAvatar = messages[j].user.uid != messages[i].user.uid;
                    } else {
                      showAvatar = true;
                    }

                    if (currentDate == null) {
                      currentDate = messages[i].createdAt;
                      showDate = true;
                    } else if (currentDate
                            .difference(messages[i].createdAt)
                            .inDays !=
                        0) {
                      showDate = true;
                      currentDate = messages[i].createdAt;
                    } else {
                      showDate = false;
                    }

                    return Align(
                      child: Column(
                        children: <Widget>[
                          if (showDate)
                            if (dateBuilder != null)
                              dateBuilder(dateBuilder != null
                                  ? dateFormat.format(messages[i].createdAt)
                                  : DateFormat('yyyy-MM-dd')
                                      .format(messages[i].createdAt))
                            else
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0)),
                                padding: EdgeInsets.only(
                                  bottom: 5.0,
                                  top: 5.0,
                                  left: 10.0,
                                  right: 10.0,
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  dateBuilder != null
                                      ? dateFormat.format(messages[i].createdAt)
                                      : DateFormat('MMM dd')
                                          .format(messages[i].createdAt),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                          Row(
                            mainAxisAlignment: messages[i].user.uid == user.uid
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child:
                                    ((showAvatarForEverMessage || showAvatar) &&
                                            messages[i].user.uid != user.uid)
                                        ? AvatarContainer(
                                            user: messages[i].user,
                                            onPress: onPressAvatar,
                                            onLongPress: onLongPressAvatar,
                                            avatarBuilder: avatarBuilder,
                                          )
                                        : SizedBox(
                                            width: 40.0,
                                          ),
                              ),
                              GestureDetector(
                                onLongPress: () {
                                  if (onLongPressMessage != null) {
                                    onLongPressMessage(messages[i]);
                                  } else {
                                    showBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    leading: Icon(
                                                        Icons.content_copy),
                                                    title: Text(
                                                        "Copy to clipboard"),
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: messages[i]
                                                                  .text));
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ));
                                  }
                                },
                                child: messageBuilder != null
                                    ? messageBuilder(messages[i])
                                    : MessageContainer(
                                        isUser:
                                            messages[i].user.uid == user.uid,
                                        message: messages[i],
                                        timeFormat: timeFormat,
                                        messageImageBuilder:
                                            messageImageBuilder,
                                        messageTextBuilder: messageTextBuilder,
                                        messageTimeBuilder: messageTimeBuilder,
                                        messageContainerDecoration:
                                            messageContainerDecoration,
                                        parsePatterns: parsePatterns,
                                      ),
                              ),
                              if (showuserAvatar)
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: ((showAvatarForEverMessage ||
                                              showAvatar) &&
                                          messages[i].user.uid == user.uid)
                                      ? AvatarContainer(
                                          user: messages[i].user,
                                          onPress: onPressAvatar,
                                          onLongPress: onLongPressAvatar,
                                          avatarBuilder: avatarBuilder,
                                        )
                                      : SizedBox(
                                          width: 40.0,
                                        ),
                                )
                              else
                                SizedBox(
                                  width: 10.0,
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                AnimatedPositioned(
                  top: showLoadMore ? 8.0 : -50.0,
                  duration: Duration(milliseconds: 200),
                  child: showLoadEarlierWidget != null
                      ? showLoadEarlierWidget()
                      : LoadEarlierWidget(
                          onLoadEarlier: onLoadEarlier,
                          defaultLoadCallback: defaultLoadCallback,
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
