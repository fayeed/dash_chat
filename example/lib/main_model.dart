import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';

class DashChatModel extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final controller = TextEditingController();
  ChatUser chatUser = ChatUser();
  List<ChatMessage> chatMessages = [];
  List<DocumentSnapshot> items = [];

  Future init() async {
    // ログインユーザーを chatUser と結びつける
    this.chatUser.name = 'ダイゴ';
    this.chatUser.uid = 'daigoId';
    this.chatUser.avatar =
        'https://avatars.githubusercontent.com/u/65471734?v=4';
    this.chatUser.color = Colors.black;
    this.chatUser.containerColor = Colors.white;

    /// チャットメッセージを監視する
    final snapshots = _firestore.collection('messages').snapshots();

    snapshots.listen((snapshot) async {
      // messages が生成されると、chatMassages として表示する
      final items = snapshot.docs;
      final chatMessages =
          items.map((i) => ChatMessage.fromJson(i.data())).toList();
      this.chatMessages = chatMessages;
      notifyListeners();
    });

    notifyListeners();
  }

  /// メッセージの送信
  Future sendMessage() async {
    final message = ChatMessage(text: controller.text, user: this.chatUser);
    final batch = _firestore.batch();
    // messages コレクションに UNIX 形式のドキュメントIDで保存する
    final messageDoc = _firestore
        .collection('messages')
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    batch.set(messageDoc, message.toJson());

    // テキストを空にする
    controller.clear();

    return await batch.commit();
  }
}
