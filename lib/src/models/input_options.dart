part of dash_chat;

// TODO: add list of widgets to the top & bottom
class InputOptions {
  TextEditingController? textEditingController;
  FocusNode? focusNode;
  final TextDirection? inputTextDirection;
  final String hintText;
  final TextStyle? hintStyle;
  final ChatUser Function(String)? onMention;
  final Function(String)? onTextChange;
  final bool inputDisabled;
  final InputDecoration? inputDecoration;
  final TextCapitalization textCapitalization;
  final bool alwayShowSend;
  final bool sendOnEnter;
  final TextInputAction? textInputAction;
  final int? maxInputLength;
  final List<Widget> leading;
  final List<Widget> trailling;
  final TextStyle? inputTextStyle;
  final BoxDecoration? inputContainerStyle;
  final int inputMaxLines;
  final Widget Function()? inputFooterBuilder;
  final bool showTraillingBeforeSend;
  final EdgeInsets inputToolbarPadding;
  final EdgeInsets inputToolbarMargin;
  final CursorStyle cursorStyle;

  InputOptions({
    TextEditingController? textEditingController,
    FocusNode? focusNode,
    this.inputTextDirection = TextDirection.ltr,
    this.hintText = "Write a message here...",
    this.hintStyle,
    this.onMention,
    this.onTextChange,
    this.inputDisabled = false,
    this.inputDecoration,
    this.textCapitalization = TextCapitalization.none,
    this.alwayShowSend = false,
    this.sendOnEnter = false,
    this.textInputAction,
    this.maxInputLength,
    this.leading = const [],
    this.trailling = const [],
    this.inputTextStyle,
    this.inputContainerStyle,
    this.inputMaxLines = 5,
    this.inputFooterBuilder,
    this.showTraillingBeforeSend = false,
    this.inputToolbarPadding = const EdgeInsets.all(0.0),
    this.inputToolbarMargin = const EdgeInsets.all(0.0),
    this.cursorStyle = const CursorStyle(),
  }) {
    textEditingController =
        textEditingController ?? TextEditingController(text: '');
    focusNode = focusNode ?? FocusNode();
  }
}

class CursorStyle {
  final double width;
  final double? height;
  final Radius? radius;
  final Color? color;
  final bool hide;

  const CursorStyle({
    this.width = 2.0,
    this.height,
    this.radius,
    this.color,
    this.hide = false,
  });
}
