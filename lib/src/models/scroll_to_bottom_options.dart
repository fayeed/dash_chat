part of dash_chat;

class ScrollToBottomOptions {
  final bool disabled;
  final Widget Function()? scrollToBottomBuilder;
  final Function? onScrollToBottomPress;
  final ScrollToBottomStyle? scrollToBottomStyle;

  ScrollToBottomOptions({
    this.scrollToBottomBuilder,
    this.onScrollToBottomPress,
    this.scrollToBottomStyle,
    this.disabled = false,
  });
}
