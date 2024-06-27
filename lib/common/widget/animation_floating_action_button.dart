import 'package:flutter/material.dart';

class AnimationFloatingActionButton extends StatefulWidget {
  const AnimationFloatingActionButton({
    super.key,
    required this.onPressed,
    this.size = const Size(70.0, 70.0),
  });

  final VoidCallback onPressed;
  final Size size;

  @override
  State<AnimationFloatingActionButton> createState() =>
      _AnimationFloatingActionButtonState();
}

class _AnimationFloatingActionButtonState
    extends State<AnimationFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reset();
          _animationController.forward();
        }
      });
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: (widget.size.width - 20) + _animation.value * 20,
                height: (widget.size.height - 20) + _animation.value * 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent.withOpacity(1 - _animation.value),
                ),
              );
            },
          ),
          InkWell(
            onTap: widget.onPressed,
            borderRadius: BorderRadius.circular(999),
            child: Ink(
              width: (widget.size.width - 20),
              height: (widget.size.height - 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // color: Colors.blueAccent,
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
