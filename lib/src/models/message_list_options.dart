part of dash_chat;

class MessageListOptions {
  DateFormat? dateSperatorFormat;
  final Widget Function(String)? dateSeperatorBuilder;
  final bool showAvatarForEveryMessage;
  ScrollController? scrollController;
  final bool shouldStartMessageFromTop;
  final bool shouldShowLoadEarlier;
  final Widget Function()? showLoadEarlierBuilder;
  final Function? onLoadEarlier;

  MessageListOptions({
    this.dateSperatorFormat,
    this.dateSeperatorBuilder,
    this.showAvatarForEveryMessage = false,
    ScrollController? scrollController,
    this.shouldStartMessageFromTop = false,
    this.shouldShowLoadEarlier = true,
    this.showLoadEarlierBuilder,
    this.onLoadEarlier,
  }) {
    dateSperatorFormat = this.dateSperatorFormat ?? DateFormat('dd MMM yyyy');
    scrollController = this.scrollController ?? ScrollController();
  }
}
