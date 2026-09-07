import 'package:flutter/material.dart';

import '../theme/fb_theme.dart';

/// Photo placeholder — a hue-keyed gradient behind a diagonal stripe pattern.
///
/// Stands in for trainer photography until real images are served. It matches
/// the design's placeholder treatment, so nothing looks unfinished while the
/// image pipeline is still mock.
class FBPhoto extends StatelessWidget {
  const FBPhoto({
    super.key,
    required this.hue,
    this.height = 200,
    this.width,
    this.radius = FBRadius.cardLg,
    this.caption,
  });

  final double hue;
  final double height;
  final double? width;
  final double radius;

  /// Small monospace caption in the corner, as in the mockups.
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    FBColors.oklch(0.55, 0.12, hue),
                    FBColors.oklch(0.35, 0.14, hue + 25),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.18,
              child: CustomPaint(painter: const _DiagonalStripes()),
            ),
            if (caption != null)
              Positioned(
                left: 10,
                bottom: 8,
                child: Text(
                  caption!,
                  style: FBText.mono.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DiagonalStripes extends CustomPainter {
  const _DiagonalStripes();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;

    // 14px spacing at 35°, matching the SVG pattern in the design.
    const spacing = 14.0;
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(35 * 3.1415926535 / 180);
    final reach = size.width + size.height;
    for (var x = -reach; x < reach; x += spacing) {
      canvas.drawLine(Offset(x, -reach), Offset(x, reach), paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_DiagonalStripes oldDelegate) => false;
}
