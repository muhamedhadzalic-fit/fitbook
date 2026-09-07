import '../models/enums.dart';
import '../models/notification_item.dart';

/// Notification-feed fixtures.
abstract final class MockNotifications {
  static const feed = NotificationFeed(
    unreadCount: 3,
    filters: [
      NotificationFilter(label: 'All', count: 6),
      NotificationFilter(label: 'Bookings', count: 3),
      NotificationFilter(label: 'System', count: 3),
    ],
    groups: [
      NotificationGroup(
        label: 'Today',
        items: [
          NotificationItem(
            tone: NotificationTone.success,
            title: 'Reservation confirmed',
            body:
                'Marko Petrić accepted your booking for Friday, 10:00 AM at '
                'Olympic Gym.',
            timeLabel: '14 min ago',
            isUnread: true,
          ),
          NotificationItem(
            tone: NotificationTone.warning,
            title: 'Membership expiring in 3 days',
            body:
                'Your Premium membership ends on April 28. Renew now to keep '
                'your 8 remaining sessions.',
            timeLabel: '2h ago',
            isUnread: true,
          ),
          NotificationItem(
            tone: NotificationTone.info,
            title: 'New trainer in your area',
            body:
                'Lejla Hodžić just joined FitBook. Specializes in cardio and '
                'HIIT.',
            timeLabel: '5h ago',
            isUnread: true,
          ),
        ],
      ),
      NotificationGroup(
        label: 'Yesterday',
        items: [
          NotificationItem(
            tone: NotificationTone.error,
            title: 'Reservation rejected',
            body:
                'Iva Milić couldn\'t accept Wed 17:00 — reason: trainer '
                'unavailable. Tap to rebook.',
            timeLabel: 'Yesterday, 19:42',
            isUnread: false,
          ),
          NotificationItem(
            tone: NotificationTone.success,
            title: 'Session completed',
            body:
                'Great work! You finished a 60-min Yoga session with Ana '
                'Kovač. Rate your experience.',
            timeLabel: 'Yesterday, 11:00',
            isUnread: false,
          ),
        ],
      ),
      NotificationGroup(
        label: 'Earlier',
        items: [
          NotificationItem(
            tone: NotificationTone.info,
            title: 'Weekly summary ready',
            body:
                'You completed 3 sessions and burned 1,840 kcal last week. '
                'Keep it up!',
            timeLabel: 'Apr 21',
            isUnread: false,
          ),
        ],
      ),
    ],
  );

  static const markAllLabel = 'Mark all read';
}
