import 'package:flutter/material.dart';

import '../models/dashboard.dart';
import '../theme/fb_theme.dart';
import 'fb_surfaces.dart';

/// The dashboard's large metric tile.
class KpiCard extends StatelessWidget {
  const KpiCard({super.key, required this.metric});

  final KpiMetric metric;

  Color get _deltaColor => switch (metric.trendUp) {
    true => FBColors.green,
    false => FBColors.red,
    null => FBColors.textMid,
  };

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: const EdgeInsets.all(18),
      radius: FBRadius.card,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metric.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FBText.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: FBColors.textMid,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    metric.value,
                    style: FBText.h2.copyWith(fontSize: 26),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (metric.trendUp != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Text(
                          metric.trendUp! ? '▲' : '▼',
                          style: FBText.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: _deltaColor,
                          ),
                        ),
                      ),
                    Expanded(
                      child: Text(
                        metric.delta,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FBText.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: _deltaColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FBColors.tintSoft(metric.tintHue),
              borderRadius: FBRadius.all(FBRadius.control),
            ),
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: FBColors.tintStrong(metric.tintHue),
                borderRadius: FBRadius.all(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The compact single-figure tile used on list screens.
class MiniKpiCard extends StatelessWidget {
  const MiniKpiCard({super.key, required this.metric});

  final MiniKpi metric;

  /// Resolves the semantic tint name the mock data carries.
  static Color tintFor(String? key) => switch (key) {
    'green' => FBColors.green,
    'amber' => FBColors.amber,
    'red' => FBColors.red,
    'blue' => FBColors.blue,
    _ => FBColors.text,
  };

  @override
  Widget build(BuildContext context) {
    return FBCard(
      radius: FBRadius.button,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            metric.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FBText.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: FBColors.textMid,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              metric.value,
              style: FBText.h2.copyWith(
                fontSize: 22,
                color: tintFor(metric.tintKey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
