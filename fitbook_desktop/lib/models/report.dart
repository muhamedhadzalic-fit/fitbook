import 'enums.dart';

/// A report type the generator can produce.
class ReportType {
  const ReportType({
    required this.id,
    required this.label,
    required this.description,
    required this.iconKey,
    required this.tintHue,
  });

  final String id;
  final String label;
  final String description;
  final String iconKey;
  final double tintHue;
}

/// A toggleable section of the generated PDF.
class ReportSectionToggle {
  const ReportSectionToggle({
    required this.label,
    required this.enabledByDefault,
  });

  final String label;
  final bool enabledByDefault;
}

/// A previously generated report.
class GeneratedReport {
  const GeneratedReport({
    required this.name,
    required this.type,
    required this.sizeLabel,
    required this.dateLabel,
    required this.state,
  });

  final String name;
  final String type;
  final String sizeLabel;
  final String dateLabel;
  final ReportState state;
}

/// The miniature first page shown as a live preview.
class ReportPreview {
  const ReportPreview({
    required this.eyebrow,
    required this.title,
    required this.periodLabel,
    required this.figures,
    required this.footer,
  });

  final String eyebrow;
  final String title;
  final String periodLabel;

  /// Headline figures, as (label, value) pairs.
  final List<(String, String)> figures;

  final String footer;
}

/// The reports screen.
class ReportsWorkspace {
  const ReportsWorkspace({
    required this.generatorHeading,
    required this.types,
    required this.selectedTypeId,
    required this.parameters,
    required this.sectionsHeading,
    required this.sections,
    required this.saveTemplateLabel,
    required this.generateLabel,
    required this.preview,
    required this.historyHeading,
    required this.history,
  });

  final String generatorHeading;
  final List<ReportType> types;
  final String selectedTypeId;

  /// Date range, format, locations, grouping.
  final List<ReportParameter> parameters;

  final String sectionsHeading;
  final List<ReportSectionToggle> sections;
  final String saveTemplateLabel;
  final String generateLabel;
  final ReportPreview preview;
  final String historyHeading;
  final List<GeneratedReport> history;
}

/// A dropdown parameter on the report generator.
class ReportParameter {
  const ReportParameter({
    required this.label,
    required this.value,
    this.isRequired = false,
  });

  final String label;
  final String value;
  final bool isRequired;
}
