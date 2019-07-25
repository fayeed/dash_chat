part of dash_chat;

/// Avatar container for the the chat view uses a [CircleAvatar]
/// widget as default which can be overriden by providing
/// [avatarBuilder] property
class AvatarContainer extends StatelessWidget {
  /// A [ChatUser] object use to get the url of the user
  /// avatar
  final ChatUser user;

  /// [onPress] function takea a function with this structure
  /// [Function(ChatUser)] will trigger when the avatar
  /// is tapped on
  final Function(ChatUser) onPress;

  /// [onLongPress] function takea a function with this structure
  /// [Function(ChatUser)] will trigger when the avatar
  /// is long pressed
  final Function(ChatUser) onLongPress;

  /// [avatarBuilder] function takea a function with this structure
  /// [Widget Function(ChatUser)] to build the avatar
  final Widget Function(ChatUser) avatarBuilder;

  const AvatarContainer({
    @required this.user,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(user),
      onLongPress: () => onLongPress(user),
      child: avatarBuilder != null
          ? avatarBuilder(user)
          : CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
              radius: 20.0,
            ),
    );
  }
}
