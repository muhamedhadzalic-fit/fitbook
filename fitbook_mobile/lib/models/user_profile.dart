/// A headline number on the profile hero.
class ProfileStat {
  const ProfileStat({required this.value, required this.label});

  final String value;
  final String label;
}

/// A row in the profile settings list.
class SettingsRow {
  const SettingsRow({
    required this.id,
    required this.iconKey,
    required this.label,
    this.subtitle,
    this.hasBadge = false,
    this.isDestructive = false,
  });

  /// Routing key the shell switches on. Kept separate from [label] so
  /// re-wording a row never changes where it goes.
  final String id;

  /// Key resolved through `FBIcons.byKey` — mock data stays free of Flutter
  /// imports.
  final String iconKey;

  final String label;
  final String? subtitle;
  final bool hasBadge;
  final bool isDestructive;
}

/// A titled group of settings rows.
class SettingsGroup {
  const SettingsGroup({required this.label, required this.rows});

  final String label;
  final List<SettingsRow> rows;
}

/// The signed-in user as the profile screen shows them.
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.identityHue,
    required this.membershipBadge,
    required this.stats,
    required this.settingsGroups,
  });

  final String name;
  final String email;
  final double identityHue;
  final String membershipBadge;
  final List<ProfileStat> stats;
  final List<SettingsGroup> settingsGroups;
}
