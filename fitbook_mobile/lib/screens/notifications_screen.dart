import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.6b · Notifications.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _feed = Mockup.notifications;
  int _filterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FBScreen(
      title: MockChrome.notificationsTitle,
      titleStyle: FBText.h3.copyWith(fontSize: 18),
      subtitle: MockChrome.unreadCount(_feed.unreadCount),
      onBack: widget.onBack,
      headerPadding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: FBColors.blueLight,
            borderRadius: FBRadius.all(FBRadius.control),
          ),
          child: Text(
            MockNotifications.markAllLabel,
            style: FBText.label.copyWith(color: FBColors.blue),
          ),
        ),
      ],
      child: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              itemCount: _feed.filters.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, i) => FBChoiceChip(
                label: _feed.filters[i].label,
                trailingCount: _feed.filters[i].count,
                selected: i == _filterIndex,
                fontSize: 12,
                onTap: () => setState(() => _filterIndex = i),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: [
                for (final group in _feed.groups) ...[
                  FBSectionLabel(
                    group.label,
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      bottom: 8,
                    ),
                    fontSize: 11,
                  ),
                  for (final item in group.items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _NotificationCard(item: item),
                    ),
                  const SizedBox(height: 6),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.item});

  final NotificationItem item;

  ({Color bg, Color fg, IconData icon}) get _tone => switch (item.tone) {
    NotificationTone.success => (
      bg: FBColors.greenBg,
      fg: FBColors.green,
      icon: FBIcons.check,
    ),
    NotificationTone.error => (
      bg: FBColors.redBg,
      fg: FBColors.red,
      icon: FBIcons.close,
    ),
    NotificationTone.warning => (
      bg: FBColors.amberBg,
      fg: FBColors.amber,
      icon: FBIcons.alert,
    ),
    NotificationTone.info => (
      bg: FBColors.blueLight,
      fg: FBColors.blue,
      icon: FBIcons.bell,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final tone = _tone;
    return FBCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.bg,
              borderRadius: FBRadius.all(FBRadius.control),
            ),
            child: Icon(tone.icon, size: 18, color: tone.fg),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(item.title, style: FBText.bodyStrong)),
                    const SizedBox(width: 8),
                    Text(
                      item.timeLabel,
                      style: FBText.micro.copyWith(
                        color: FBColors.textDim,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.isUnread) ...[
                      const SizedBox(width: 8),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: FBColors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  item.body,
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textMid,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
