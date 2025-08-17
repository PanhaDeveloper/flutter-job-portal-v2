import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SmoothLoadingWidget extends StatelessWidget {
  const SmoothLoadingWidget({
    super.key,
    this.size = 50,
    this.color,
    this.type = LoadingType.threeBounce,
  });

  final double size;
  final Color? color;
  final LoadingType type;

  @override
  Widget build(BuildContext context) {
    final loadingColor = color ?? Theme.of(context).primaryColor;

    Widget loadingWidget;

    switch (type) {
      case LoadingType.threeBounce:
        loadingWidget = LoadingAnimationWidget.threeArchedCircle(
          color: loadingColor,
          size: size,
        );
        break;
      case LoadingType.staggeredDotsWave:
        loadingWidget = LoadingAnimationWidget.staggeredDotsWave(
          color: loadingColor,
          size: size,
        );
        break;
      case LoadingType.waveDots:
        loadingWidget = LoadingAnimationWidget.waveDots(
          color: loadingColor,
          size: size,
        );
        break;
      case LoadingType.inkDrop:
        loadingWidget = LoadingAnimationWidget.inkDrop(
          color: loadingColor,
          size: size,
        );
        break;
      case LoadingType.twistingDots:
        loadingWidget = LoadingAnimationWidget.twistingDots(
          leftDotColor: loadingColor,
          rightDotColor: loadingColor.withOpacity(0.6),
          size: size,
        );
        break;
      case LoadingType.progressiveDots:
        loadingWidget = LoadingAnimationWidget.progressiveDots(
          color: loadingColor,
          size: size,
        );
        break;
    }

    return RepaintBoundary(child: Center(child: loadingWidget));
  }
}

enum LoadingType {
  threeBounce,
  staggeredDotsWave,
  waveDots,
  inkDrop,
  twistingDots,
  progressiveDots,
}

class SmoothLoadingOverlay extends StatelessWidget {
  const SmoothLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingWidget,
    this.backgroundColor,
    this.opacity = 0.8,
  });

  final bool isLoading;
  final Widget child;
  final Widget? loadingWidget;
  final Color? backgroundColor;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 200),
            child: Container(
              color: backgroundColor ?? Colors.black.withOpacity(0.3),
              child: loadingWidget ?? const SmoothLoadingWidget(),
            ),
          ),
      ],
    );
  }
}

class SmoothShimmerLoading extends StatefulWidget {
  const SmoothShimmerLoading({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.period = const Duration(milliseconds: 1500),
  });

  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration period;

  @override
  State<SmoothShimmerLoading> createState() => _SmoothShimmerLoadingState();
}

class _SmoothShimmerLoadingState extends State<SmoothShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.period,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.baseColor ?? Colors.grey[300]!;
    final highlightColor = widget.highlightColor ?? Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [baseColor, highlightColor, baseColor],
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(_animation.value * 3.14159),
            ).createShader(bounds);
          },
          child: widget.child,
        );
      },
    );
  }
}

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 4.0,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SmoothShimmerLoading(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
