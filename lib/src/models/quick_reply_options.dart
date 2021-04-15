import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

class QuickReplyOptions {
  final Function(Reply)? onQuickReply;
  final EdgeInsets? quickReplyPadding;
  final BoxDecoration? quickReplyStyle;
  final TextStyle? quickReplyTextStyle;
  final Widget Function(Reply)? quickReplyBuilder;
  final bool quickReplyScroll;

  QuickReplyOptions({
    this.onQuickReply,
    this.quickReplyPadding,
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.quickReplyBuilder,
    this.quickReplyScroll = false,
  });
}
