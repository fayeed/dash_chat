## [1.1.15-nullsafety]

- Support for sound null-safety added [#164](https://github.com/fayeed/dash_chat/pull/164) by [@diegogarciar](https://github.com/diegogarciar)

## [1.1.15]

- Memory leaked issue fixed, PR [#133](https://github.com/fayeed/dash_chat/pull/133) by [@peter-sg](https://github.com/peter-sg) & [@pycstitch](https://github.com/pycstitch)

## [1.1.14]

- `messageDecorationBuilder` property added.

## [1.1.13]

- Fixed a bug from previous update.

## [1.1.12]

- `inputDisabled` property added.

## [1.1.11]

- Fixed a bug with previous version causing the widget to break.

## [1.1.10]

- Add quick reply horizontal scroll and padding options

## [1.1.9]

- Fixed issue #91, where setting the name was not handled properly

## [1.1.8]

- Fixed issue #78, scrollToBottom widget not scrolling to maxExtent properly

## [1.1.7]

- Fixed issue #30 where scrollToBottom widget was visible when the widget was dismounted.

## [1.1.6]

- Added `firstName` & `lastName` property to User.
- Added `avatarMaxSize` property to avatar Container.
- Fix an issue with text Alignment when buttons are set in message container.

## [1.1.5]

- Added a new property `shouldStartMessagesFromTop` to Dashchat.

## [1.1.4]

- Fixed an issue with date builder and inverted list.
- Replaced SizedBox with Opacity for User Avatar.
- Custom Message padding property added.
- Fixed an issue with avatar position when the list is inverted.
- Added a new property `customProperties` to ChatUser model.

## [1.1.3]

- A small bug fixed with inverted message list.

## [1.1.2]

- Correct alignmnet to message buttons.
- Added readonly mode to dashchat which hides the inputbar.
- Fix avatar exception when username is null.

## [1.1.1]

- Fixed an issue where an conversion `toJson` for class `ChatUser` was crashing the app.

## [1.1.0]

- Ability to send message on Enter or input action keyboard.
- `MediaQuery` replaced with `LayoutBuilder`.
- Added optional paramter for `ChatMessage`
- Ability to have action buttons in ChatMessages.
- Change Avatar `Boxfit.contain` to `Boxfit.cover`.

## [1.0.20]

- `customProperties` property added to ChatMessgae class.
- Color serialization error fixed.

## [1.0.19]

- Fixed issue #51
- fix scroll to top when inverted and send

## [1.0.18]

- `inputTextDirection` property added.

## [1.0.17]

- Ability to set custom focus node for input.

- Removed SingleChildScrollView from root.

- Added `WidgetsBinding.instance.addPostFrameCallback` to prevent scrolling before the messages are built.

## [1.0.16]

- removed unnecessary print from the `message_listview`

- changed 'vedio' field to 'video'

- nullpointer on parsing quick replies; more detailed error reporting for ChatMessage parsing

## [1.0.15]

- If `inverted` is true, it will no longer scroll.

## [1.0.14]

- `textController` property added.

## [1.0.13]

- `textCapitalization` property null error.

## [1.0.12]

- `textCapitalization` property added for Input Toolbar.

## [1.0.11]

- Fixed an issue where `dateFormat` property was not working.
- Fixed an issue where input value was not cleared.
- Fixed an issue where the whole screen incluing the input was scrollable.
- Few improvemnets to Bottom Scroll Button.

## [1.0.10]

- Updated dependency intl to `0.16.0`.

## [1.0.9]

- ScrollController not attached issue fixed.

## [1.0.8]

- Made the default avatar responsive for the current user.

## [1.0.7]

- Made the default avatar responsive.
- Two new property `inputToolbarPadding` & `inputToolbarMargin` added.

## [1.0.6]

- Change the default message container size to fix the overflowing of text.
- Added a new feature to close the keyboard if tap anywhere else on the screen.

## [1.0.5]

- Fixed an issue where `scrollToBottom` widget was not disabled.
- Fixed an issue where message container was not resized properly based on screen width.
- Fixed a performance issue when scroll down.
- Fixed an issue where `onLoadEarlier` was being called every time the listview moved.

## [1.0.4]

- Models updated

## [1.0.3]

- Small fixes to the InputToolbar and ChatMessage class

## [1.0.2]

- ChatMessage serialization added

## [1.0.1]

- Description updated and small fix

## [1.0.0]

- Minor fixes and first release

## [0.1.6]

- LoadEarlier Widget functionality added

## [0.1.5]

- ScrollToBottom Widget functionality added

## [0.1.4]

- `showTraillingBeforeSend` property added

## [0.1.3]

- Quick Reply functionality added.

## [0.1.2]

- Chat Bubble are more customizable now.

## [0.1.1]

- User avatar now show user initials while loading & if not avatar is passed

## [0.1.0]

- Initial Release
