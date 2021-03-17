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

  /// [constraints] to apply to build the layout
  /// by default used MediaQuery and take screen size as constaints
  final BoxConstraints constraints;

  final double avatarMaxSize;

  const AvatarContainer({
    @required this.user,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
    this.constraints,
    this.avatarMaxSize,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

    return GestureDetector(
      onTap: () => onPress != null ? onPress(user) : null,
      onLongPress: () => onLongPress != null ? onLongPress(user) : null,
      child: avatarBuilder != null
          ? avatarBuilder(user)
          : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    height: constraints.maxWidth * 0.15,
                    width: constraints.maxWidth * 0.15,
                    constraints: BoxConstraints(
                      maxWidth: avatarMaxSize + 15,
                      maxHeight: avatarMaxSize + 15,
                    ),
                    color: Colors.grey,
                    child: Center(
                      child: Text(userInitial(user.firstName,user.lastName),style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(202, 202, 202, 1),
                     ),)),
                  ),
                ),
                user.avatar != null && user.avatar.length != 0 && user.avatar.contains("/")
                  ? Center(
                      child: ClipOval(
                        child: FadeInImage.memoryNetwork(
                          image: user.avatar,
                          placeholder: kTransparentImage,
                          fit: BoxFit.cover,
                          height: constraints.maxWidth * 0.12,
                          width: constraints.maxWidth * 0.12,
                        ),
                      ),
                    )
                  : Container()
              ],
            ),
    );
  }
   String userInitial(String firstName, String lastName) {
    String value;
    if (lastName != '' && lastName != null) {
      if (firstName != '' && firstName != null) {
        value = firstName[0].toUpperCase() + lastName[0].toUpperCase();
      } else {
        value = lastName.substring(0,2).toUpperCase();
      }
    } else {
      if (firstName == '' || firstName == null) {
        value = '';
      } else {
        var nameArray = firstName.split(' ');
        if (nameArray.length > 1) {
          value = nameArray[0].substring(0,1).toUpperCase() + nameArray[1].substring(0,1).toUpperCase();
        } else {
          value = firstName.substring(0,2).toUpperCase();
        }
      }
    }
    return value;
  }

}
