import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.5 · Buy membership.
///
/// Prices shown here are display-only. The server owns the price and finalizes
/// the charge; the client never reports a successful payment.
class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  final _offer = Mockup.membership;
  late String _planId = _offer.selectedPlanId;

  @override
  Widget build(BuildContext context) {
    return FBScreen(
      title: MockChrome.membershipTitle,
      onBack: widget.onBack,
      headerPadding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        children: [
          Text(
            _offer.eyebrow.toUpperCase(),
            style: FBText.caption.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: FBColors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _offer.headline,
            style: FBText.h1.copyWith(fontSize: 24, letterSpacing: -0.5),
          ),
          const SizedBox(height: 4),
          Text(
            _offer.subhead,
            style: FBText.body.copyWith(color: FBColors.textMid),
          ),
          const SizedBox(height: 18),
          for (final plan in _offer.plans)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _PlanCard(
                plan: plan,
                isSelected: plan.id == _planId,
                onTap: () => setState(() => _planId = plan.id),
              ),
            ),
          const SizedBox(height: 8),
          _CheckoutSummary(offer: _offer),
          const SizedBox(height: 12),
          _PaymentMethodRow(card: _offer.card),
          const SizedBox(height: 14),
          FBButton(
            label: '${MockMembership.subscribeLabel} · ${_offer.totalLabel}',
            height: 50,
          ),
          const SizedBox(height: 8),
          Text(
            _offer.billingNote,
            textAlign: TextAlign.center,
            style: FBText.micro.copyWith(
              color: FBColors.textDim,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  final MembershipPlan plan;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = isSelected ? Colors.white : FBColors.text;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isSelected ? FBColors.navy : Colors.white,
              borderRadius: FBRadius.all(FBRadius.cardLg),
              border: Border.all(
                color: isSelected ? FBColors.navy : FBColors.cardBorder,
                width: 2,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        plan.name,
                        style: FBText.titleMd.copyWith(
                          fontWeight: FontWeight.w800,
                          color: fg,
                        ),
                      ),
                    ),
                    Text(
                      '${plan.monthlyPrice}',
                      style: FBText.h2.copyWith(
                        fontWeight: FontWeight.w800,
                        color: fg,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      MockChrome.perMonthSuffix,
                      style: FBText.caption.copyWith(
                        color: fg.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  plan.sessionsLabel,
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.85)
                        : FBColors.textMid,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (final perk in plan.perks)
                      FBTag(
                        label: perk,
                        background: isSelected
                            ? Colors.white.withValues(alpha: 0.15)
                            : FBColors.blueLight,
                        foreground: isSelected ? Colors.white : FBColors.blue,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (plan.isMostPopular)
          Positioned(
            top: -10,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: FBColors.blue,
                borderRadius: FBRadius.all(FBRadius.pill),
              ),
              child: const Text(
                MockChrome.mostPopularTag,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _CheckoutSummary extends StatelessWidget {
  const _CheckoutSummary({required this.offer});

  final MembershipOffer offer;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      background: FBColors.card,
      shadow: null,
      child: Column(
        children: [
          for (final line in offer.checkoutLines)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      line.label,
                      style: FBText.body.copyWith(
                        color: line.isCredit
                            ? FBColors.green
                            : FBColors.textMid,
                      ),
                    ),
                  ),
                  Text(
                    line.amountLabel,
                    style: FBText.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: line.isCredit ? FBColors.green : FBColors.text,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 4),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  MockMembership.totalCaption,
                  style: FBText.label.copyWith(color: FBColors.textMid),
                ),
              ),
              Text(
                offer.totalLabel,
                style: FBText.h2.copyWith(
                  fontWeight: FontWeight.w800,
                  color: FBColors.navy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodRow extends StatelessWidget {
  const _PaymentMethodRow({required this.card});

  final SavedCard card;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FBColors.navy,
              borderRadius: FBRadius.all(5),
            ),
            child: Text(
              card.brand,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.maskedNumber, style: FBText.label),
                Text(
                  card.expiryLabel,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ],
            ),
          ),
          Text(
            MockMembership.changeCardLabel,
            style: FBText.label.copyWith(color: FBColors.blue),
          ),
        ],
      ),
    );
  }
}
