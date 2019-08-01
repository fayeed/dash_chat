part of dash_chat;

class ScrollToBottom extends StatelessWidget {
  final Function onScrollToBottomPress;
  final ScrollController scrollController;

  ScrollToBottom({
    this.onScrollToBottomPress,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 48.0,
      child: RawMaterialButton(
        highlightElevation: 10.0,
        fillColor: Theme.of(context).primaryColor,
        shape: CircleBorder(),
        elevation: 0.0,
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        onPressed: () {
          if (onScrollToBottomPress != null) {
            onScrollToBottomPress();
          } else {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        },
      ),
    );
  }
}
