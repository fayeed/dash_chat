part of dash_chat;

class ScrollToBottomStyle {
  /// Background color of the scrollToBottom widget
  ///
  /// Defaults to theme accent color
  Color? backgroundColor;

  /// Text/ Icon color for scrollToBottom widget
  ///
  /// Defaults to white
  Color? textColor;

  /// Height of the scrollToBottom widget
  ///
  /// Defaults to `45.0`
  double height;

  /// Width of the scrollToBottom widget
  ///
  /// Defaults to `45.0`
  double width;

  /// Top absolute position of the widget
  ///
  /// Defaults to 0.0
  double? top;

  /// Left absolute position of the widget
  ///
  /// Defaults to 0.0
  double? left;

  /// Right absolute position of the widget
  ///
  /// Defaults to 20.0
  double right;

  /// Bottom absolute position of the widget
  ///
  /// Defaults to 60.0
  double bottom;

  /// Icon inside the widget
  ///
  /// Defaults to material icon -> `keyboard_arrow_down`
  IconData? icon;

  ScrollToBottomStyle({
    this.backgroundColor,
    this.textColor,
    this.bottom = 70.0,
    this.left,
    this.right: 20.0,
    this.top,
    this.height: 45.0,
    this.width: 45.0,
    this.icon,
  });
}
