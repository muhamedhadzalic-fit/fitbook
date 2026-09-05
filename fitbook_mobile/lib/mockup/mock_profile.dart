import '../models/user_profile.dart';

/// Signed-in-user fixtures for the profile screen.
abstract final class MockProfile {
  static const user = UserProfile(
    name: 'Amila Đedović',
    email: 'amila.djedovic@email.ba',
    identityHue: 280,
    membershipBadge: 'PREMIUM · 8 LEFT',
    stats: [
      ProfileStat(value: '24', label: 'Sessions'),
      ProfileStat(value: '1,840', label: 'Calories/wk'),
      ProfileStat(value: '12', label: 'Streak days'),
    ],
    settingsGroups: [
      SettingsGroup(
        label: 'ACCOUNT',
        rows: [
          SettingsRow(
            id: 'personal',
            iconKey: 'user',
            label: 'Personal information',
          ),
          SettingsRow(
            id: 'membership',
            iconKey: 'money',
            label: 'Membership & billing',
            subtitle: 'Premium · Renews May 14',
          ),
          SettingsRow(
            id: 'notifications',
            iconKey: 'bell',
            label: 'Notifications',
            subtitle: '3 unread',
            hasBadge: true,
          ),
        ],
      ),
      SettingsGroup(
        label: 'FITNESS',
        rows: [
          SettingsRow(
            id: 'bookings',
            iconKey: 'calendar',
            label: 'My bookings',
            subtitle: '2 upcoming sessions',
          ),
          SettingsRow(
            id: 'favorites',
            iconKey: 'heart',
            label: 'Favorite trainers',
            subtitle: '5 saved',
          ),
          SettingsRow(
            id: 'goals',
            iconKey: 'target',
            label: 'Goals & progress',
          ),
        ],
      ),
      SettingsGroup(
        label: 'SUPPORT',
        rows: [
          SettingsRow(id: 'help', iconKey: 'help', label: 'Help center'),
          SettingsRow(
            id: 'signout',
            iconKey: 'logout',
            label: 'Sign out',
            isDestructive: true,
          ),
        ],
      ),
    ],
  );
}
