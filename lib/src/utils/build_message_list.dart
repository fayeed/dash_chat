part of dash_chat;

enum ChatListItemType { date, message }

class ChatListItem {
  final ChatListItemType type;
  final DateTime dateTime;
  final ChatMessage? message;

  ChatListItem({
    required this.type,
    required this.dateTime,
    required this.message,
  });
}

List<ChatListItem> buildMessageList(List<ChatMessage> messages) {
  Map<String, List<ChatMessage>> _messages = Map<String, List<ChatMessage>>();
  List<ChatListItem> chatItems = [];
  final dateFormat = DateFormat('yyyy-MM-dd');

  for (var message in messages) {
    final formattedDate = dateFormat.format(message.createdAt);

    if (_messages.containsKey(formattedDate)) {
      _messages[formattedDate]?.add(message);
    } else {
      _messages[formattedDate] = [message];
    }
  }

  for (var item in _messages.entries) {
    chatItems.add(ChatListItem(
      type: ChatListItemType.date,
      dateTime: dateFormat.parse(item.key),
      message: null,
    ));

    print(item.value.length);

    for (var mes in item.value) {
      chatItems.add(ChatListItem(
        type: ChatListItemType.message,
        dateTime: dateFormat.parse(item.key),
        message: mes,
      ));
    }
  }

  return chatItems;
}
