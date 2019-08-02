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
  );

  final ChatUser otherUser = ChatUser(
    name: "Mrfatty",
    uid: "25649654",
    avatar: "",
  );

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  @override
  void initState() {
    m.addAll([
      ChatMessage(text: "Hi", user: otherUser, createdAt: DateTime.now()),
      ChatMessage(
        text: "How are you?",
        user: otherUser,
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[
            Reply(
              title: "Great, What about you",
              value: "Great, What about you",
            ),
            Reply(
              title: "I am good, How are you",
              value: "I am good, How are you",
            ),
          ],
        ),
      ),
      ChatMessage(
        text: "I am fine",
        user: otherUser,
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[
            Reply(
              title: "Where are you travelling too",
              value: "Where are you travelling too",
            ),
            Reply(
              title: "When do you want to meet",
              value: "When do you want to meet",
            ),
          ],
        ),
      ),
      ChatMessage(
        text: "Paris",
        user: otherUser,
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[
            Reply(
              title: "Can you send a pic later",
              value: "Can you send a pic later",
            ),
            Reply(
              title: "Send me pic of Eiffel tower",
              value: "Send me pic of Eiffel tower",
            ),
          ],
        ),
      ),
      ChatMessage(
        text: "",
        image:
            "https://amp.insider.com/images/58d919eaf2d0331b008b4bbd-750-562.jpg",
        user: otherUser,
        createdAt: DateTime.now(),
        quickReplies: QuickReplies(
          values: <Reply>[
            Reply(
              title: "Looks awesome",
              value: "Looks awesome",
            ),
            Reply(
              title: "Cool",
              value: "Cool",
            ),
            Reply(
              title: "Wow 😲",
              value: "Wow 😲",
            ),
          ],
        ),
      ),
      ChatMessage(
        text: "Message you in a bit",
        user: otherUser,
        createdAt: DateTime.now(),
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
      )
    ]);

    super.initState();
  }

  void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        setState(() {
          messages = [...messages, m[i]];
        });
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState.scrollController
          ..animateTo(
            _chatViewKey.currentState.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }

  void onSend(ChatMessage message) {
    setState(() {
      messages = [...messages, message];
      print(messages.length);
    });

    if (i == 0) {
      systemMessage();
      Timer(Duration(milliseconds: 600), () {
        systemMessage();
      });
    } else {
      systemMessage();
    }
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
        inputDecoration:
            InputDecoration.collapsed(hintText: "Add message here..."),
        dateFormat: DateFormat('yyyy-MMM-dd'),
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
        inputMaxLines: 5,
        messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
        alwaysShowSend: true,
        inputTextStyle: TextStyle(fontSize: 16.0),
        inputContainerStyle: BoxDecoration(
          border: Border.all(width: 0.0),
          color: Colors.white,
        ),
        onQuickReply: (Reply reply) {
          setState(() {
            messages.add(ChatMessage(
                text: reply.value, createdAt: DateTime.now(), user: user));

            messages = [...messages];
          });

          Timer(Duration(milliseconds: 300), () {
            _chatViewKey.currentState.scrollController
              ..animateTo(
                _chatViewKey
                    .currentState.scrollController.position.maxScrollExtent,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );

            if (i == 0) {
              systemMessage();
              Timer(Duration(milliseconds: 600), () {
                systemMessage();
              });
            } else {
              systemMessage();
            }
          });
        },
        onLoadEarlier: () {
          print("laoding...");
        },
        shouldShowLoadEarlier: true,
        showTraillingBeforeSend: true,
        trailing: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            onPressed: () {
              print("object");
            },
          )
        ],
      ),
    );
  }
}
