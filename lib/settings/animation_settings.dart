import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/animation_provider.dart';

class AnimationSettings extends StatelessWidget {
  const AnimationSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final animationProvider = context.watch<AnimationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Animation Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Select Animation Type:'),
          ListTile(
            title: const Text('Opacity Animation'),
            leading: Radio<AnimationType>(
              value: AnimationType.opacity,
              groupValue: animationProvider.animationType,
              onChanged: (value) {
                animationProvider.setAnimationType(value!);
              },
            ),
          ),
          ListTile(
            title: const Text('Scale Animation'),
            leading: Radio<AnimationType>(
              value: AnimationType.scale,
              groupValue: animationProvider.animationType,
              onChanged: (value) {
                animationProvider.setAnimationType(value!);
              },
            ),
          ),
          ListTile(
            title: const Text('Combined Animation (Opacity + Scale)'),
            leading: Radio<AnimationType>(
              value: AnimationType.combined,
              groupValue: animationProvider.animationType,
              onChanged: (value) {
                animationProvider.setAnimationType(value!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
