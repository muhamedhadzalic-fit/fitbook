import '../models/membership.dart';

/// Membership purchase fixtures.
abstract final class MockMembership {
  static const offer = MembershipOffer(
    eyebrow: 'Choose your plan',
    headline: 'Train the way you want.',
    subhead: 'Cancel anytime. Switch plans whenever.',
    selectedPlanId: 'premium',
    plans: [
      MembershipPlan(
        id: 'basic',
        name: 'Basic',
        monthlyPrice: 29,
        sessionsLabel: '4 sessions / month',
        perks: ['1 trainer', 'Standard support'],
        isMostPopular: false,
      ),
      MembershipPlan(
        id: 'premium',
        name: 'Premium',
        monthlyPrice: 79,
        sessionsLabel: '12 sessions / month',
        perks: ['All trainers', 'AI FitBot', 'Priority booking'],
        isMostPopular: true,
      ),
      MembershipPlan(
        id: 'premium-plus',
        name: 'Premium+',
        monthlyPrice: 129,
        sessionsLabel: 'Unlimited sessions',
        perks: [
          'All trainers',
          'AI FitBot',
          'Nutrition plans',
          '1-on-1 coaching',
        ],
        isMostPopular: false,
      ),
    ],
    checkoutLines: [
      CheckoutLine(label: 'Premium · Monthly', amountLabel: '79 KM'),
      CheckoutLine(label: 'VAT (17%)', amountLabel: '13.43 KM'),
      CheckoutLine(
        label: 'Promo: WELCOME20',
        amountLabel: '−15.80 KM',
        isCredit: true,
      ),
    ],
    totalLabel: '76.63 KM',
    card: SavedCard(
      brand: 'VISA',
      maskedNumber: '•••• 4821',
      expiryLabel: 'Expires 09/27',
    ),
    billingNote: 'You\'ll be billed monthly. Cancel anytime in Settings.',
  );

  static const totalCaption = 'Total today';
  static const subscribeLabel = 'Subscribe';
  static const changeCardLabel = 'Change';
}
