import 'package:flutter/material.dart';

/// 複数行で文字が見切れる場合に適用するTextStyle
class MultiLineStyle extends TextStyle {
  const MultiLineStyle({
    fontSize,
    color,
    fontWeight,
  }) : super(
          height: 1.5,
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        );
}

/// MultiLineStyle の太字バージョン
class BoldMultiLineStyle extends TextStyle {
  const BoldMultiLineStyle({
    fontSize = 20,
    color,
  }) : super(
          height: 1.5,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        );
}
