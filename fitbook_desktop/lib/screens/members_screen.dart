import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 6.4 · Members management.
class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MemberRow> get _visibleRows {
    if (_query.isEmpty) return Mockup.members;
    final q = _query.toLowerCase();
    return Mockup.members
        .where(
          (m) =>
              m.name.toLowerCase().contains(q) ||
              m.email.toLowerCase().contains(q),
        )
        .toList();
  }

  static (Color, Color) _statusTint(MemberStatus status) => switch (status) {
    MemberStatus.active => (FBColors.greenBg, FBColors.green),
    MemberStatus.expired => (FBColors.amberBg, FBColors.amber),
    MemberStatus.suspended => (FBColors.redBg, FBColors.red),
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      children: [
        Row(
          children: [
            for (var i = 0; i < Mockup.memberKpis.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(child: MiniKpiCard(metric: Mockup.memberKpis[i])),
            ],
          ],
        ),
        const SizedBox(height: 16),
        FBFilterBar(
          search: FBSearchField(
            hint: MockMembers.searchHint,
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            onClear: () => setState(() {
              _searchController.clear();
              _query = '';
            }),
          ),
          filters: [
            for (final filter in MockMembers.filters) FBDropdown(value: filter),
          ],
        ),
        const SizedBox(height: 14),
        AdminTable<MemberRow>(
          rows: _visibleRows,
          emptyMessage: MockMembers.emptyMessage,
          columns: [
            TableColumnSpec(
              header: 'MEMBER',
              width: const FlexWidth(2),
              build: (context, row) => TableIdentityCell(
                avatar: FBAvatar(
                  name: row.name,
                  hue: row.identityHue,
                  size: 32,
                ),
                primary: row.name,
                secondary: row.email,
              ),
            ),
            TableColumnSpec(
              header: 'CITY',
              width: const FlexWidth(1),
              build: (context, row) => Row(
                children: [
                  const Icon(FBIcons.pin, size: 11, color: FBColors.textMid),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      row.city,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FBText.label.copyWith(
                        fontWeight: FontWeight.w500,
                        color: FBColors.textMid,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TableColumnSpec(
              header: 'JOINED',
              width: const FixedWidth(80),
              build: (context, row) => Text(
                row.joinedLabel,
                style: FBText.label.copyWith(
                  fontWeight: FontWeight.w500,
                  color: FBColors.textMid,
                ),
              ),
            ),
            TableColumnSpec(
              header: 'SESSIONS',
              width: const FixedWidth(72),
              build: (context, row) =>
                  Text('${row.sessionCount}', style: FBText.label),
            ),
            TableColumnSpec(
              header: 'PLAN',
              width: const FixedWidth(96),
              build: (context, row) => Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: MiniKpiCard.tintFor(row.planTintKey),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    row.plan,
                    style: FBText.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: MiniKpiCard.tintFor(row.planTintKey),
                    ),
                  ),
                ],
              ),
            ),
            TableColumnSpec(
              header: 'STATUS',
              width: const FixedWidth(104),
              build: (context, row) {
                final (bg, fg) = _statusTint(row.status);
                final name = row.status.name;
                return FBBadge(
                  label: name[0].toUpperCase() + name.substring(1),
                  background: bg,
                  foreground: fg,
                );
              },
            ),
            TableColumnSpec(
              header: 'ACTIONS',
              width: const FixedWidth(68),
              alignment: Alignment.centerRight,
              build: (context, row) => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TableActionButton(
                    icon: FBIcons.eye,
                    tooltip: MockMembers.viewTooltip,
                  ),
                  SizedBox(width: 4),
                  TableActionButton(
                    icon: FBIcons.more,
                    tooltip: MockMembers.moreTooltip,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TablePagination(
          summary: MockMembers.pageSizeNote,
          pageCount: 3,
          currentPage: 1,
        ),
      ],
    );
  }
}
