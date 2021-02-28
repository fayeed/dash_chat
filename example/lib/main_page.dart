import 'package:example/main_model.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DashChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DashChatModel>(
        create: (context) => DashChatModel()..init(),
        builder: (context, child) {
          return Consumer<DashChatModel>(builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Chat App"),
              ),
              body: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (RawKeyEvent event) async {
                  // command + Enter が押された
                  if (event.isMetaPressed &&
                      event.isKeyPressed(LogicalKeyboardKey.enter) &&
                      model.controller.text.length != 0) {
                    await model.sendMessage();
                  }
                },
                child: DashChat(
                  onLoadEarlier: () {},
                  user: model.chatUser,
                  avatarBuilder: (avatar) {
                    return Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://avatars.githubusercontent.com/u/65471734?v=4'),
                        ),
                      ),
                    );
                  },
                  messages: model.chatMessages,
                  inputMaxLines: 20,
                  inputToolbarPadding: EdgeInsets.all(10),
                  inputDecoration: InputDecoration(
                    hintText: "テキストを入力してください",
                    border: InputBorder.none,
                  ),
                  onTextChange: (text) {
                    model.notifyListeners();
                  },
                  textController: model.controller,
                  onSend: null,
                  sendButtonBuilder: (value) {
                    return IconButton(
                      icon: Icon(Icons.send),
                      onPressed: model.controller.text.length != 0
                          ? () async => await model.sendMessage()
                          : null,
                    );
                  },
                  timeFormat: DateFormat('HH:mm'),
                ),
              ),
            );
          });
        });
  }
}
