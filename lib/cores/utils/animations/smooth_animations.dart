import 'package:flutter/material.dart';

class SmoothAnimations {
  // Smooth page transitions
  static const Duration pageTransition = Duration(milliseconds: 250);
  static const Duration fastTransition = Duration(milliseconds: 150);
  static const Duration slowTransition = Duration(milliseconds: 400);

  // Smooth curves
  static const Curve smoothCurve = Curves.easeInOutCubic;
  static const Curve fastCurve = Curves.easeOut;
  static const Curve bounceCurve = Curves.elasticOut;

  // Common animation durations
  static const Duration microAnimation = Duration(milliseconds: 100);
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}

class SmoothFadeTransition extends StatelessWidget {
  const SmoothFadeTransition({
    super.key,
    required this.child,
    this.duration = SmoothAnimations.shortAnimation,
    this.curve = SmoothAnimations.smoothCurve,
    this.opacity = 1.0,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: 0.0, end: opacity),
      builder: (context, value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: child,
    );
  }
}

class SmoothSlideTransition extends StatelessWidget {
  const SmoothSlideTransition({
    super.key,
    required this.child,
    this.duration = SmoothAnimations.mediumAnimation,
    this.curve = SmoothAnimations.smoothCurve,
    this.offset = const Offset(0, 0.1),
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: offset, end: Offset.zero),
      builder: (context, value, child) {
        return Transform.translate(offset: value * 100, child: child);
      },
      child: child,
    );
  }
}

class SmoothScaleTransition extends StatelessWidget {
  const SmoothScaleTransition({
    super.key,
    required this.child,
    this.duration = SmoothAnimations.shortAnimation,
    this.curve = SmoothAnimations.smoothCurve,
    this.initialScale = 0.8,
    this.finalScale = 1.0,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final double initialScale;
  final double finalScale;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: initialScale, end: finalScale),
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: child,
    );
  }
}

class SmoothListItemAnimation extends StatelessWidget {
  const SmoothListItemAnimation({
    super.key,
    required this.child,
    required this.index,
    this.duration = SmoothAnimations.mediumAnimation,
    this.curve = SmoothAnimations.smoothCurve,
    this.delay = const Duration(milliseconds: 50),
  });

  final Widget child;
  final int index;
  final Duration duration;
  final Curve curve;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final itemDelay = Duration(milliseconds: delay.inMilliseconds * index);

    return TweenAnimationBuilder<double>(
      duration: duration + itemDelay,
      curve: curve,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (1 - value) * 50),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }
}

class SmoothRotationTransition extends StatelessWidget {
  const SmoothRotationTransition({
    super.key,
    required this.child,
    this.duration = SmoothAnimations.mediumAnimation,
    this.curve = SmoothAnimations.smoothCurve,
    this.turns = 0.25,
  });

  final Widget child;
  final Duration duration;
  final Curve curve;
  final double turns;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: curve,
      tween: Tween(begin: turns, end: 0.0),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value * 6.28318, // 2 * pi
          child: child,
        );
      },
      child: child,
    );
  }
}

class SmoothPageTransition extends PageTransitionsBuilder {
  const SmoothPageTransition();

  @override
  Widget buildTransitions<T extends Object?>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: SmoothAnimations.smoothCurve),
      ),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

class SmoothFadePageTransition extends PageTransitionsBuilder {
  const SmoothFadePageTransition();

  @override
  Widget buildTransitions<T extends Object?>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: SmoothAnimations.smoothCurve,
      ),
      child: child,
    );
  }
}

class SmoothAnimatedContainer extends StatelessWidget {
  const SmoothAnimatedContainer({
    super.key,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.padding,
    this.margin,
    this.child,
    this.duration = SmoothAnimations.mediumAnimation,
    this.curve = SmoothAnimations.smoothCurve,
  });

  final double? width;
  final double? height;
  final Color? color;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      curve: curve,
      width: width,
      height: height,
      color: color,
      decoration: decoration,
      padding: padding,
      margin: margin,
      child: child,
    );
  }
}

extension SmoothAnimationExtensions on Widget {
  Widget smoothFadeIn({
    Duration duration = SmoothAnimations.shortAnimation,
    Curve curve = SmoothAnimations.smoothCurve,
  }) {
    return SmoothFadeTransition(duration: duration, curve: curve, child: this);
  }

  Widget smoothSlideIn({
    Duration duration = SmoothAnimations.mediumAnimation,
    Curve curve = SmoothAnimations.smoothCurve,
    Offset offset = const Offset(0, 0.1),
  }) {
    return SmoothSlideTransition(
      duration: duration,
      curve: curve,
      offset: offset,
      child: this,
    );
  }

  Widget smoothScale({
    Duration duration = SmoothAnimations.shortAnimation,
    Curve curve = SmoothAnimations.smoothCurve,
    double initialScale = 0.8,
  }) {
    return SmoothScaleTransition(
      duration: duration,
      curve: curve,
      initialScale: initialScale,
      child: this,
    );
  }
}
