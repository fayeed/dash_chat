part of dash_chat;

class ScrollToBottom extends StatelessWidget {
  final Function onScrollToBottomPress;
  final ScrollController scrollController;
  final double bottomPosition;
  final ScrollToBottomStyle scrollToBottomStyle;

  ScrollToBottom({
    this.onScrollToBottomPress,
    this.scrollController,
    this.bottomPosition,
    this.scrollToBottomStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scrollToBottomStyle.width,
      height: scrollToBottomStyle.height,
      child: RawMaterialButton(
        elevation: 5,
        fillColor: scrollToBottomStyle.backgroundColor ??
            Theme.of(context).primaryColor,
        shape: CircleBorder(),
        child: Icon(
          scrollToBottomStyle.icon ?? Icons.keyboard_arrow_down,
          color: scrollToBottomStyle.textColor ?? Colors.white,
        ),
        onPressed: () {
          if (onScrollToBottomPress != null) {
            onScrollToBottomPress();
          } else {
            scrollController.animateTo(
              bottomPosition ?? scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        },
      ),
    );
  }
}
