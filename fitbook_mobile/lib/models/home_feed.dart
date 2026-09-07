import 'trainer.dart';

/// The membership banner at the top of the home feed.
class MembershipBanner {
  const MembershipBanner({required this.tierLabel, required this.detail});

  final String tierLabel;
  final String detail;
}

/// A destination in the bottom navigation bar.
class NavDestination {
  const NavDestination({
    required this.id,
    required this.label,
    required this.iconKey,
  });

  final String id;
  final String label;
  final String iconKey;
}

/// Everything the home screen renders.
class HomeFeed {
  const HomeFeed({
    required this.greeting,
    required this.brand,
    required this.searchHint,
    required this.notificationCount,
    required this.viewerName,
    required this.viewerHue,
    required this.specialityFilters,
    required this.banner,
    required this.sectionTitle,
    required this.trainers,
  });

  final String greeting;
  final String brand;
  final String searchHint;
  final int notificationCount;
  final String viewerName;
  final double viewerHue;

  /// Filter chips; the first entry is the "show everything" option.
  final List<String> specialityFilters;

  final MembershipBanner banner;
  final String sectionTitle;
  final List<Trainer> trainers;
}
