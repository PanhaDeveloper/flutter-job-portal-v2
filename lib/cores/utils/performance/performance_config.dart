import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Performance configuration constants and utilities
class PerformanceConfig {
  // Animation durations for smooth UX
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 250);
  static const Duration slowAnimation = Duration(milliseconds: 400);

  // Animation curves for smooth transitions
  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve fastCurve = Curves.easeOut;
  static const Curve bounceCurve = Curves.elasticOut;

  // Image optimization settings
  static const int maxImageCacheSize = 200;
  static const int maxImageCacheSizeBytes = 100 * 1024 * 1024; // 100MB

  // List optimization settings
  static const double defaultCacheExtent = 500.0;
  static const bool addAutomaticKeepAlives = false;
  static const bool addRepaintBoundaries = true;
  static const bool addSemanticIndexes = false;

  // Network optimization
  static const Duration networkTimeout = Duration(seconds: 30);
  static const int maxConcurrentNetworkRequests = 5;

  /// Initialize performance optimizations
  static void initializePerformanceOptimizations() {
    // Image cache optimization
    PaintingBinding.instance.imageCache.maximumSize = maxImageCacheSize;
    PaintingBinding.instance.imageCache.maximumSizeBytes =
        maxImageCacheSizeBytes;

    // Disable debug banners in release mode
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }

    // Configure system UI for better performance
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
  }

  /// Get optimized scroll physics
  static ScrollPhysics getOptimizedScrollPhysics() {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }

  /// Get optimized text theme for better performance
  static TextTheme getOptimizedTextTheme(BuildContext context) {
    final baseTheme = Theme.of(context).textTheme;
    return baseTheme.copyWith(
      // Pre-calculate text styles to avoid runtime calculations
      displayLarge: baseTheme.displayLarge?.copyWith(
        fontFeatures: const [FontFeature.proportionalFigures()],
      ),
      displayMedium: baseTheme.displayMedium?.copyWith(
        fontFeatures: const [FontFeature.proportionalFigures()],
      ),
      displaySmall: baseTheme.displaySmall?.copyWith(
        fontFeatures: const [FontFeature.proportionalFigures()],
      ),
    );
  }

  /// Calculate optimal image dimensions based on screen size
  static Size calculateOptimalImageSize(
    BuildContext context, {
    required double aspectRatio,
    double maxWidth = double.infinity,
    double maxHeight = double.infinity,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    double width = screenSize.width;
    double height = screenSize.width / aspectRatio;

    if (width > maxWidth) {
      width = maxWidth;
      height = width / aspectRatio;
    }

    if (height > maxHeight) {
      height = maxHeight;
      width = height * aspectRatio;
    }

    // Scale for device pixel ratio for crisp images
    return Size(
      (width * devicePixelRatio).roundToDouble(),
      (height * devicePixelRatio).roundToDouble(),
    );
  }

  /// Get memory-efficient list configuration
  static Map<String, dynamic> getListConfiguration({
    double? cacheExtent,
    bool? addAutomaticKeepAlives,
    bool? addRepaintBoundaries,
    bool? addSemanticIndexes,
  }) {
    return {
      'cacheExtent': cacheExtent ?? defaultCacheExtent,
      'addAutomaticKeepAlives':
          addAutomaticKeepAlives ?? PerformanceConfig.addAutomaticKeepAlives,
      'addRepaintBoundaries':
          addRepaintBoundaries ?? PerformanceConfig.addRepaintBoundaries,
      'addSemanticIndexes':
          addSemanticIndexes ?? PerformanceConfig.addSemanticIndexes,
    };
  }

  /// Debounce function calls for better performance
  static Timer? _debounceTimer;
  static void debounce(
    VoidCallback callback, {
    Duration delay = const Duration(milliseconds: 300),
  }) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(delay, callback);
  }

  /// Dispose debounce timer
  static void disposeDebounce() {
    _debounceTimer?.cancel();
    _debounceTimer = null;
  }
}

/// Memory-efficient color constants
class OptimizedColors {
  // Pre-defined colors to avoid runtime color calculations
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);

  static const Color secondary = Color(0xFFFF9800);
  static const Color secondaryLight = Color(0xFFFFB74D);
  static const Color secondaryDark = Color(0xFFF57C00);

  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color success = Color(0xFF4CAF50);
  static const Color info = Color(0xFF2196F3);

  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFF000000);
  static const Color onBackground = Color(0xFF000000);
  static const Color onSurface = Color(0xFF000000);

  // Grayscale colors
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
}

/// Pre-calculated border radius values
class OptimizedBorderRadius {
  static const BorderRadius small = BorderRadius.all(Radius.circular(4));
  static const BorderRadius medium = BorderRadius.all(Radius.circular(8));
  static const BorderRadius large = BorderRadius.all(Radius.circular(12));
  static const BorderRadius extraLarge = BorderRadius.all(Radius.circular(16));
  static const BorderRadius circular = BorderRadius.all(Radius.circular(50));
}

/// Pre-calculated edge insets
class OptimizedPadding {
  static const EdgeInsets zero = EdgeInsets.zero;
  static const EdgeInsets small = EdgeInsets.all(8);
  static const EdgeInsets medium = EdgeInsets.all(16);
  static const EdgeInsets large = EdgeInsets.all(24);
  static const EdgeInsets extraLarge = EdgeInsets.all(32);

  static const EdgeInsets horizontalSmall = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets horizontalMedium = EdgeInsets.symmetric(
    horizontal: 16,
  );
  static const EdgeInsets horizontalLarge = EdgeInsets.symmetric(
    horizontal: 24,
  );

  static const EdgeInsets verticalSmall = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets verticalMedium = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets verticalLarge = EdgeInsets.symmetric(vertical: 24);
}
