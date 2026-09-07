import 'trainer.dart';

/// One weighted reason behind a recommendation.
///
/// The recommender is required to be explainable, so every reason carries the
/// feature weight that produced it alongside human-readable copy.
class RecommendationReason {
  const RecommendationReason({
    required this.weight,
    required this.label,
    required this.detail,
  });

  /// Contribution of this feature to the match score, 0..1.
  final double weight;

  final String label;
  final String detail;
}

/// The top-ranked recommendation, shown as a hero card with its full reasoning.
class TopRecommendation {
  const TopRecommendation({
    required this.trainer,
    required this.score,
    required this.reasons,
  });

  final Trainer trainer;

  /// Match score out of 100.
  final int score;

  final List<RecommendationReason> reasons;
}

/// A secondary recommendation, shown compactly with one headline reason.
class SecondaryRecommendation {
  const SecondaryRecommendation({
    required this.trainer,
    required this.score,
    required this.headlineReason,
    required this.tags,
  });

  final Trainer trainer;
  final int score;
  final String headlineReason;
  final List<String> tags;
}

/// The signals the model scored against, surfaced so the user can see what the
/// recommendation was actually based on.
class RecommendationContext {
  const RecommendationContext({
    required this.modelLabel,
    required this.summary,
    required this.signals,
  });

  final String modelLabel;
  final String summary;
  final List<String> signals;
}

/// The whole "For you" payload.
class RecommendationFeed {
  const RecommendationFeed({
    required this.freshnessLabel,
    required this.rankedCountLabel,
    required this.context,
    required this.top,
    required this.others,
  });

  final String freshnessLabel;
  final String rankedCountLabel;
  final RecommendationContext context;
  final TopRecommendation top;
  final List<SecondaryRecommendation> others;
}
