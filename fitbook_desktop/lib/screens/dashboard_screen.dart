import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';
import 'reservation_columns.dart';

/// 6.1 · Admin dashboard — KPIs, bookings trend, top trainers, recent
/// reservations.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, this.onReservationTap});

  final ValueChanged<ReservationRow>? onReservationTap;

  @override
  Widget build(BuildContext context) {
    final dashboard = Mockup.dashboard;

    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            // Four across on a real window; two when the window is narrow.
            final columns = constraints.maxWidth < 900 ? 2 : 4;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                mainAxisExtent: 124,
              ),
              itemCount: dashboard.kpis.length,
              itemBuilder: (context, i) => KpiCard(metric: dashboard.kpis[i]),
            );
          },
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 17,
                child: BookingsChartCard(chart: dashboard.chart),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 10,
                child: _TopTrainersCard(
                  title: dashboard.rankingTitle,
                  rankings: dashboard.rankings,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        AdminTable<ReservationRow>(
          columns: reservationColumns(),
          rows: Mockup.recentReservations,
          onRowTap: onReservationTap,
          header: _TableHeaderStrip(
            title: MockDashboard.recentTitle,
            subtitle: MockDashboard.recentSubtitle,
          ),
        ),
      ],
    );
  }
}

class _TopTrainersCard extends StatelessWidget {
  const _TopTrainersCard({required this.title, required this.rankings});

  final String title;
  final List<TrainerRanking> rankings;

  @override
  Widget build(BuildContext context) {
    final topSessions = rankings.isEmpty
        ? 1
        : rankings.map((r) => r.sessions).reduce((a, b) => a > b ? a : b);

    return FBCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text(title, style: FBText.titleSm)),
              Text(
                MockReports.viewAllLabel,
                style: FBText.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: FBColors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < rankings.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 22,
                    child: Text(
                      '#${i + 1}',
                      style: FBText.caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: i == 0 ? FBColors.navy : FBColors.textDim,
                      ),
                    ),
                  ),
                  FBAvatar(
                    name: rankings[i].name,
                    hue: rankings[i].identityHue,
                    size: 32,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rankings[i].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FBText.label,
                        ),
                        Text(
                          rankings[i].speciality,
                          style: FBText.micro.copyWith(
                            fontWeight: FontWeight.w500,
                            color: FBColors.textDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 60,
                    child: FBMeter(
                      fraction: rankings[i].sessions / topSessions,
                      color: FBColors.blue,
                      height: 5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 24,
                    child: Text(
                      '${rankings[i].sessions}',
                      textAlign: TextAlign.right,
                      style: FBText.label.copyWith(fontWeight: FontWeight.w700),
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

/// The title strip above a table, with optional trailing controls.
class _TableHeaderStrip extends StatelessWidget {
  const _TableHeaderStrip({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FBText.titleSm),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ],
            ),
          ),
          const FBTextButton(label: MockNav.filterLabel, icon: FBIcons.filter),
          const SizedBox(width: 8),
          const FBTextButton(
            label: MockNav.exportLabel,
            icon: FBIcons.download,
          ),
        ],
      ),
    );
  }
}
