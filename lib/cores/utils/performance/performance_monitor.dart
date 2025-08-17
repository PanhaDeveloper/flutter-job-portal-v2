import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PerformanceMonitor {
  static const PerformanceMonitor _instance = PerformanceMonitor._internal();
  factory PerformanceMonitor() => _instance;
  const PerformanceMonitor._internal();

  static bool _isInitialized = false;
  static final List<FrameTiming> _frameTimings = [];
  static Timer? _memoryMonitorTimer;

  /// Initialize performance monitoring
  static void initialize() {
    if (_isInitialized) return;

    _isInitialized = true;

    if (kDebugMode) {
      _setupFrameMonitoring();
      _setupMemoryMonitoring();
    }
  }

  /// Setup frame timing monitoring
  static void _setupFrameMonitoring() {
    SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
      _frameTimings.addAll(timings);

      // Keep only recent frames
      if (_frameTimings.length > 100) {
        _frameTimings.removeRange(0, _frameTimings.length - 100);
      }

      // Log slow frames
      for (final timing in timings) {
        final buildDuration = timing.buildDuration.inMilliseconds;
        final rasterDuration = timing.rasterDuration.inMilliseconds;

        if (buildDuration > 16 || rasterDuration > 16) {
          // More than 60fps
          developer.log(
            'Slow frame detected - Build: ${buildDuration}ms, Raster: ${rasterDuration}ms',
            name: 'PerformanceMonitor',
          );
        }
      }
    });
  }

  /// Setup memory monitoring
  static void _setupMemoryMonitoring() {
    _memoryMonitorTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _logMemoryUsage();
    });
  }

  /// Log current memory usage
  static void _logMemoryUsage() {
    if (kDebugMode) {
      developer.log('Memory monitoring active', name: 'PerformanceMonitor');
    }
  }

  /// Get average frame build time
  static double getAverageFrameBuildTime() {
    if (_frameTimings.isEmpty) return 0;

    final totalBuildTime = _frameTimings
        .map((timing) => timing.buildDuration.inMicroseconds)
        .reduce((a, b) => a + b);

    return totalBuildTime /
        _frameTimings.length /
        1000; // Convert to milliseconds
  }

  /// Get average frame raster time
  static double getAverageFrameRasterTime() {
    if (_frameTimings.isEmpty) return 0;

    final totalRasterTime = _frameTimings
        .map((timing) => timing.rasterDuration.inMicroseconds)
        .reduce((a, b) => a + b);

    return totalRasterTime /
        _frameTimings.length /
        1000; // Convert to milliseconds
  }

  /// Dispose resources
  static void dispose() {
    _memoryMonitorTimer?.cancel();
    _frameTimings.clear();
    _isInitialized = false;
  }

  /// Mark a custom performance event
  static void markEvent(String event, {Map<String, dynamic>? data}) {
    if (kDebugMode) {
      final dataString = data?.toString() ?? '';
      developer.log(
        'Performance Event: $event $dataString',
        name: 'PerformanceMonitor',
      );
    }
  }
}

/// Mixin for widgets to easily track performance
mixin PerformanceTracked<T extends StatefulWidget> on State<T> {
  late final Stopwatch _buildStopwatch;

  @override
  void initState() {
    super.initState();
    _buildStopwatch = Stopwatch();
  }

  @override
  Widget build(BuildContext context) {
    _buildStopwatch.start();
    final widget = buildWidget(context);
    _buildStopwatch.stop();

    if (kDebugMode && _buildStopwatch.elapsedMilliseconds > 16) {
      PerformanceMonitor.markEvent(
        'Slow Widget Build: ${runtimeType.toString()}',
        data: {'duration': _buildStopwatch.elapsedMilliseconds},
      );
    }

    _buildStopwatch.reset();
    return widget;
  }

  /// Override this instead of build()
  Widget buildWidget(BuildContext context);
}

/// Performance optimization wrapper
class PerformanceWrapper extends StatelessWidget {
  const PerformanceWrapper({super.key, required this.child, this.name});

  final Widget child;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(child: child);
  }
}
