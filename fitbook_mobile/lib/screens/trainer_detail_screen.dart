import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.3b · Trainer profile — the detail half of the trainer master-detail pair.
class TrainerDetailScreen extends StatefulWidget {
  const TrainerDetailScreen({
    super.key,
    required this.trainer,
    this.onBack,
    this.onReserve,
  });

  final Trainer trainer;
  final VoidCallback? onBack;
  final VoidCallback? onReserve;

  @override
  State<TrainerDetailScreen> createState() => _TrainerDetailScreenState();
}

class _TrainerDetailScreenState extends State<TrainerDetailScreen> {
  final _availability = Mockup.availability;

  late int _dayIndex = _availability.initialDayIndex;
  late String _slot = _availability.initialSlot;

  static const _heroHeight = 320.0;

  Trainer get _trainer => widget.trainer;

  /// The day/time the reserve button commits to.
  String get _selectionLabel {
    final day = _availability.days[_dayIndex];
    return '${day.weekday} $_slot';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FBColors.bg,
      body: Stack(
        children: [
          SizedBox(
            height: _heroHeight,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                FBPhoto(
                  hue: _trainer.identityHue,
                  height: _heroHeight,
                  radius: 0,
                  caption: MockChrome.heroPhotoCaption,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x590F172A),
                        Color(0x000F172A),
                        Color(0x000F172A),
                        Color(0x800F172A),
                      ],
                      stops: [0.0, 0.3, 0.6, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: MediaQuery.paddingOf(context).top + 4),
              _topActions(),
              const SizedBox(height: 180),
              _sheet(),
            ],
          ),
          Positioned(left: 0, right: 0, bottom: 0, child: _stickyCta()),
        ],
      ),
    );
  }

  Widget _topActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FBIconButton(
            icon: FBIcons.back,
            onPressed: widget.onBack,
            background: Colors.white.withValues(alpha: 0.95),
            borderColor: Colors.transparent,
          ),
          const Spacer(),
          FBIconButton(
            icon: FBIcons.share,
            background: Colors.white.withValues(alpha: 0.95),
            borderColor: Colors.transparent,
          ),
          const SizedBox(width: 8),
          FBIconButton(
            icon: FBIcons.heart,
            iconColor: FBColors.red,
            background: Colors.white.withValues(alpha: 0.95),
            borderColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _sheet() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F0F172A),
            offset: Offset(0, -8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameRow(),
          const SizedBox(height: 12),
          _tags(),
          const SizedBox(height: 16),
          _stats(),
          const SizedBox(height: 18),
          Text(MockChrome.aboutHeading, style: FBText.titleSm),
          const SizedBox(height: 6),
          Text(
            _trainer.bio,
            style: FBText.body.copyWith(color: FBColors.textMid, height: 1.55),
          ),
          const SizedBox(height: 20),
          _availabilitySection(),
          // Clears the sticky CTA.
          const SizedBox(height: 96),
        ],
      ),
    );
  }

  Widget _nameRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _trainer.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FBText.h3,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(FBIcons.pin, size: 14, color: FBColors.textMid),
                  const SizedBox(width: 6),
                  Text(
                    _trainer.location,
                    style: FBText.body.copyWith(color: FBColors.textMid),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              MockChrome.amountLabel(_trainer.hourlyRate),
              style: FBText.h3.copyWith(color: FBColors.navy),
            ),
            Text(
              MockChrome.perSessionLabel,
              style: FBText.caption.copyWith(color: FBColors.textDim),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tags() {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final s in _trainer.specialities) FBTag(label: s, fontSize: 12),
        if (_trainer.isCertified)
          const FBTag(
            label: MockChrome.certifiedTag,
            fontSize: 12,
            background: FBColors.greenBg,
            foreground: FBColors.green,
          ),
      ],
    );
  }

  Widget _stats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.card),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Stat(
              icon: FBIcons.star,
              value: '${_trainer.rating}',
              label: MockChrome.reviewsStatLabel(_trainer.reviewCount),
              accent: FBColors.amber,
            ),
          ),
          Expanded(
            child: _Stat(
              icon: FBIcons.user,
              value: _trainer.clientCount,
              label: MockChrome.clientsStatLabel,
            ),
          ),
          Expanded(
            child: _Stat(
              icon: FBIcons.clock,
              value: MockChrome.yearsValue(_trainer.yearsExperience),
              label: MockChrome.experienceStatLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _availabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                MockChrome.availabilityHeading,
                style: FBText.titleSm,
              ),
            ),
            Text(
              _availability.monthLabel,
              style: FBText.label.copyWith(color: FBColors.blue),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (var i = 0; i < _availability.days.length; i++) ...[
              if (i > 0) const SizedBox(width: 6),
              Expanded(
                child: _DayCell(
                  day: _availability.days[i],
                  isSelected: i == _dayIndex,
                  onTap: () => setState(() => _dayIndex = i),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            mainAxisExtent: 36,
          ),
          itemCount: _availability.slots.length,
          itemBuilder: (context, i) {
            final slot = _availability.slots[i];
            return _SlotCell(
              slot: slot,
              isSelected: !slot.isTaken && slot.time == _slot,
              onTap: slot.isTaken
                  ? null
                  : () => setState(() => _slot = slot.time),
            );
          },
        ),
      ],
    );
  }

  Widget _stickyCta() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: FBColors.cardBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: FBButton(
            label: MockChrome.reserveLabel,
            onPressed: widget.onReserve,
            height: 52,
            fontSize: 15,
            trailingLabel:
                '${MockChrome.amountLabel(_trainer.hourlyRate)} · '
                '$_selectionLabel',
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    this.accent,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: accent ?? FBColors.navy),
            const SizedBox(width: 4),
            Text(value, style: FBText.titleSm),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: FBText.micro.copyWith(
            color: FBColors.textDim,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isSelected,
    required this.onTap,
  });

  final AvailabilityDay day;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = isSelected ? Colors.white : FBColors.text;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? FBColors.navy : Colors.white,
          borderRadius: FBRadius.all(FBRadius.control),
          border: Border.all(
            color: isSelected ? FBColors.navy : FBColors.cardBorder,
          ),
        ),
        child: Column(
          children: [
            Text(
              day.weekday,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: fg.withValues(alpha: 0.75),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              '${day.dayOfMonth}',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SlotCell extends StatelessWidget {
  const _SlotCell({
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  final AvailabilitySlot slot;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final background = isSelected
        ? FBColors.blue
        : (slot.isTaken ? FBColors.slotDisabled : Colors.white);
    final foreground = isSelected
        ? Colors.white
        : (slot.isTaken ? FBColors.textDim : FBColors.text);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: background,
          borderRadius: FBRadius.all(FBRadius.control),
          border: Border.all(
            color: isSelected ? FBColors.blue : FBColors.cardBorder,
          ),
        ),
        child: Text(
          slot.time,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: foreground,
            decoration: slot.isTaken ? TextDecoration.lineThrough : null,
            decorationColor: FBColors.textDim,
          ),
        ),
      ),
    );
  }
}
