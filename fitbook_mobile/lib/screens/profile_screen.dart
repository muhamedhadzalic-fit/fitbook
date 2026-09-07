import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.6a · Profile.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.onRowTap});

  /// Fired with the tapped row's label so the host can route.
  final ValueChanged<SettingsRow>? onRowTap;

  @override
  Widget build(BuildContext context) {
    final user = Mockup.profile;

    return Scaffold(
      backgroundColor: FBColors.bg,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _ProfileHero(user: user),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final group in user.settingsGroups) ...[
                  FBSectionLabel(group.label),
                  for (final row in group.rows)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _SettingsTile(
                        row: row,
                        onTap: () => onRowTap?.call(row),
                      ),
                    ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.user});

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        color: FBColors.navy,
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: FBColors.blue.withValues(alpha: 0.25),
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            MockChrome.profileTitle,
                            style: FBText.h4.copyWith(color: Colors.white),
                          ),
                        ),
                        const Icon(
                          FBIcons.settings,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        FBAvatar(
                          name: user.name,
                          hue: user.identityHue,
                          size: 64,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: FBText.h3.copyWith(color: Colors.white),
                              ),
                              Text(
                                user.email,
                                style: FBText.label.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 6),
                              FBBadge(
                                label: user.membershipBadge,
                                background: FBColors.blue,
                                foreground: Colors.white,
                                fontSize: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        for (var i = 0; i < user.stats.length; i++) ...[
                          if (i > 0) const SizedBox(width: 8),
                          Expanded(child: _StatTile(stat: user.stats[i])),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.stat});

  final ProfileStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: FBRadius.all(FBRadius.button),
      ),
      child: Column(
        children: [
          Text(
            stat.value,
            style: FBText.titleMd.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: FBText.micro.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.row, this.onTap});

  final SettingsRow row;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final accent = row.isDestructive ? FBColors.red : FBColors.blue;

    return FBCard(
      onTap: onTap,
      shadow: null,
      radius: FBRadius.button,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: row.isDestructive ? FBColors.redBg : FBColors.blueLight,
              borderRadius: FBRadius.all(FBRadius.control),
            ),
            child: Icon(FBIcons.byKey(row.iconKey), size: 16, color: accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.label,
                  style: FBText.label.copyWith(
                    color: row.isDestructive ? FBColors.red : FBColors.text,
                  ),
                ),
                if (row.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      row.subtitle!,
                      style: FBText.caption.copyWith(color: FBColors.textDim),
                    ),
                  ),
              ],
            ),
          ),
          if (row.hasBadge) ...[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: FBColors.blue,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
          ],
          const Icon(FBIcons.chevronRight, size: 14, color: FBColors.textDim),
        ],
      ),
    );
  }
}
