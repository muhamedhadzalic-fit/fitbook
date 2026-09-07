/// A purchasable membership plan.
class MembershipPlan {
  const MembershipPlan({
    required this.id,
    required this.name,
    required this.monthlyPrice,
    required this.sessionsLabel,
    required this.perks,
    required this.isMostPopular,
  });

  final String id;
  final String name;

  /// Monthly price in KM. Display-only — the server prices the subscription.
  final int monthlyPrice;

  final String sessionsLabel;
  final List<String> perks;
  final bool isMostPopular;
}

/// One line of the checkout breakdown.
class CheckoutLine {
  const CheckoutLine({
    required this.label,
    required this.amountLabel,
    this.isCredit = false,
  });

  final String label;
  final String amountLabel;

  /// Discounts and promos render in green with a leading minus.
  final bool isCredit;
}

/// The saved card shown as the payment method.
class SavedCard {
  const SavedCard({
    required this.brand,
    required this.maskedNumber,
    required this.expiryLabel,
  });

  final String brand;
  final String maskedNumber;
  final String expiryLabel;
}

/// Everything the membership purchase screen renders.
class MembershipOffer {
  const MembershipOffer({
    required this.eyebrow,
    required this.headline,
    required this.subhead,
    required this.plans,
    required this.selectedPlanId,
    required this.checkoutLines,
    required this.totalLabel,
    required this.card,
    required this.billingNote,
  });

  final String eyebrow;
  final String headline;
  final String subhead;
  final List<MembershipPlan> plans;
  final String selectedPlanId;
  final List<CheckoutLine> checkoutLines;
  final String totalLabel;
  final SavedCard card;
  final String billingNote;
}
