<p align="center">
  <img src="https://media.giphy.com/media/LROJNHp7VquVer90gm/giphy.gif" />
  <h1 align="center">💬 Dash Chat</h1>
  <h5 align="center">The most complete Chat UI for flutter</h5>
  <p align="center">Inspired by <a href="https://github.com/FaridSafi/react-native-gifted-chat">react-native-gifted-chat.</a>
      Highly customizable and helps developing chat UI faster.
  </p>
</p>

### Usage 💻

To use this package, add `dash_chat` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Features  🔮

- Fully customizable components
- Copy messages to clipboard
- Multi-line TextInput
- Touchable links using [flutter_parsed_text](https://pub.dev/packages/flutter_parsed_text)
- Avatar as user's initials - WIP
- Quick Reply messages - WIP
- Load earlier messages -WIP
- Scroll to bottom - WIP
- System message - WIP
- Composer actions (to attach photos, etc.) -WIP

### Message object 📦
> example, Chat Message
```dart
ChatMessage(
        text: "Hello",
        user: ChatUser(
          name: "Fayeed",
          uid: "123456789",
          avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
        ),
        createdAt: DateTime.now(),
        image: "http://www.sclance.com/images/picture/Picture_753248.jpg",
    );
```
> example, Chat Message with Quick Replies
```dart
ChatMessage(
        text: "This is a quick reply example.",
        user: ChatUser(),
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[
            Reply(
              title: "😋 Yes",
              value: "Yes",
            ),
            Reply(
              title: "😞 Nope. What?",
              value: "no",
            ),
          ],
        ),
      ),
```

### Parameters ⚙️

- `messageContainerFlex` (int) - Flex value for the messeage container defaults to 1
- `height` (double) - Height for the Dash chat Widget
- `width` (double) - Width for the Dash chat Widget
- `messages` (List<ChatMessage>) - List of messages to display in the chat
- `text` (String) - [optional parameter] If provided will stop using the default controller
- `onTextChange` (Function(String)) - If the text parameter is passed then onTextChange must also be passed.
- `inputDecoration` (InputDecoration) - Used to provide input decoration to the text
- `messageIdGenerator` (String Function) - Usually new message added by the user gets UUID v4 String generater by [uuid](https://pub.dev/packages/uuid)
- `user` (ChatUser) - The current user object
- `onSend` (Function(ChatMessage)) - Callback when sending a message
- `alwaysShowSend` (bool) - Should the send button be always active defaults to false
- `dateFormat` (DateFormat) - Format to use for rendering date default is `yyyy-MM-dd`
- `timeFormat` (DateFormat) - Format to use for rendering time default is `HH:mm:ss`
- `showUserAvatar` (bool) - Should the user avatar be shown
- `showAvatarForEveryMessage` (bool) - Should the avatar be shown for every message defaulst to false
- `onPressAvatar` (Function(ChatUser)) - Callback funtion when avatar is tapped on.
- `onLongPressAvatar` (Function(ChatUser)) - Callback funtion when avatar is long pressed on.
- `onLongPressMessage` (Function(ChatUser)) - Callback funtion when message is long pressed on.
- `inverted` (bool) - Should the messages be shown in reversed order
- `avatarBuilder` (Widget Function(ChatUser)) - Will override the the default avatar
- `messageBuilder` (Widget Function(ChatMessage)) - Will override the the default message widget
- `messageTextBuilder` (Widget Function(String)) - Will override the the default message text widget
- `messageImageBuilder` (Widget Function(String)) - Will override the the default message imaeg widget
- `messageTimeBuilder` (Widget Function(String)) - Will override the the default message time widget
- `dateBuilder` (Widget Function(String)) - Will override the the default chat view date widget
- `sendButtonBuilder` (Widget Function(Function)) - Will override the the default send button widget
- `chatFooterBuilder` (Widget Function) - A Widget that will be shown below the MessageListView like you can a "tying..." Text Widget at the end.
- `inputFooterBuilder` (Widget Function) - A Widget that will be shown below the ChatInputToolbar
- `maxInputLength` (int) - Main input length of the input text box defaulst to no limit
- `parsePatterns` (List<MatchText>) - Used to parse text to make a linkified text uses [flutter_parsed_text](https://pub.dev/packages/flutter_parsed_text)
  ```dart
  DashChat(
    parsePatterns: <MatchText>[
      MatchText(
        type: "email",
        onTap: (String value) {}
      ),
      MatchText(
        pattern: r"\B#+([\w]+)\b",
        style: TextStyle(
          color: Colors.pink,
          fontSize: 24,
        ),
        onTap: (String value) {}
      ),
    ]
  );
  ```
- `messageContainerDecoration` (BoxDecoration) - Provides a custom style to the message container
- `leading` (List<Widget>) - List of Widget to show before the TextField
- `trailing` (List<Widget>) - List of Widget to show after the TextField will remove the send button
- `inputTextStyle` (TextStyle) - Style for the TextField
- `inputContainerStyle` (BoxDecoration) - TextField container style
- `inputMaxLines` (int) - Max length of the input lines default to 1
- `showInputCursor` (bool) - Should the input cursor be shown defaults to true
- `inputCursorWidth` (double) - Width of the text input defaults to 2.0
- `inputCursorColor` (Color) - Color of the input cursor defaults to theme
- `scrollController` (ScrollController) - ScrollController for the MessageListView
- `messageContainerPadding` (EdgeInsetsGeometry) - Padding for the MessageListView
- `onQuickReply` (Funtion(Reply)) - Callback method when the quickReply was tapped on
- `quickReplyStyle` (BoxDecoration) - Container style for the QuickReply Container
- `quickReplyTextStyle` (TextStyle) - QuickReply text style
- `quickReplyBuilder` (Widget Function(Reply)) - Will override the the default QuickReply Widget.

### License ⚖️
- [MIT](https://github.com/fayeed/dash_chat/blob/master/LICENSE)

### API details 📝

See the [dash_chat.dart](https://github.com/fayeed/dash_chat/blob/master/lib/dash_chat.dart) for more API details

### Issues and feedback 💭

Please file [issues](https://github.com/fayeed/dash_chat/issues)
to send feedback or report a bug. Thank you!
