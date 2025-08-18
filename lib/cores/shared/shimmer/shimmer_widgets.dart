import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Base shimmer widget that provides the shimmer effect
class BaseShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration period;

  const BaseShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.period = const Duration(milliseconds: 1500),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      period: period,
      child: child,
    );
  }
}

/// Generic shimmer box for rectangles, squares, and rounded shapes
class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? color;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
      ),
    );
  }
}

/// Shimmer line for text placeholders
class ShimmerLine extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsetsGeometry? margin;

  const ShimmerLine({
    super.key,
    required this.width,
    this.height = 12,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width,
      height: height,
      margin: margin,
      borderRadius: BorderRadius.circular(6),
    );
  }
}

/// Shimmer circle for avatars and circular elements
class ShimmerCircle extends StatelessWidget {
  final double diameter;
  final EdgeInsetsGeometry? margin;

  const ShimmerCircle({super.key, required this.diameter, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: diameter,
      height: diameter,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Shimmer button placeholder
class ShimmerButton extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerButton({
    super.key,
    required this.width,
    this.height = 48,
    this.borderRadius,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      width: width,
      height: height,
      margin: margin,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
    );
  }
}

/// Loading state manager that handles shimmer display logic
class LoadingStateManager extends StatelessWidget {
  final bool isLoading;
  final Widget shimmerWidget;
  final Widget child;
  final Duration fadeDuration;

  const LoadingStateManager({
    super.key,
    required this.isLoading,
    required this.shimmerWidget,
    required this.child,
    this.fadeDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: fadeDuration,
      child: isLoading ? BaseShimmer(child: shimmerWidget) : child,
    );
  }
}
