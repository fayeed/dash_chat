import 'package:flutter_test/flutter_test.dart';

import 'package:dash_chat/dash_chat.dart';

void main() {
  test('can instantiate a ChatUser passing a name', () {
    ChatUser chatUser = ChatUser(
      name: 'my-name',
    );

    expect(chatUser.name, 'my-name');
  });

  test('can instantiate a ChatUser passing a first and last name', () {
    ChatUser chatUser = ChatUser(
      firstName: 'first',
      lastName: 'last',
    );

    expect(chatUser.name, 'first last');
  });
}
