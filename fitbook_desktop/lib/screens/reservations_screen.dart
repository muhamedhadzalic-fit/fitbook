import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../widgets/widgets.dart';
import 'reservation_columns.dart';

/// 6.3a · Reservations management — the searchable, filtered, paginated list.
class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key, this.onOpenDetail});

  final ValueChanged<ReservationRow>? onOpenDetail;

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  final _searchController = TextEditingController();

  String _query = '';
  int _tabIndex = 0;
  ReservationRow? _selected;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Filters by the search box and the status tab. Real filtering happens
  /// server-side with an enforced page size; this mirrors the same shape.
  List<ReservationRow> get _visibleRows {
    final tabLabel = Mockup.reservationTabs[_tabIndex].label;
    return Mockup.reservations.where((row) {
      final matchesQuery =
          _query.isEmpty ||
          row.reference.toLowerCase().contains(_query.toLowerCase()) ||
          row.clientName.toLowerCase().contains(_query.toLowerCase()) ||
          row.trainerName.toLowerCase().contains(_query.toLowerCase());
      final matchesTab =
          tabLabel == 'All' ||
          row.status.name.toLowerCase() == tabLabel.toLowerCase();
      return matchesQuery && matchesTab;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final rows = _visibleRows;

    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      children: [
        Row(
          children: [
            for (var i = 0; i < Mockup.reservationKpis.length; i++) ...[
              if (i > 0) const SizedBox(width: 12),
              Expanded(child: MiniKpiCard(metric: Mockup.reservationKpis[i])),
            ],
          ],
        ),
        const SizedBox(height: 16),
        FBFilterBar(
          search: FBSearchField(
            hint: MockReservations.searchHint,
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            onClear: () => setState(() {
              _searchController.clear();
              _query = '';
            }),
          ),
          filters: [
            for (final filter in MockReservations.filters)
              FBDropdown(value: filter),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            for (var i = 0; i < Mockup.reservationTabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 4),
              FBStatusTab(
                label: Mockup.reservationTabs[i].label,
                count: Mockup.reservationTabs[i].count,
                isActive: i == _tabIndex,
                onTap: () => setState(() => _tabIndex = i),
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        AdminTable<ReservationRow>(
          columns: reservationColumns(onView: widget.onOpenDetail),
          rows: rows,
          selectedRow: _selected,
          emptyMessage: MockReservations.emptyMessage,
          onRowTap: (row) {
            setState(() => _selected = row);
            widget.onOpenDetail?.call(row);
          },
        ),
        const SizedBox(height: 14),
        TablePagination(
          summary: MockReservations.pageSizeNote,
          pageCount: MockReservations.pageCount,
          currentPage: MockReservations.currentPage,
        ),
      ],
    );
  }
}
