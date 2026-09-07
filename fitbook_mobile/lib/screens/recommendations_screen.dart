import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.7b · "For you" — trainer recommendations from the ML.NET recommender.
///
/// This is the project's ML surface. Every pick shows the signals it scored
/// against and the weight of each reason, so a recommendation can always be
/// interrogated rather than taken on trust.
class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final feed = Mockup.recommendations;

    return FBScreen(
      title: MockChrome.recommendationsTitle,
      subtitle: feed.freshnessLabel,
      onBack: onBack,
      headerPadding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      actions: const [FBIconButton(icon: FBIcons.refresh, iconSize: 16)],
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        children: [
          _ContextCard(context: feed.context),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  MockRecommendations.topMatchHeading,
                  style: FBText.titleSm,
                ),
              ),
              Text(
                feed.rankedCountLabel,
                style: FBText.caption.copyWith(color: FBColors.textDim),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _TopMatchCard(match: feed.top),
          const SizedBox(height: 18),
          Text(
            MockRecommendations.othersHeading,
            style: FBText.bodyStrong.copyWith(letterSpacing: -0.2),
          ),
          const SizedBox(height: 10),
          for (final other in feed.others)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _SecondaryMatchCard(match: other),
            ),
          const SizedBox(height: 4),
          const _RefinePreferencesRow(),
        ],
      ),
    );
  }
}

class _ContextCard extends StatelessWidget {
  const _ContextCard({required this.context});

  final RecommendationContext context;

  @override
  Widget build(BuildContext buildContext) {
    return FBNavyPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: FBRadius.all(9),
                ),
                child: const Icon(
                  FBIcons.sparkles,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.modelLabel,
                      style: FBText.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      context.summary,
                      style: FBText.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // The signals the model actually scored against — SearchHistory,
          // goals, budget and location all show up here.
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final s in context.signals)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: FBRadius.all(FBRadius.pill),
                  ),
                  child: Text(
                    s,
                    style: FBText.micro.copyWith(color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopMatchCard extends StatelessWidget {
  const _TopMatchCard({required this.match});

  final TopRecommendation match;

  @override
  Widget build(BuildContext context) {
    final t = match.trainer;
    final maxWeight = match.reasons.first.weight;

    return FBCard(
      radius: FBRadius.cardLg,
      shadow: FBShadow.md,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  FBAvatar(name: t.name, hue: t.identityHue, size: 56),
                  Positioned(
                    bottom: -4,
                    right: -4,
                    child: FBAvatarScore(
                      score: match.score,
                      color: FBColors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.name, style: FBText.titleSm.copyWith(fontSize: 15)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: [
                        for (final s in t.specialities) FBTag(label: s),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          FBIcons.star,
                          size: 11,
                          color: FBColors.amber,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '${t.rating} (${t.reviewCount})',
                          style: FBText.caption.copyWith(
                            color: FBColors.textMid,
                          ),
                        ),
                        Text(
                          '  ·  ',
                          style: FBText.caption.copyWith(
                            color: FBColors.textMid,
                          ),
                        ),
                        Text(
                          MockChrome.hourlyRate(t.hourlyRate),
                          style: FBText.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: FBColors.text,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const _RankBadge(),
            ],
          ),
          const SizedBox(height: 14),
          _ScorePanel(score: match.score),
          const SizedBox(height: 14),
          FBSectionLabel(
            MockRecommendations.reasonsHeading,
            padding: const EdgeInsets.only(bottom: 10),
            fontSize: 11,
          ),
          for (var i = 0; i < match.reasons.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            _ReasonRow(reason: match.reasons[i], maxWeight: maxWeight),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              // 1 : 1.4 split, matching the design's emphasis on booking
              // without squeezing the secondary label.
              const Expanded(
                flex: 10,
                child: FBButton(
                  label: MockChrome.viewProfileLabel,
                  kind: FBButtonKind.outline,
                  height: 42,
                  fontSize: 13,
                  radius: FBRadius.button,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                flex: 14,
                child: FBButton(
                  label: MockChrome.bookSessionLabel,
                  height: 42,
                  fontSize: 13,
                  radius: FBRadius.button,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          // Explicit feedback becomes a training signal for the recommender.
          Row(
            children: [
              Expanded(
                child: Text(
                  MockRecommendations.feedbackPrompt,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ),
              const FBIconButton(
                icon: FBIcons.thumbUp,
                size: 28,
                iconSize: 13,
                iconColor: FBColors.green,
              ),
              const SizedBox(width: 8),
              const FBIconButton(
                icon: FBIcons.thumbDown,
                size: 28,
                iconSize: 13,
                iconColor: FBColors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: FBColors.navy,
        borderRadius: FBRadius.all(FBRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: FBColors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            MockChrome.rankBadge,
            style: FBText.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScorePanel extends StatelessWidget {
  const _ScorePanel({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: FBColors.greenBg,
        borderRadius: FBRadius.all(FBRadius.control),
        border: Border.all(color: FBColors.green.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  MockChrome.matchScoreLabel,
                  style: FBText.caption.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                    color: FBColors.green,
                  ),
                ),
              ),
              Text(
                '$score',
                style: FBText.h3.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: FBColors.green,
                ),
              ),
              Text(
                MockChrome.matchScoreDenominator,
                style: FBText.micro.copyWith(
                  color: FBColors.green.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FBMeter(
            fraction: score / 100,
            color: FBColors.green,
            track: FBColors.green.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  const _ReasonRow({required this.reason, required this.maxWeight});

  final RecommendationReason reason;

  /// Weight of the strongest reason, so the bars are relative to the top
  /// feature rather than to an arbitrary 100%.
  final double maxWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: FBColors.blueLight,
            borderRadius: FBRadius.all(7),
          ),
          child: const Icon(FBIcons.check, size: 13, color: FBColors.blue),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      reason.label,
                      style: FBText.label.copyWith(
                        color: FBColors.text,
                        height: 1.35,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${(reason.weight * 100).round()}%',
                    style: FBText.mono.copyWith(
                      fontWeight: FontWeight.w700,
                      color: FBColors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                reason.detail,
                style: FBText.caption.copyWith(color: FBColors.textDim),
              ),
              const SizedBox(height: 5),
              FBMeter(
                fraction: reason.weight / maxWeight,
                color: FBColors.blue,
                height: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SecondaryMatchCard extends StatelessWidget {
  const _SecondaryMatchCard({required this.match});

  final SecondaryRecommendation match;

  @override
  Widget build(BuildContext context) {
    final t = match.trainer;
    return FBCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              FBAvatar(name: t.name, hue: t.identityHue, size: 48),
              Positioned(
                bottom: -3,
                right: -3,
                child: FBAvatarScore(
                  score: match.score,
                  color: FBColors.blue,
                  diameter: 20,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(t.name, style: FBText.bodyStrong)),
                    const SizedBox(width: 8),
                    Text(
                      MockChrome.amountLabel(t.hourlyRate),
                      style: FBText.label.copyWith(
                        fontWeight: FontWeight.w700,
                        color: FBColors.navy,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(FBIcons.star, size: 11, color: FBColors.amber),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '${t.rating} · ${t.specialities.join(' · ')}',
                        style: FBText.caption.copyWith(color: FBColors.textMid),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FBNotice(
                  background: FBColors.blueLight,
                  icon: FBIcons.sparkles,
                  iconColor: FBColors.blue,
                  radius: FBRadius.chip,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Text(
                    match.headlineReason,
                    style: FBText.caption.copyWith(
                      color: FBColors.navy,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (final tag in match.tags)
                      FBTag(
                        label: tag,
                        background: FBColors.card,
                        foreground: FBColors.textMid,
                        border: FBColors.cardBorder,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RefinePreferencesRow extends StatelessWidget {
  const _RefinePreferencesRow();

  @override
  Widget build(BuildContext context) {
    return FBCard(
      background: FBColors.card,
      shadow: null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: FBRadius.all(FBRadius.control),
              border: Border.all(color: FBColors.cardBorder),
            ),
            child: const Icon(FBIcons.filter, size: 16, color: FBColors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(MockRecommendations.refineTitle, style: FBText.bodyStrong),
                const SizedBox(height: 1),
                Text(
                  MockRecommendations.refineSubtitle,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ],
            ),
          ),
          const Icon(FBIcons.chevronRight, size: 16, color: FBColors.textMid),
        ],
      ),
    );
  }
}
