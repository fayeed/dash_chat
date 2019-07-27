import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dash_chat/dash_chat.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  final ChatUser user = ChatUser(
    name: "Fayeed",
    uid: "123456789",
    avatar: "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
    color: Colors.white,
    containerColor: Colors.pinkAccent,
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
    avatar: "",
    color: Colors.white,
    containerColor: Colors.green,
  );

  List<ChatMessage> messages = List<ChatMessage>();

  @override
  void initState() {
    var d1 = DateTime.utc(2019, 7, 22);
    var d2 = DateTime.utc(2019, 7, 23);
    var d3 = DateTime.utc(2019, 7, 24);

    messages.add(ChatMessage(text: "How are you?", user: user, createdAt: d1));
    messages.add(ChatMessage(text: "Hi", user: otherUser, createdAt: d2));
    messages
        .add(ChatMessage(text: "I am fine", user: otherUser, createdAt: d2));
    messages.add(ChatMessage(
        text: "Good some freetime wanna meet?",
        user: otherUser,
        createdAt: d2));
    messages.add(ChatMessage(
        text: "When do you want to meet tommorrow?",
        user: user,
        createdAt: d3));
    messages.add(
      ChatMessage(
        text: "Ok, great meet you there fayeed@live.com",
        user: otherUser,
        createdAt: d3,
        quickReplies: QuickReplies(
          values: <Reply>[
            Reply(
              title: "I will Message you later",
              value: "I will Message you later",
            ),
            Reply(
              title: "Maybe not.",
              value: "Maybe not.",
            ),
            Reply(
              title: "Meet me at my place",
              value: "Meet me at my place",
            ),
            Reply(
              title: "What!!",
              value: "What!!",
            ),
          ],
        ),
      ),
    );

    super.initState();
  }

  void onSend(ChatMessage message) {
    print(message.user.uid);
    setState(() {
      // messages.add(message);
      messages = [...messages, message];
      print(messages.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
      ),
      body: DashChat(
        key: _chatViewKey,
        inverted: false,
        onSend: onSend,
        user: user,
        maxInputLength: 80,
        inputDecoration:
            InputDecoration.collapsed(hintText: "Add message here..."),
        dateFormat: DateFormat('yyyy-MM-dd'),
        timeFormat: DateFormat('HH:mm'),
        messages: messages,
        showUserAvatar: false,
        showAvatarForEveryMessage: false,
        onPressAvatar: (ChatUser user) {
          print("OnPressAvatar: ${user.name}");
        },
        onLongPressAvatar: (ChatUser user) {
          print("OnLongPressAvatar: ${user.name}");
        },
        /*  messageContainerDecoration: BoxDecoration(
           color: Colors.green,
         ), */
        inputMaxLines: 2,
        messageContainerPadding: EdgeInsets.all(5.0),
        alwaysShowSend: true,
        inputTextStyle: TextStyle(fontSize: 16.0),
        inputContainerStyle: BoxDecoration(border: Border.all(width: 0.0)),
        onQuickReply: (Reply reply) {
          setState(() {
            messages.add(ChatMessage(
                text: reply.value, createdAt: DateTime.now(), user: user));

            messages = [...messages];
          });
        },
        quickReplyStyle: BoxDecoration(),
        quickReplyTextStyle: TextStyle(),
        quickReplyBuilder: (Reply reply) {
          return Text(reply.value);
        },
      ),
    );
  }
}
