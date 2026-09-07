import 'package:flutter/material.dart';

import '../models/dashboard.dart';
import '../theme/fb_theme.dart';
import 'fb_surfaces.dart';

/// The bookings-over-time area chart on the dashboard.
///
/// Hand-painted rather than pulled from a charting package: it is one series
/// with a fixed axis, and a custom painter keeps it exactly on the design's
/// grid, gradient and callout.
class BookingsChartCard extends StatelessWidget {
  const BookingsChartCard({super.key, required this.chart});

  final BookingsChart chart;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chart.title, style: FBText.titleSm),
                    const SizedBox(height: 2),
                    Text(
                      chart.subtitle,
                      style: FBText.caption.copyWith(color: FBColors.textDim),
                    ),
                  ],
                ),
              ),
              for (final range in chart.ranges)
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: _RangeChip(
                    label: range,
                    isActive: range == chart.selectedRange,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) => CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _ChartPainter(chart: chart),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  const _RangeChip({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isActive ? FBColors.navy : Colors.white,
        borderRadius: FBRadius.all(FBRadius.chip),
        border: Border.all(
          color: isActive ? FBColors.navy : FBColors.cardBorder,
        ),
      ),
      child: Text(
        label,
        style: FBText.caption.copyWith(
          fontWeight: FontWeight.w600,
          color: isActive ? Colors.white : FBColors.textMid,
        ),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  const _ChartPainter({required this.chart});

  final BookingsChart chart;

  static const _padLeft = 40.0;
  static const _padRight = 12.0;
  static const _padTop = 14.0;
  static const _padBottom = 28.0;

  @override
  void paint(Canvas canvas, Size size) {
    final chartWidth = size.width - _padLeft - _padRight;
    final chartHeight = size.height - _padTop - _padBottom;
    if (chartWidth <= 0 || chartHeight <= 0) return;

    final points = <Offset>[];
    final lastIndex = chart.values.length - 1;
    for (var i = 0; i < chart.values.length; i++) {
      final x = _padLeft + (lastIndex == 0 ? 0 : i * chartWidth / lastIndex);
      final y =
          _padTop +
          chartHeight -
          (chart.values[i] / chart.maxValue) * chartHeight;
      points.add(Offset(x, y));
    }

    _paintGrid(canvas, size, chartHeight);
    _paintArea(canvas, points, chartHeight);
    _paintLine(canvas, points);
    _paintDots(canvas, points);
    _paintLabels(canvas, size, points);
    _paintCallout(canvas, points);
  }

  void _paintGrid(Canvas canvas, Size size, double chartHeight) {
    final gridPaint = Paint()
      ..color = FBColors.cardBorder
      ..strokeWidth = 1;

    for (final tick in const [0, 25, 50, 75, 100]) {
      final y = _padTop + chartHeight - (tick / chart.maxValue) * chartHeight;
      // Dashed horizontal rule.
      for (var x = _padLeft; x < size.width - _padRight; x += 6) {
        canvas.drawLine(Offset(x, y), Offset(x + 3, y), gridPaint);
      }
      // Painted text has no inherited DefaultTextStyle, so the family is
      // named explicitly rather than relying on the theme.
      _text(
        canvas,
        '$tick',
        Offset(_padLeft - 8, y),
        const TextStyle(
          fontFamily: 'Inter',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: FBColors.textDim,
        ),
        align: TextAlign.right,
        anchor: _Anchor.rightCenter,
      );
    }
  }

  void _paintArea(Canvas canvas, List<Offset> points, double chartHeight) {
    final baseline = _padTop + chartHeight;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    path
      ..lineTo(points.last.dx, baseline)
      ..lineTo(points.first.dx, baseline)
      ..close();

    canvas.drawPath(
      path,
      Paint()
        ..shader =
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                FBColors.blue.withValues(alpha: 0.22),
                FBColors.blue.withValues(alpha: 0),
              ],
            ).createShader(
              Rect.fromLTRB(points.first.dx, _padTop, points.last.dx, baseline),
            ),
    );
  }

  void _paintLine(Canvas canvas, List<Offset> points) {
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (final p in points.skip(1)) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = FBColors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  void _paintDots(Canvas canvas, List<Offset> points) {
    for (var i = 0; i < points.length; i++) {
      final isHighlight = i == chart.highlightIndex;
      canvas
        ..drawCircle(
          points[i],
          isHighlight ? 6 : 4,
          Paint()..color = Colors.white,
        )
        ..drawCircle(
          points[i],
          isHighlight ? 6 : 4,
          Paint()
            ..color = FBColors.blue
            ..style = PaintingStyle.stroke
            ..strokeWidth = isHighlight ? 3 : 2,
        );
    }
  }

  void _paintLabels(Canvas canvas, Size size, List<Offset> points) {
    for (var i = 0; i < chart.labels.length; i++) {
      final isHighlight = i == chart.highlightIndex;
      _text(
        canvas,
        chart.labels[i],
        Offset(points[i].dx, size.height - 14),
        TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w500,
          color: isHighlight ? FBColors.text : FBColors.textDim,
        ),
        anchor: _Anchor.topCenter,
      );
    }
  }

  void _paintCallout(Canvas canvas, List<Offset> points) {
    final anchor = points[chart.highlightIndex];
    const w = 88.0;
    const h = 38.0;
    final rect = Rect.fromLTWH(anchor.dx - w / 2, anchor.dy - h - 12, w, h);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(8)),
      Paint()..color = FBColors.navy,
    );
    _text(
      canvas,
      chart.highlightCaption,
      Offset(rect.center.dx, rect.top + 6),
      TextStyle(
        fontFamily: 'Inter',
        fontSize: 9,
        color: Colors.white.withValues(alpha: 0.7),
      ),
      anchor: _Anchor.topCenter,
    );
    _text(
      canvas,
      '${chart.values[chart.highlightIndex]} bookings',
      Offset(rect.center.dx, rect.top + 19),
      const TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      anchor: _Anchor.topCenter,
    );
  }

  void _text(
    Canvas canvas,
    String text,
    Offset at,
    TextStyle style, {
    TextAlign align = TextAlign.center,
    _Anchor anchor = _Anchor.topLeft,
  }) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textAlign: align,
      textDirection: TextDirection.ltr,
    )..layout();

    final offset = switch (anchor) {
      _Anchor.topLeft => at,
      _Anchor.topCenter => Offset(at.dx - painter.width / 2, at.dy),
      _Anchor.rightCenter => Offset(
        at.dx - painter.width,
        at.dy - painter.height / 2,
      ),
    };
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(_ChartPainter oldDelegate) => oldDelegate.chart != chart;
}

enum _Anchor { topLeft, topCenter, rightCenter }
