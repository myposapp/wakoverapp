import 'package:flutter/material.dart';

class ShimmerCardLoader extends StatefulWidget {
  final double width;
  final double imageHeight;
  final Color baseColor;
  final Color highlightColor;

  const ShimmerCardLoader({
    super.key,
    this.width = 300,
    this.imageHeight = 180,
    this.baseColor = const Color(0xFF2A2A2E),
    this.highlightColor = const Color(0xFF45454B),
  });

  @override
  State<ShimmerCardLoader> createState() => _ShimmerCardLoaderState();
}

class _ShimmerCardLoaderState extends State<ShimmerCardLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.baseColor,
                  widget.highlightColor,
                  widget.baseColor,
                ],
                stops: const [0.1, 0.5, 0.9],
                transform: _SlidingGradientTransform(
                  slidePercent: _controller.value,
                ),
              ).createShader(bounds);
            },
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Large Rounded Box
            Container(
              height: widget.imageHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.baseColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(height: 12),

            // Middle Line Placeholder (longer)
            Container(
              height: 18,
              width: widget.width * 0.65,
              decoration: BoxDecoration(
                color: widget.baseColor,
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            const SizedBox(height: 8),

            // Bottom Line Placeholder (shorter)
            Container(
              height: 18,
              width: widget.width * 0.35,
              decoration: BoxDecoration(
                color: widget.baseColor,
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom gradient transform to animate across the full bounds smoothly
class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent * 2 - 1),
      0.0,
      0.0,
    );
  }
}
