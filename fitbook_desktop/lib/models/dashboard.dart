/// A headline metric tile.
class KpiMetric {
  const KpiMetric({
    required this.label,
    required this.value,
    required this.delta,
    required this.tintHue,
    this.trendUp,
  });

  final String label;
  final String value;

  /// Change caption, e.g. "+12.4%" or "2 pending".
  final String delta;

  /// OKLCH hue for the tile's accent square.
  final double tintHue;

  /// Null when the delta is informational rather than directional.
  final bool? trendUp;
}

/// A compact single-figure tile used on list screens.
class MiniKpi {
  const MiniKpi({required this.label, required this.value, this.tintKey});

  final String label;
  final String value;

  /// Semantic tint name: 'green', 'amber', 'red', 'blue' or null for neutral.
  final String? tintKey;
}

/// The bookings-over-time chart.
class BookingsChart {
  const BookingsChart({
    required this.title,
    required this.subtitle,
    required this.labels,
    required this.values,
    required this.maxValue,
    required this.ranges,
    required this.selectedRange,
    required this.highlightIndex,
    required this.highlightCaption,
  });

  final String title;
  final String subtitle;
  final List<String> labels;
  final List<int> values;

  /// Top of the y axis, so the axis is stable as data changes.
  final int maxValue;

  final List<String> ranges;
  final String selectedRange;

  /// Index of the point that carries the callout.
  final int highlightIndex;

  final String highlightCaption;
}

/// A row in the "top trainers this week" leaderboard.
class TrainerRanking {
  const TrainerRanking({
    required this.name,
    required this.speciality,
    required this.sessions,
    required this.identityHue,
  });

  final String name;
  final String speciality;
  final int sessions;
  final double identityHue;
}

/// The whole dashboard payload.
class AdminDashboard {
  const AdminDashboard({
    required this.subtitle,
    required this.searchHint,
    required this.searchShortcut,
    required this.primaryAction,
    required this.kpis,
    required this.chart,
    required this.rankingTitle,
    required this.rankings,
  });

  final String subtitle;
  final String searchHint;

  /// Keyboard hint shown in the search field's trailing keycap.
  final String searchShortcut;

  final String primaryAction;
  final List<KpiMetric> kpis;
  final BookingsChart chart;
  final String rankingTitle;
  final List<TrainerRanking> rankings;
}
