import 'package:flutter/material.dart';

class AppResponsive {
  final BuildContext context;
  late Size _size;

  AppResponsive(this.context) {
    _size = MediaQuery.of(context).size;
  }

  /// Breakpoints - Updated for better small device support
  bool get isSmallDevice => _size.width < 360;
  bool get isMediumDevice => _size.width >= 360 && _size.width < 600;
  bool get isLargeDevice => _size.width >= 600;

  /// Screen sizes
  double get width => _size.width;
  double get height => _size.height;

  /// Responsive heights - Updated to prevent overflow
  double cardHeight() =>
      isSmallDevice
          ? _size.height * 0.20
          : isMediumDevice
          ? _size.height * 0.23
          : _size.height * 0.25;

  /// Responsive font sizes - Updated for better readability
  double titleFontSize() =>
      isSmallDevice
          ? 16
          : isMediumDevice
          ? 20
          : 24;

  double jobFontSize() => isSmallDevice ? 11 : 13;

  /// Responsive text sizes for different components
  double headerFontSize() =>
      isSmallDevice
          ? 14
          : isMediumDevice
          ? 16
          : 18;
  double subTitleFontSize() =>
      isSmallDevice
          ? 12
          : isMediumDevice
          ? 14
          : 16;
  double buttonFontSize() => isSmallDevice ? 12 : 14;

  /// Responsive spacing - Updated to prevent overflow
  double defaultPadding() =>
      isSmallDevice
          ? 6
          : isMediumDevice
          ? 10
          : 14;

  double smallPadding() => isSmallDevice ? 4 : 8;
  double mediumPadding() => isSmallDevice ? 8 : 12;
  double largePadding() => isSmallDevice ? 12 : 16;

  /// Widget constraints for responsive design
  double maxCardWidth() => isSmallDevice ? 140 : 180;

  /// Safe area for text overflow prevention
  double textMaxWidth() => _size.width * 0.7;
}
