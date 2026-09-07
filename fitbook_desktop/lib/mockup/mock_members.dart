import '../models/dashboard.dart';
import '../models/enums.dart';
import '../models/member.dart';

/// Member-management fixtures.
abstract final class MockMembers {
  static const rows = <MemberRow>[
    MemberRow(
      name: 'Amila Đedović',
      email: 'amila.djedovic@email.ba',
      city: 'Sarajevo',
      joinedLabel: 'Jan 2025',
      sessionCount: 24,
      plan: 'Premium',
      planTintKey: 'blue',
      status: MemberStatus.active,
      identityHue: 280,
    ),
    MemberRow(
      name: 'Haris Tabaković',
      email: 'haris.t@email.ba',
      city: 'Sarajevo',
      joinedLabel: 'Mar 2025',
      sessionCount: 8,
      plan: 'Basic',
      planTintKey: 'grey',
      status: MemberStatus.active,
      identityHue: 50,
    ),
    MemberRow(
      name: 'Edin Mehmedović',
      email: 'edin.m@email.ba',
      city: 'Mostar',
      joinedLabel: 'Feb 2025',
      sessionCount: 16,
      plan: 'Premium',
      planTintKey: 'blue',
      status: MemberStatus.active,
      identityHue: 145,
    ),
    MemberRow(
      name: 'Selma Hadžić',
      email: 'selma.hadzic@email.ba',
      city: 'Sarajevo',
      joinedLabel: 'Apr 2024',
      sessionCount: 92,
      plan: 'Premium+',
      planTintKey: 'navy',
      status: MemberStatus.active,
      identityHue: 320,
    ),
    MemberRow(
      name: 'Vedran Knežević',
      email: 'vedran.k@email.ba',
      city: 'Banja Luka',
      joinedLabel: 'Dec 2024',
      sessionCount: 41,
      plan: 'Premium',
      planTintKey: 'blue',
      status: MemberStatus.active,
      identityHue: 195,
    ),
    MemberRow(
      name: 'Naida Pjanić',
      email: 'naida.p@email.ba',
      city: 'Tuzla',
      joinedLabel: 'Mar 2025',
      sessionCount: 4,
      plan: 'Basic',
      planTintKey: 'grey',
      status: MemberStatus.expired,
      identityHue: 5,
    ),
    MemberRow(
      name: 'Adnan Begić',
      email: 'adnan.b@email.ba',
      city: 'Sarajevo',
      joinedLabel: 'Feb 2025',
      sessionCount: 12,
      plan: 'Premium',
      planTintKey: 'blue',
      status: MemberStatus.suspended,
      identityHue: 215,
    ),
    MemberRow(
      name: 'Tea Šabić',
      email: 'tea.s@email.ba',
      city: 'Sarajevo',
      joinedLabel: 'May 2024',
      sessionCount: 67,
      plan: 'Premium+',
      planTintKey: 'navy',
      status: MemberStatus.active,
      identityHue: 30,
    ),
  ];

  static const kpis = <MiniKpi>[
    MiniKpi(label: 'Total members', value: '1,248'),
    MiniKpi(label: 'Active subscriptions', value: '1,082', tintKey: 'green'),
    MiniKpi(label: 'Expiring this month', value: '46', tintKey: 'amber'),
    MiniKpi(label: 'Lifetime value', value: '184,200 KM', tintKey: 'blue'),
  ];

  static const searchHint = 'Search by name or email…';
  static const filters = <String>['All cities', 'All plans', 'All statuses'];
  static const inviteLabel = 'Invite member';
  static const pageSizeNote = 'Showing 1–8 of 1,248 members';
  static const emptyMessage = 'No members match this search';
  static const viewTooltip = 'View member';
  static const moreTooltip = 'More';
}
