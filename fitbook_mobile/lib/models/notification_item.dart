import 'enums.dart';

/// A single notification row.
class NotificationItem {
  const NotificationItem({
    required this.tone,
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.isUnread,
  });

  final NotificationTone tone;
  final String title;
  final String body;
  final String timeLabel;
  final bool isUnread;
}

/// Notifications bucketed under a date heading ("Today", "Yesterday").
class NotificationGroup {
  const NotificationGroup({required this.label, required this.items});

  final String label;
  final List<NotificationItem> items;
}

/// A filter chip above the notification list.
class NotificationFilter {
  const NotificationFilter({required this.label, required this.count});

  final String label;
  final int count;
}

/// Everything the notifications screen renders.
class NotificationFeed {
  const NotificationFeed({
    required this.unreadCount,
    required this.filters,
    required this.groups,
  });

  final int unreadCount;
  final List<NotificationFilter> filters;
  final List<NotificationGroup> groups;
}
