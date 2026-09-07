import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.9 · Trainer PDF report.
///
/// A trainer generates reports over their own sessions and earnings only —
/// never another trainer's data.
class TrainerReportScreen extends StatefulWidget {
  const TrainerReportScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<TrainerReportScreen> createState() => _TrainerReportScreenState();
}

class _TrainerReportScreenState extends State<TrainerReportScreen> {
  final _form = Mockup.trainerReport;

  late String _periodId = _form.selectedPeriodId;
  late final Map<String, bool> _sectionEnabled = {
    for (final s in _form.sections) s.id: s.enabledByDefault,
  };

  @override
  Widget build(BuildContext context) {
    return FBScreen(
      title: MockChrome.reportTitle,
      onBack: widget.onBack,
      headerPadding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          _EarningsHero(form: _form),
          const SizedBox(height: 18),
          FBSectionLabel(
            MockTrainerReport.periodHeading,
            padding: const EdgeInsets.only(left: 4, bottom: 8),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              mainAxisExtent: 40,
            ),
            itemCount: _form.periods.length,
            itemBuilder: (context, i) {
              final p = _form.periods[i];
              final isSelected = p.id == _periodId;
              return GestureDetector(
                onTap: () => setState(() => _periodId = p.id),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? FBColors.navy : Colors.white,
                    borderRadius: FBRadius.all(FBRadius.control),
                    border: Border.all(
                      color: isSelected ? FBColors.navy : FBColors.cardBorder,
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    p.label,
                    style: FBText.label.copyWith(
                      color: isSelected ? Colors.white : FBColors.text,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: FBReadField(
                  label: MockChrome.fromLabel,
                  value: _form.fromLabel,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FBReadField(
                  label: MockChrome.toLabel,
                  value: _form.toLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          FBSectionLabel(
            MockTrainerReport.sectionsHeading,
            padding: const EdgeInsets.only(left: 4, bottom: 8),
          ),
          for (final s in _form.sections)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _SectionToggle(
                section: s,
                value: _sectionEnabled[s.id] ?? false,
                onChanged: (v) => setState(() => _sectionEnabled[s.id] = v),
              ),
            ),
          const SizedBox(height: 12),
          _FilePreviewCard(preview: _form.filePreview),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: FBButton(
                  label: MockTrainerReport.printLabel,
                  kind: FBButtonKind.outline,
                  icon: FBIcons.print,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: FBButton(
                  label: MockTrainerReport.generateLabel,
                  icon: FBIcons.download,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EarningsHero extends StatelessWidget {
  const _EarningsHero({required this.form});

  final TrainerReportForm form;

  @override
  Widget build(BuildContext context) {
    return FBNavyPanel(
      gradient: false,
      padding: const EdgeInsets.all(18),
      glow: FBPanelGlow.hero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            form.earningsCaption,
            style: FBText.eyebrow.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                form.earningsTotal,
                style: FBText.display.copyWith(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  form.earningsCurrency,
                  style: FBText.titleMd.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < form.stats.length; i++) ...[
                if (i > 0) const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      form.stats[i].label,
                      style: FBText.caption.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      form.stats[i].value,
                      style: FBText.titleSm.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionToggle extends StatelessWidget {
  const _SectionToggle({
    required this.section,
    required this.value,
    required this.onChanged,
  });

  final ReportSection section;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      shadow: null,
      radius: FBRadius.button,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(section.label, style: FBText.label),
                const SizedBox(height: 1),
                Text(
                  section.detail,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          FBSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _FilePreviewCard extends StatelessWidget {
  const _FilePreviewCard({required this.preview});

  final ReportFilePreview preview;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      background: FBColors.card,
      shadow: null,
      child: Row(
        children: [
          const _PdfThumbnail(),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(preview.fileName, style: FBText.bodyStrong),
                const SizedBox(height: 2),
                Text(
                  preview.detail,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
                const SizedBox(height: 6),
                Text(
                  MockTrainerReport.previewLabel,
                  style: FBText.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: FBColors.blue,
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

/// A miniature page render standing in for the PDF's first page.
class _PdfThumbnail extends StatelessWidget {
  const _PdfThumbnail();

  @override
  Widget build(BuildContext context) {
    Widget line(double widthFactor, {Color? color, double height = 2}) =>
        FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: widthFactor,
          child: Container(
            height: height,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              color: color ?? FBColors.cardBorder,
              borderRadius: FBRadius.all(1),
            ),
          ),
        );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 72,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: FBRadius.all(6),
            border: Border.all(color: FBColors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              line(1, color: FBColors.navy, height: 4),
              const SizedBox(height: 1),
              line(0.7),
              line(0.5),
              const SizedBox(height: 2),
              line(1, color: FBColors.blueLight, height: 12),
              const SizedBox(height: 1),
              line(1),
              line(1),
              line(0.7),
            ],
          ),
        ),
        Positioned(
          bottom: -6,
          right: -6,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: FBColors.red,
              borderRadius: FBRadius.all(3),
            ),
            child: const Text(
              'PDF',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 7,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
