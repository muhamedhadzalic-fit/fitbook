import '../models/report.dart';

/// Trainer PDF-report fixtures.
abstract final class MockTrainerReport {
  static const form = TrainerReportForm(
    earningsTotal: '3,420',
    earningsCurrency: 'KM',
    earningsCaption: 'EARNINGS THIS PERIOD',
    stats: [
      EarningsStat(label: 'Sessions', value: '76'),
      EarningsStat(label: 'Avg. rating', value: '4.9 ★'),
      EarningsStat(label: 'Hours', value: '76h'),
    ],
    selectedPeriodId: 'month',
    periods: [
      ReportPeriod(id: 'week', label: 'This week'),
      ReportPeriod(id: 'month', label: 'This month'),
      ReportPeriod(id: '90d', label: 'Last 90d'),
      ReportPeriod(id: 'q1', label: 'Q1 2026'),
      ReportPeriod(id: 'ytd', label: 'YTD'),
      ReportPeriod(id: 'custom', label: 'Custom'),
    ],
    fromLabel: 'Apr 1, 2026',
    toLabel: 'Apr 25, 2026',
    sections: [
      ReportSection(
        id: 'sessions',
        label: 'Sessions list',
        detail: 'All 76 completed sessions',
        enabledByDefault: true,
      ),
      ReportSection(
        id: 'earnings',
        label: 'Earnings breakdown',
        detail: 'Per session, with VAT detail',
        enabledByDefault: true,
      ),
      ReportSection(
        id: 'ratings',
        label: 'Client ratings & reviews',
        detail: '64 reviews this period',
        enabledByDefault: true,
      ),
      ReportSection(
        id: 'cancellations',
        label: 'Cancellation summary',
        detail: '3 cancelled · 2 refunded',
        enabledByDefault: false,
      ),
      ReportSection(
        id: 'tax',
        label: 'Tax summary (PIO/MIO)',
        detail: 'For accountant',
        enabledByDefault: true,
      ),
    ],
    filePreview: ReportFilePreview(
      fileName: 'Marko_Petric_April_2026.pdf',
      detail: 'Estimated 8 pages · ~2.4 MB',
    ),
  );

  static const periodHeading = 'REPORT PERIOD';
  static const sectionsHeading = 'INCLUDE IN REPORT';
  static const printLabel = 'Print';
  static const generateLabel = 'Generate PDF';
  static const previewLabel = 'Preview →';
}
