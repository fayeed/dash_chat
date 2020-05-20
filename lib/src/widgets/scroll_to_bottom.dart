part of dash_chat;

class ScrollToBottom extends StatelessWidget {
  final Function onScrollToBottomPress;
  final ScrollController scrollController;
  final double bottomPosition;
  final Color backgroundColor;
  final Color textColor;

  ScrollToBottom({
    this.onScrollToBottomPress,
    this.scrollController,
    this.bottomPosition,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      child: RawMaterialButton(
        elevation: 5,
        fillColor: backgroundColor ?? Theme.of(context).primaryColor,
        shape: CircleBorder(),
        child: Icon(
          Icons.keyboard_arrow_down,
          color: textColor ?? Colors.white,
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
