import '../models/recommendation.dart';
import 'mock_trainers.dart';

/// Recommender fixtures for the "For you" screen.
///
/// Every reason carries the weight that produced it — the recommender is
/// required to explain itself, so mock data must model that too.
abstract final class MockRecommendations {
  static final feed = RecommendationFeed(
    freshnessLabel: 'Personalized · updated 12 min ago',
    rankedCountLabel: '3 picks ranked',
    context: const RecommendationContext(
      modelLabel: 'BUILT FOR YOU · ML.NET',
      summary: 'Based on your goals & history',
      signals: [
        'Weight loss',
        '3×/week',
        'Beginner',
        'Sarajevo · Centar',
        '< 45 KM/h',
      ],
    ),
    top: TopRecommendation(
      trainer: MockTrainers.all[1],
      score: 94,
      reasons: const [
        RecommendationReason(
          weight: 0.42,
          label: 'Matches your goal: Weight loss',
          detail: '92% of similar clients hit −4kg in 8 weeks',
        ),
        RecommendationReason(
          weight: 0.28,
          label: 'Schedule fits your evening availability',
          detail: 'Mon/Wed/Fri 17–20h overlap',
        ),
        RecommendationReason(
          weight: 0.18,
          label: 'Within budget · 45 KM/h',
          detail: 'Below your 45 KM ceiling',
        ),
        RecommendationReason(
          weight: 0.12,
          label: '1.2 km from your home',
          detail: 'Olympic Gym · Marijin Dvor',
        ),
      ],
    ),
    others: [
      SecondaryRecommendation(
        trainer: MockTrainers.all[5],
        score: 87,
        headlineReason:
            'Sustainable cardio + outdoor sessions match your prefs',
        tags: const ['Affordable', 'Outdoor', 'Beginner-friendly'],
      ),
      SecondaryRecommendation(
        trainer: MockTrainers.all[3],
        score: 79,
        headlineReason:
            'Top boxing trainer near you — boosts cardio + strength',
        tags: const ['High calorie burn', 'Trending'],
      ),
    ],
  );

  static const reasonsHeading = 'WHY WE THINK YOU\'LL MATCH';
  static const feedbackPrompt = 'Is this a good match?';
  static const refineTitle = 'Refine your preferences';
  static const refineSubtitle = 'Goals, budget, schedule';
  static const topMatchHeading = 'Top match';
  static const othersHeading = 'Also recommended';
}
