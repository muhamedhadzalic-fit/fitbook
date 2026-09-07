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
    required this.status,
    required this.identityHue,
  });

  final String name;
  final String email;
  final String city;
  final String joinedLabel;
  final int sessionCount;
  final String plan;
  final MemberStatus status;
  final double identityHue;
}
