import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// TODO: add list of widgets to the top & bottom
class InputOptions {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
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
  final double? maxInputLength;
  final List<Widget> leading;
  final List<Widget> trailing;
  final TextStyle? inputTextStyle;
  final BoxDecoration? inputContainerStyle;
  final int inputMaxLines;
  final Widget Function()? inputFooterBuilder;
  final bool showTraillingBeforeSend;
  final EdgeInsets? inputToolbarPadding;
  final EdgeInsets? inputToolbarMargin;
  final CursorStyle? cursorStyle;

  InputOptions({
    textEditingController,
    focusNode,
    this.inputTextDirection,
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
    this.trailing = const [],
    this.inputTextStyle,
    this.inputContainerStyle,
    this.inputMaxLines = 5,
    this.inputFooterBuilder,
    this.showTraillingBeforeSend = false,
    this.inputToolbarPadding,
    this.inputToolbarMargin,
    this.cursorStyle,
  }) {
    textEditingController = TextEditingController(text: '');
    focusNode = FocusNode();
  }
}

class CursorStyle {
  final double width;
  final double? height;
  final Radius? radius;
  final Color? color;
  final bool hide;

  CursorStyle({
    this.width = 2.0,
    this.height,
    this.radius,
    this.color,
    this.hide = false,
  });
}
