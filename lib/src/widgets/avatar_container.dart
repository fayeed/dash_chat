part of dash_chat;

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({
    @required this.message,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
  });

  final ChatMessage message;
  final Function(ChatUser) onPress;
  final Function(ChatUser) onLongPress;
  final Widget Function(ChatUser) avatarBuilder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(message.user),
      onLongPress: () => onLongPress(message.user),
      child: avatarBuilder != null
          ? avatarBuilder(message.user)
          : CircleAvatar(
              backgroundImage: NetworkImage(message.user.avatar),
              radius: 20.0,
            ),
    );
  }
}
