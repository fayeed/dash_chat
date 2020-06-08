part of dash_chat;

class ScrollToBottomStyle {
  Color backgroundColor;
  Color textColor;
  double height;
  double width;
  double top;
  double left;
  double right;
  double bottom;
  IconData icon;

  ScrollToBottomStyle({
    this.backgroundColor,
    this.textColor,
    this.bottom = 80.0,
    this.left,
    this.right: 20.0,
    this.top,
    this.height: 45.0,
    this.width: 45.0,
    this.icon,
  });
}
