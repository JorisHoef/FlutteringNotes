import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/animation_provider.dart';

class CustomAnimatedWidget extends StatelessWidget {
  final bool hovering;
  final Widget child;

  const CustomAnimatedWidget({
    super.key,
    required this.hovering,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final animationProvider = context.watch<AnimationProvider>();

    final animationType = animationProvider.animationType;
    final duration = animationProvider.duration;
    final curve = animationProvider.curve;

    switch (animationType) {
      case AnimationType.opacity:
        return AnimatedOpacity(
          duration: duration,
          curve: curve,
          opacity: hovering ? 1.0 : 0.0,
          child: child,
        );

      case AnimationType.scale:
        return AnimatedScale(
          duration: duration,
          curve: curve,
          scale: hovering ? 1.0 : 0.0,
          child: child,
        );

      case AnimationType.combined:
        return AnimatedOpacity(
          duration: duration,
          curve: curve,
          opacity: hovering ? 1.0 : 0.0,
          child: AnimatedScale(
            duration: duration,
            curve: curve,
            scale: hovering ? 1.0 : 0.0,
            child: child,
          ),
        );

      default:
        return child; // Fallback if no animation type is configured
    }
  }
}
