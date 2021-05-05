part of dash_chat;

class MessageOptions {
  final int messageContainerFlex;
  DateFormat? timeFormat;
  final bool showTime;
  final bool showCurrentUserAvatar;
  final bool showOtherUsersAvatar;
  final double avatarMaxSize;
  final Widget Function(ChatUser)? avatarBuilder;
  final Function(ChatUser)? onPressAvatar;
  final Function(ChatUser)? onLongPressAvatar;
  final Function(ChatMessage)? onLongPressMessage;
  final Color? currentUserContainerColor;
  final Color? currentUserTextColor;
  final Color? containerColor;
  final Color? textColor;
  final Widget Function(ChatMessage)? messageBuilder;
  final Widget Function(ChatMessage)? messageTextBuilder;
  final Widget Function(ChatMessage)? messageImageBuilder;
  final Widget Function(String, ChatMessage)? messageTimeBuilder;
  // TODO: add default types for mentions or figure out a better way
  final List<MatchText> parsePatterns;
  final BoxDecoration? messageContainerDecoration;
  final EdgeInsets messageContainerPadding;
  final List<Widget> Function(ChatMessage)? messageButtonsBuilder;
  final EdgeInsets messagePadding;
  final bool textBeforeImage;
  final BoxDecoration Function(ChatMessage bool)? messageDecorationBuilder;
  // TODO: don't remember these two props find their usecase
  final Widget Function(ChatMessage)? top;
  final Widget Function(ChatMessage)? bottom;

  MessageOptions({
    this.messageContainerFlex = 1,
    DateFormat? timeFormat,
    this.showTime = true,
    this.showCurrentUserAvatar = false,
    this.showOtherUsersAvatar = true,
    this.avatarMaxSize = 30.0,
    this.avatarBuilder,
    this.onPressAvatar,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.currentUserContainerColor,
    this.currentUserTextColor,
    this.containerColor,
    this.textColor,
    this.messageBuilder,
    this.messageTextBuilder,
    this.messageImageBuilder,
    this.messageTimeBuilder,
    this.parsePatterns = const [],
    this.messageContainerDecoration,
    this.messageContainerPadding = const EdgeInsets.all(0.0),
    this.messageButtonsBuilder,
    this.messagePadding = const EdgeInsets.all(0.0),
    this.textBeforeImage = true,
    this.messageDecorationBuilder,
    this.top,
    this.bottom,
  }) {
    timeFormat = this.timeFormat ?? DateFormat('HH:mm');
  }
}
