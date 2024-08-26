// // Create your Animation Example
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// import 'package:simple_animations/simple_animations.dart';
// enum AniProps { opacity, translateY }

// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;

//   FadeAnimation(this.delay, this.child);

//   @override
//   Widget build(BuildContext context) {
//     // final tween = MovieTween<AniProps>()
//     final tween = MultiTween<AniProps>()
//         ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
//         ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0), Duration(milliseconds: 500), Curves.easeOut);

//     return PlayAnimationBuilder<MultiTweenValues<AniProps>>(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builder: (context, child, animation) => Opacity(
//         opacity: animation.get(AniProps.opacity),
//         child: Transform.translate(
//             offset: Offset(0, animation.get(AniProps.translateY)),
//             child: child
//         ),
//       ),
//     );
//   }
// }
class FadeAnimation extends StatelessWidget {
  final Widget child;
  final int delay;

  FadeAnimation(this.delay, {required this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
            delay: Duration(
              milliseconds: 200,
            ),
            curve: Curves.easeIn),
        SlideEffect()
      ],
      child: child,
    );
  }
}
