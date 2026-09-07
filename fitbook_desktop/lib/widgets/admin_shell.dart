import 'package:flutter/material.dart';

import '../models/nav.dart';
import '../theme/fb_theme.dart';
import 'fb_avatar.dart';

/// The admin window: navy sidebar on the left, content header and body on the
/// right.
///
/// The design mocks a Windows title bar because it renders inside a browser
/// canvas; the real app leaves the title bar to the OS, so this shell starts at
/// the sidebar.
class AdminShell extends StatelessWidget {
  const AdminShell({
    super.key,
    required this.title,
    required this.child,
    required this.navGroups,
    required this.activeNavId,
    required this.admin,
    required this.branding,
    this.breadcrumb,
    this.subtitle,
    this.headerActions = const [],
    this.onNavSelected,
  });

  final String title;
  final Widget child;
  final List<NavGroup> navGroups;
  final String activeNavId;
  final AdminIdentity admin;
  final AdminBranding branding;

  /// Small path line above the title, e.g. "Admin · Operations · Reservations".
  final String? breadcrumb;

  /// Replaces [breadcrumb] with a line below the title instead.
  final String? subtitle;

  final List<Widget> headerActions;
  final ValueChanged<String>? onNavSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FBColors.card,
      body: Row(
        children: [
          AdminSidebar(
            groups: navGroups,
            activeId: activeNavId,
            admin: admin,
            branding: branding,
            onSelected: onNavSelected,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: FBColors.cardBorder),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (breadcrumb != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: Text(
                                  breadcrumb!,
                                  style: FBText.caption.copyWith(
                                    color: FBColors.textDim,
                                  ),
                                ),
                              ),
                            Text(
                              title,
                              style: FBText.h3.copyWith(fontSize: 18),
                            ),
                            if (subtitle != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  subtitle!,
                                  style: FBText.caption.copyWith(
                                    color: FBColors.textDim,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      for (final action in headerActions) ...[
                        const SizedBox(width: 10),
                        action,
                      ],
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// The navy navigation rail.
class AdminSidebar extends StatelessWidget {
  const AdminSidebar({
    super.key,
    required this.groups,
    required this.activeId,
    required this.admin,
    required this.branding,
    this.onSelected,
  });

  final List<NavGroup> groups;
  final String activeId;
  final AdminIdentity admin;
  final AdminBranding branding;
  final ValueChanged<String>? onSelected;

  static const width = 240.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: FBColors.navy,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: FBColors.blue,
                    borderRadius: FBRadius.all(9),
                  ),
                  child: const Text(
                    'F',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        branding.appName,
                        style: FBText.titleMd.copyWith(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        branding.appSubtitle,
                        style: FBText.micro.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                for (final group in groups) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 12, 6),
                    child: Text(
                      group.label,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                        color: Colors.white.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                  for (final item in group.items)
                    _NavRow(
                      item: item,
                      isActive: item.id == activeId,
                      onTap: onSelected == null
                          ? null
                          : () => onSelected!(item.id),
                    ),
                ],
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: FBRadius.all(FBRadius.control),
            ),
            child: Row(
              children: [
                FBAvatar(name: admin.name, hue: admin.identityHue, size: 36),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        admin.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: FBText.label.copyWith(color: Colors.white),
                      ),
                      Text(
                        admin.role,
                        style: FBText.micro.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  FBIcons.chevronRight,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({required this.item, required this.isActive, this.onTap});

  final NavItem item;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final fg = isActive
        ? Colors.white
        : Colors.white.withValues(alpha: item.isImplemented ? 0.78 : 0.45);

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: isActive ? FBColors.blue : Colors.transparent,
        borderRadius: FBRadius.all(FBRadius.chip),
        child: InkWell(
          onTap: onTap,
          borderRadius: FBRadius.all(FBRadius.chip),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              children: [
                Icon(FBIcons.byKey(item.iconKey), size: 16, color: fg),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      color: fg,
                    ),
                  ),
                ),
                if (item.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: isActive ? 0.22 : 0.08,
                      ),
                      borderRadius: FBRadius.all(FBRadius.badge),
                    ),
                    child: Text(
                      item.badge!,
                      style: FBText.micro.copyWith(
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
