import 'package:flutter/material.dart';
import 'image_carousel.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();

  const LoadingScreen({super.key});
}

/* SingleTickerProviderStateMixin allows this widget to act as a "ticker provider," which means it can create an
animation controller. The "ticker" controls the timing of the animation.

_controller: Controls the timing of the animations.
_positionAnimation: Animates the vertical position of the circle.
_scaleAnimation: Animates the size (scale) of the circle.*/

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _positionAnimation =
        Tween<double>(begin: -500, end: 0)
            .animate(
          CurvedAnimation(parent: _controller,
              curve: const Interval(0, 0.5, curve: Curves.bounceOut)),
        );

    _scaleAnimation =
        Tween<double>(begin: 1, end: 10).animate(
          CurvedAnimation(parent: _controller,
              curve: const Interval(0.5, 1, curve: Curves.easeOutQuad)),
        );

    // Opacity animation to fade in the image after the circle expands
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn), // Fades in at the end
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            double screenHeight = constraints
                .maxHeight;
            double screenWidth = constraints
                .maxWidth;

            return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  // Print the current time (controller.value) and scale value
                  // double currentTime = _controller.value * _controller.duration!.inSeconds;
                  // double scaleValue = _scaleAnimation.value;
                  // double position = _positionAnimation.value;
                  // print("Time: ${currentTime.toStringAsFixed(2)}s, Scale value: $scaleValue, Position: $position");
                  return Stack(
                    children: [
                      // Position the circle in the center with animated scaling
                      Positioned(
                        top: screenHeight / 2 +
                            _positionAnimation
                                .value,
                        left: screenWidth / 2 -
                            (50 * _scaleAnimation.value),
                        child: Transform.scale(
                          scale: _scaleAnimation
                              .value,
                          child: Container(
                            width: 100 * _scaleAnimation.value,
                            height: 100 * _scaleAnimation.value,
                            decoration: const BoxDecoration(
                              // color: Colors.blue,

                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [
                                  0.1,
                                  0.2,
                                  0.4,
                                  0.6,
                                  0.8,
                                  0.9,
                                ],
                                colors: [
                                  Color(0xFF007A8F), // Opaque teal
                                  Color(0xFF00A6C7), // Opaque cyan
                                  Color(0xFF00D1FF), // Opaque light blue
                                  Color(0xFF73E8D9), // Opaque aqua
                                  Color(0xFFADF4C5), // Opaque light green
                                  Color(0xFFE6FFB2), // Opaque pale yellow-green
                                ],
                              ),
                              shape: BoxShape
                                  .circle,
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Opacity(
                        opacity: _opacityAnimation.value,
                        child: ImageCarousel()
                      ),),
                    ],
                  );
                }
            );
          }
      ),);
  }
}
