import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.3a · Trainer search — the client's home feed.
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onTrainerTap,
    this.onNotifications,
    this.onMembership,
  });

  final ValueChanged<Trainer>? onTrainerTap;
  final VoidCallback? onNotifications;
  final VoidCallback? onMembership;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _feed = Mockup.home;
  final _searchController = TextEditingController();

  late String _filter = _feed.specialityFilters.first;
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Trainer> get _visibleTrainers {
    final all = _feed.specialityFilters.first;
    return _feed.trainers.where((t) {
      final matchesFilter = _filter == all || t.specialities.contains(_filter);
      final matchesQuery =
          _query.isEmpty || t.name.toLowerCase().contains(_query.toLowerCase());
      return matchesFilter && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final trainers = _visibleTrainers;

    return Scaffold(
      backgroundColor: FBColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _Header(
              feed: _feed,
              controller: _searchController,
              onQueryChanged: (v) => setState(() => _query = v),
              onNotifications: widget.onNotifications,
            ),
            _FilterStrip(
              filters: _feed.specialityFilters,
              selected: _filter,
              onSelected: (f) => setState(() => _filter = f),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: _MembershipBannerCard(
                banner: _feed.banner,
                onTap: widget.onMembership,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(_feed.sectionTitle, style: FBText.titleMd),
                  ),
                  Text(
                    MockChrome.seeAllLabel,
                    style: FBText.label.copyWith(color: FBColors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: trainers.isEmpty
                  ? const _EmptyResults()
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            // Photo + overlapping avatar + two text rows.
                            mainAxisExtent: 216,
                          ),
                      itemCount: trainers.length,
                      itemBuilder: (context, i) => TrainerCard(
                        trainer: trainers[i],
                        onTap: () => widget.onTrainerTap?.call(trainers[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.feed,
    required this.controller,
    required this.onQueryChanged,
    this.onNotifications,
  });

  final HomeFeed feed;
  final TextEditingController controller;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback? onNotifications;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feed.greeting,
                      style: FBText.body.copyWith(color: FBColors.textDim),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      feed.brand,
                      style: FBText.h2.copyWith(color: FBColors.navy),
                    ),
                  ],
                ),
              ),
              FBIconButton(
                icon: FBIcons.bell,
                onPressed: onNotifications,
                badge: FBCountBubble(count: feed.notificationCount),
              ),
              const SizedBox(width: 8),
              FBAvatar(name: feed.viewerName, hue: feed.viewerHue, size: 40),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: FBColors.card,
              borderRadius: FBRadius.all(FBRadius.card),
              border: Border.all(color: FBColors.cardBorder),
            ),
            child: Row(
              children: [
                const Icon(FBIcons.search, size: 18, color: FBColors.textMid),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onQueryChanged,
                    style: FBText.bodyLg.copyWith(color: FBColors.text),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: feed.searchHint,
                      hintStyle: FBText.bodyLg.copyWith(
                        color: FBColors.textDim,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: FBColors.navy,
                    borderRadius: FBRadius.all(FBRadius.chip),
                  ),
                  child: const Icon(
                    FBIcons.filter,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterStrip extends StatelessWidget {
  const _FilterStrip({
    required this.filters,
    required this.selected,
    required this.onSelected,
  });

  final List<String> filters;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        itemCount: filters.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) => FBChoiceChip(
          label: filters[i],
          selected: filters[i] == selected,
          onTap: () => onSelected(filters[i]),
        ),
      ),
    );
  }
}

class _MembershipBannerCard extends StatelessWidget {
  const _MembershipBannerCard({required this.banner, this.onTap});

  final MembershipBanner banner;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // The design draws a chevron on this card, so it has to lead somewhere:
    // it is the client's route into the membership screen from the feed.
    return GestureDetector(
      onTap: onTap,
      child: FBNavyPanel(
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                borderRadius: FBRadius.all(FBRadius.button),
              ),
              child: const Icon(
                FBIcons.dumbbell,
                size: 22,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    banner.tierLabel,
                    style: FBText.label.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    banner.detail,
                    style: FBText.bodyLg.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(FBIcons.chevronRight, size: 18, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FBIcons.search, size: 32, color: FBColors.textDim),
            const SizedBox(height: 12),
            Text(
              MockChrome.noTrainersTitle,
              style: FBText.titleSm.copyWith(color: FBColors.textMid),
            ),
            const SizedBox(height: 4),
            Text(
              MockChrome.noTrainersBody,
              textAlign: TextAlign.center,
              style: FBText.caption.copyWith(color: FBColors.textDim),
            ),
          ],
        ),
      ),
    );
  }
}

/// The two-up trainer card used on the home grid.
class TrainerCard extends StatelessWidget {
  const TrainerCard({super.key, required this.trainer, this.onTap});

  final Trainer trainer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      radius: FBRadius.cardLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              FBPhoto(hue: trainer.identityHue, height: 108, radius: 12),
              if (trainer.isOnline)
                const Positioned(top: 8, left: 8, child: _OnlinePill()),
              Positioned(
                bottom: -14,
                left: 10,
                child: FBAvatar(
                  name: trainer.name,
                  hue: trainer.identityHue,
                  size: 32,
                  ringColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            trainer.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: FBText.bodyStrong.copyWith(letterSpacing: -0.2),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: [
              for (final s in trainer.specialities.take(2)) FBTag(label: s),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Icon(FBIcons.star, size: 12, color: FBColors.amber),
              const SizedBox(width: 3),
              Text(
                '${trainer.rating}',
                style: FBText.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: FBColors.text,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                '(${trainer.reviewCount})',
                style: FBText.micro.copyWith(
                  color: FBColors.textDim,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Text(
                '${trainer.hourlyRate} ',
                style: FBText.label.copyWith(
                  fontWeight: FontWeight.w700,
                  color: FBColors.navy,
                ),
              ),
              Text(
                MockChrome.hourlyRateShortSuffix,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: FBColors.textDim,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OnlinePill extends StatelessWidget {
  const _OnlinePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
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
          const SizedBox(width: 4),
          Text(
            MockChrome.onlineTag,
            style: FBText.micro.copyWith(color: FBColors.green),
          ),
        ],
      ),
    );
  }
}
