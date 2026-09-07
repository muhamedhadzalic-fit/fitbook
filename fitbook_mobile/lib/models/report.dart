/// A headline earnings figure on the trainer report screen.
class EarningsStat {
  const EarningsStat({required this.label, required this.value});

  final String label;
  final String value;
}

/// A selectable reporting period.
class ReportPeriod {
  const ReportPeriod({required this.id, required this.label});

  final String id;
  final String label;
}

/// A toggleable section of the generated PDF.
class ReportSection {
  const ReportSection({
    required this.id,
    required this.label,
    required this.detail,
    required this.enabledByDefault,
  });

  final String id;
  final String label;
  final String detail;
  final bool enabledByDefault;
}

/// Metadata about the PDF that will be produced.
class ReportFilePreview {
  const ReportFilePreview({required this.fileName, required this.detail});

  final String fileName;
  final String detail;
}

/// The trainer's report-generation form.
class TrainerReportForm {
  const TrainerReportForm({
    required this.earningsTotal,
    required this.earningsCurrency,
    required this.earningsCaption,
    required this.stats,
    required this.periods,
    required this.selectedPeriodId,
    required this.fromLabel,
    required this.toLabel,
    required this.sections,
    required this.filePreview,
  });

  final String earningsTotal;
  final String earningsCurrency;
  final String earningsCaption;
  final List<EarningsStat> stats;
  final List<ReportPeriod> periods;
  final String selectedPeriodId;
  final String fromLabel;
  final String toLabel;
  final List<ReportSection> sections;
  final ReportFilePreview filePreview;
}
