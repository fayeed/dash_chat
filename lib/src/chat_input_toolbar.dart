part of dash_chat;

class ChatInputToolbar extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle inputTextStyle;
  final InputDecoration inputDecoration;
  final BoxDecoration inputContainerStyle;
  final List<Widget> leading;
  final List<Widget> trailling;
  final int inputMaxLines;
  final int maxInputLength;
  final bool alwaysShowSend;
  final ChatUser user;
  final Function(ChatMessage) onSend;
  final String text;
  final Function(String) onTextChange;
  final String Function() messageIdGenerator;
  final Widget Function(Function) sendButtonBuilder;
  final Widget Function() inputFooterBuilder;
  final bool showInputCursor;
  final double inputCursorWidth;
  final Color inputCursorColor;
  final ScrollController scrollController;
  final bool showTraillingBeforeSend;

  ChatInputToolbar({
    this.scrollController,
    this.text,
    this.onTextChange,
    this.controller,
    this.leading = const [],
    this.trailling = const [],
    this.inputDecoration,
    this.inputTextStyle,
    this.inputContainerStyle,
    this.inputMaxLines = 1,
    this.showInputCursor = true,
    this.maxInputLength,
    this.inputCursorWidth = 2.0,
    this.inputCursorColor,
    this.onSend,
    @required this.user,
    this.alwaysShowSend = false,
    this.messageIdGenerator,
    this.inputFooterBuilder,
    this.sendButtonBuilder,
    this.showTraillingBeforeSend = true,
  });

  @override
  Widget build(BuildContext context) {
    ChatMessage message = ChatMessage(
      text: text,
      user: user,
      messageIdGenerator: messageIdGenerator,
      createdAt: DateTime.now(),
    );

    return Container(
      decoration: inputContainerStyle != null
          ? inputContainerStyle
          : BoxDecoration(color: Colors.purple),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ...leading,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      onTextChange(value);
                    },
                    buildCounter: (BuildContext context,
                            {int currentLength,
                            int maxLength,
                            bool isFocused}) =>
                        null,
                    decoration: inputDecoration != null
                        ? inputDecoration
                        : InputDecoration.collapsed(hintText: ""),
                    controller: controller,
                    style: inputTextStyle,
                    maxLength: maxInputLength,
                    minLines: 1,
                    maxLines: inputMaxLines,
                    showCursor: showInputCursor,
                    cursorColor: inputCursorColor,
                    cursorWidth: inputCursorWidth,
                  ),
                ),
              ),
              if (showTraillingBeforeSend) ...trailling,
              if (sendButtonBuilder != null)
                sendButtonBuilder(() {
                  onSend(message);

                  controller.text = "";
                })
              else
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: alwaysShowSend || text.length != 0
                      ? () {
                          onSend(message);

                          controller.text = "";

                          Timer(Duration(milliseconds: 300), () {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              curve: Curves.easeOut,
                              duration: const Duration(milliseconds: 300),
                            );
                          });
                        }
                      : null,
                ),
              if (!showTraillingBeforeSend) ...trailling,
            ],
          ),
          if (inputFooterBuilder != null) inputFooterBuilder()
        ],
      ),
    );
  }
}
