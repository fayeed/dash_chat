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

  MessageListView({
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
  });

  @override
  Widget build(BuildContext context) {
    DateTime currentDate;

    return ScrollConfiguration(
      behavior: CustomScrollBehaviour(),
      child: Flexible(
        child: Padding(
          padding: messageContainerPadding,
          child: ListView.builder(
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
                print(showDate);
              } else if (currentDate.difference(messages[i].createdAt).inDays !=
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
                        Text(dateBuilder != null
                            ? dateFormat.format(messages[i].createdAt)
                            : DateFormat('yyyy-MM-dd')
                                .format(messages[i].createdAt)),
                    Row(
                      mainAxisAlignment: messages[i].user.uid == user.uid
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ((showAvatarForEverMessage || showAvatar) &&
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
                                              leading: Icon(Icons.content_copy),
                                              title: Text("Copy to clipboard"),
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: messages[i].text));
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
                                  message: messages[i],
                                  timeFormat: timeFormat,
                                  messageImageBuilder: messageImageBuilder,
                                  messageTextBuilder: messageTextBuilder,
                                  messageTimeBuilder: messageTimeBuilder,
                                  messageContainerDecoration:
                                      messageContainerDecoration,
                                  parsePatterns: parsePatterns,
                                ),
                        ),
                        if (showuserAvatar)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: ((showAvatarForEverMessage || showAvatar) &&
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
        ),
      ),
    );
  }
}
