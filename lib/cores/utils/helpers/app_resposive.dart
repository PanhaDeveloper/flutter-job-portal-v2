import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  late Size _size;

  AppResponsive(this.context) {
    _size = MediaQuery.of(context).size;
  }

  /// Breakpoints
  bool get isSmallDevice => _size.width < 360;
  bool get isMediumDevice => _size.width >= 360 && _size.width < 600;
  bool get isLargeDevice => _size.width >= 600;

  /// Screen sizes
  double get width => _size.width;
  double get height => _size.height;

  /// Responsive heights
  double cardHeight() => _size.height * 0.25;

  /// Responsive font sizes
  double titleFontSize() =>
      isSmallDevice ? 18 : isMediumDevice ? 22 : 26;

  double jobFontSize() => isSmallDevice ? 12 : 14;

  /// Example spacing
  double defaultPadding() =>
      isSmallDevice ? 8 : isMediumDevice ? 12 : 16;
}
