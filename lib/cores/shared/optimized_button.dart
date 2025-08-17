import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SmoothAnimations {
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Curve smoothCurve = Curves.easeInOutCubic;
}

class OptimizedButton extends StatefulWidget {
  const OptimizedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.elevation = 2.0,
    this.borderRadius,
    this.padding,
    this.minimumSize,
    this.maximumSize,
    this.border,
    this.isLoading = false,
    this.enabled = true,
    this.hapticFeedback = true,
    this.animationDuration = SmoothAnimations.shortAnimation,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final double elevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final Size? maximumSize;
  final BorderSide? border;
  final bool isLoading;
  final bool enabled;
  final bool hapticFeedback;
  final Duration animationDuration;

  @override
  State<OptimizedButton> createState() => _OptimizedButtonState();
}

class _OptimizedButtonState extends State<OptimizedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.enabled && !widget.isLoading) {
      setState(() {
        _isPressed = true;
      });
      _animationController.forward();
      if (widget.hapticFeedback) {
        HapticFeedback.lightImpact();
      }
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _resetPressState();
  }

  void _handleTapCancel() {
    _resetPressState();
  }

  void _resetPressState() {
    if (_isPressed) {
      setState(() {
        _isPressed = false;
      });
      _animationController.reverse();
    }
  }

  void _handleTap() {
    if (widget.enabled && !widget.isLoading && widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = widget.enabled && !widget.isLoading;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: _handleTapDown,
              onTapUp: _handleTapUp,
              onTapCancel: _handleTapCancel,
              onTap: _handleTap,
              child: AnimatedContainer(
                duration: widget.animationDuration,
                curve: SmoothAnimations.smoothCurve,
                decoration: BoxDecoration(
                  color:
                      isEnabled
                          ? (widget.backgroundColor ?? theme.primaryColor)
                          : (widget.disabledBackgroundColor ??
                              theme.disabledColor),
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                  border:
                      widget.border != null
                          ? Border.all(
                            color: widget.border!.color,
                            width: widget.border!.width,
                          )
                          : null,
                  boxShadow:
                      isEnabled
                          ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: widget.elevation,
                              offset: Offset(0, widget.elevation / 2),
                            ),
                          ]
                          : null,
                ),
                padding:
                    widget.padding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                constraints: BoxConstraints(
                  minWidth: widget.minimumSize?.width ?? 0,
                  minHeight: widget.minimumSize?.height ?? 0,
                  maxWidth: widget.maximumSize?.width ?? double.infinity,
                  maxHeight: widget.maximumSize?.height ?? double.infinity,
                ),
                child: AnimatedSwitcher(
                  duration: widget.animationDuration,
                  child:
                      widget.isLoading
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                widget.foregroundColor ?? Colors.white,
                              ),
                            ),
                          )
                          : DefaultTextStyle(
                            style: TextStyle(
                              color:
                                  isEnabled
                                      ? (widget.foregroundColor ?? Colors.white)
                                      : (widget.disabledForegroundColor ??
                                          theme.disabledColor),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            child: widget.child,
                          ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OptimizedIconButton extends StatefulWidget {
  const OptimizedIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = 24.0,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.padding = const EdgeInsets.all(8.0),
    this.enabled = true,
    this.hapticFeedback = true,
  });

  final VoidCallback? onPressed;
  final IconData icon;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final bool enabled;
  final bool hapticFeedback;

  @override
  State<OptimizedIconButton> createState() => _OptimizedIconButtonState();
}

class _OptimizedIconButtonState extends State<OptimizedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.enabled && widget.onPressed != null) {
      if (widget.hapticFeedback) {
        HapticFeedback.lightImpact();
      }
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: _handleTap,
              child: Container(
                padding: widget.padding,
                decoration:
                    widget.backgroundColor != null
                        ? BoxDecoration(
                          color: widget.backgroundColor,
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                        )
                        : null,
                child: Icon(
                  widget.icon,
                  size: widget.size,
                  color:
                      widget.enabled
                          ? (widget.color ?? theme.iconTheme.color)
                          : theme.disabledColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OptimizedFloatingActionButton extends StatefulWidget {
  const OptimizedFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 6.0,
    this.mini = false,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final bool mini;
  final bool enabled;

  @override
  State<OptimizedFloatingActionButton> createState() =>
      _OptimizedFloatingActionButtonState();
}

class _OptimizedFloatingActionButtonState
    extends State<OptimizedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.enabled && widget.onPressed != null) {
      HapticFeedback.lightImpact();
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = widget.mini ? 40.0 : 56.0;

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTap: _handleTap,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color:
                      widget.enabled
                          ? (widget.backgroundColor ?? theme.primaryColor)
                          : theme.disabledColor,
                  shape: BoxShape.circle,
                  boxShadow:
                      widget.enabled
                          ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: widget.elevation,
                              offset: Offset(0, widget.elevation / 2),
                            ),
                          ]
                          : null,
                ),
                child: Center(
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: widget.foregroundColor ?? Colors.white,
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
