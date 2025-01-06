import 'package:flutter/material.dart';

// Enum to define animation types
enum AnimationType {
  opacity,
  scale,
  combined,
}

class AnimationProvider extends ChangeNotifier {
  Duration _duration = const Duration(milliseconds: 300);
  Curve _curve = Curves.fastOutSlowIn;
  AnimationType _animationType = AnimationType.combined;

  Duration get duration => _duration;
  Curve get curve => _curve;
  AnimationType get animationType => _animationType;

  void setDuration(Duration duration) {
    _duration = duration;
    notifyListeners();
  }

  void setCurve(Curve curve) {
    _curve = curve;
    notifyListeners();
  }

  void setAnimationType(AnimationType animationType) {
    _animationType = animationType;
    notifyListeners();
  }
}
