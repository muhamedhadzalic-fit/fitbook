import 'enums.dart';

/// A member row in the admin table.
class MemberRow {
  const MemberRow({
    required this.name,
    required this.email,
    required this.city,
    required this.joinedLabel,
    required this.sessionCount,
    required this.plan,
    required this.planTintKey,
    required this.status,
    required this.identityHue,
  });

  final String name;
  final String email;
  final String city;
  final String joinedLabel;
  final int sessionCount;
  final String plan;

  /// Semantic tint name for the plan chip — the plan itself is content, so the
  /// screen must not colour it by matching on the plan's name.
  final String? planTintKey;

  final MemberStatus status;
  final double identityHue;
}
