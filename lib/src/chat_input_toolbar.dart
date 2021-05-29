part of dash_chat;

class ChatInputToolbar extends StatelessWidget {
  final TextEditingController? controller;
  final ChatUser user;
  final Function(ChatMessage)? onSend;
  final String? text;
  final Function(String)? onTextChange;
  final String Function()? messageIdGenerator;
  final Widget Function(Function)? sendButtonBuilder;
  final ScrollController? scrollController;
  final bool showTraillingBeforeSend;
  final FocusNode? focusNode;
  final InputOptions inputOptions;
  final bool reverse;

  ChatInputToolbar({
    Key? key,
    this.reverse = false,
    this.focusNode,
    this.scrollController,
    this.text,
    this.onTextChange,
    this.controller,
    this.onSend,
    required this.user,
    this.messageIdGenerator,
    this.sendButtonBuilder,
    this.showTraillingBeforeSend = true,
    required this.inputOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChatMessage message = ChatMessage(
      text: text,
      user: user,
      messageIdGenerator: messageIdGenerator,
      createdAt: DateTime.now(),
    );

    return Container(
      padding: inputOptions.inputToolbarPadding,
      margin: inputOptions.inputToolbarMargin,
      decoration: inputOptions.inputContainerStyle != null
          ? inputOptions.inputContainerStyle
          : BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ...inputOptions.leading,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Directionality(
                    textDirection: inputOptions.inputTextDirection!,
                    child: TextField(
                      focusNode: focusNode,
                      onChanged: (value) {
                        onTextChange!(value);
                      },
                      onSubmitted: (value) {
                        if (inputOptions.sendOnEnter) {
                          _sendMessage(context, message);
                        }
                      },
                      textInputAction: inputOptions.textInputAction,
                      buildCounter: (
                        BuildContext context, {
                        int? currentLength,
                        int? maxLength,
                        bool? isFocused,
                      }) =>
                          null,
                      decoration: inputOptions.inputDecoration != null
                          ? inputOptions.inputDecoration
                          : InputDecoration.collapsed(
                              hintText: "",
                              fillColor: Colors.white,
                            ),
                      textCapitalization: inputOptions.textCapitalization,
                      controller: controller,
                      style: inputOptions.inputTextStyle,
                      maxLength: inputOptions.maxInputLength,
                      minLines: 1,
                      maxLines: inputOptions.inputMaxLines,
                      showCursor: !inputOptions.cursorStyle.hide,
                      cursorColor: inputOptions.cursorStyle.color,
                      cursorWidth: inputOptions.cursorStyle.width,
                      enabled: !inputOptions.inputDisabled,
                    ),
                  ),
                ),
              ),
              if (showTraillingBeforeSend) ...inputOptions.trailling,
              if (sendButtonBuilder != null)
                sendButtonBuilder!(() async {
                  if (text!.length != 0) {
                    await onSend!(message);

                    controller!.text = "";

                    onTextChange!("");
                  }
                })
              else
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: inputOptions.alwayShowSend || text!.length != 0
                      ? () => _sendMessage(context, message)
                      : null,
                ),
              if (!showTraillingBeforeSend) ...inputOptions.trailling,
            ],
          ),
          if (inputOptions.inputFooterBuilder != null)
            inputOptions.inputFooterBuilder!()
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, ChatMessage message) async {
    if (text!.length != 0) {
      await onSend!(message);

      controller!.text = "";

      onTextChange!("");

      FocusScope.of(context).requestFocus(focusNode);

      Timer(Duration(milliseconds: 150), () {
        scrollController?.animateTo(
          reverse ? 0.0 : scrollController!.position.maxScrollExtent + 30.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
      });
    }
  }
}
