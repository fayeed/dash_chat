import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MessageListOptions {
  late DateFormat dateSperatorFormat;
  final Widget Function(String)? dateSeperatorBuilder;
  final bool showAvatarForEveryMessage;
  late ScrollController scrollController;
  final bool shouldStartMessageFromTop;
  final bool shouldShowLoadEarlier;
  final Widget Function()? showLoadEarlierBuilder;
  final Function? onLoadEarlier;

  MessageListOptions({
    dateSperatorFormat,
    this.dateSeperatorBuilder,
    this.showAvatarForEveryMessage = false,
    scrollController,
    this.shouldStartMessageFromTop = false,
    this.shouldShowLoadEarlier = true,
    this.showLoadEarlierBuilder,
    this.onLoadEarlier,
  }) {
    dateSperatorFormat = DateFormat('dd MMM yyyy');
    scrollController = ScrollController();
  }
}
