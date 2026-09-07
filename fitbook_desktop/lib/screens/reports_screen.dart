import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 6.5 · PDF report generation — the admin app's reporting module.
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _workspace = Mockup.reports;

  late String _typeId = _workspace.selectedTypeId;
  late final Map<String, bool> _sectionEnabled = {
    for (final s in _workspace.sections) s.label: s.enabledByDefault,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final generator = _Generator(
            workspace: _workspace,
            selectedTypeId: _typeId,
            onTypeSelected: (id) => setState(() => _typeId = id),
            sectionEnabled: _sectionEnabled,
            onSectionToggled: (label) => setState(() {
              _sectionEnabled[label] = !(_sectionEnabled[label] ?? false);
            }),
          );
          final side = _SidePanel(workspace: _workspace);

          if (constraints.maxWidth < 900) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [generator, const SizedBox(height: 14), side],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SingleChildScrollView(child: generator)),
              const SizedBox(width: 14),
              SizedBox(width: 360, child: SingleChildScrollView(child: side)),
            ],
          );
        },
      ),
    );
  }
}

class _Generator extends StatelessWidget {
  const _Generator({
    required this.workspace,
    required this.selectedTypeId,
    required this.onTypeSelected,
    required this.sectionEnabled,
    required this.onSectionToggled,
  });

  final ReportsWorkspace workspace;
  final String selectedTypeId;
  final ValueChanged<String> onTypeSelected;
  final Map<String, bool> sectionEnabled;
  final ValueChanged<String> onSectionToggled;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FBHeading(workspace.generatorHeading),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 126,
            ),
            itemCount: workspace.types.length,
            itemBuilder: (context, i) => _TypeCard(
              type: workspace.types[i],
              isSelected: workspace.types[i].id == selectedTypeId,
              onTap: () => onTypeSelected(workspace.types[i].id),
            ),
          ),
          const SizedBox(height: 18),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 64,
            ),
            itemCount: workspace.parameters.length,
            itemBuilder: (context, i) => FBDropdown(
              label: workspace.parameters[i].label,
              isRequired: workspace.parameters[i].isRequired,
              value: workspace.parameters[i].value,
              width: null,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            workspace.sectionsHeading,
            style: FBText.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: FBColors.textMid,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final section in workspace.sections)
                FBToggleChip(
                  label: section.label,
                  isOn: sectionEnabled[section.label] ?? false,
                  onTap: () => onSectionToggled(section.label),
                ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FBButton(
                label: workspace.saveTemplateLabel,
                kind: FBButtonKind.outline,
                height: 40,
                fontSize: 12,
                radius: FBRadius.control,
                expand: false,
              ),
              const SizedBox(width: 10),
              FBButton(
                label: workspace.generateLabel,
                icon: FBIcons.download,
                height: 40,
                fontSize: 12,
                radius: FBRadius.control,
                expand: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  final ReportType type;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: FBRadius.all(FBRadius.button),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? FBColors.blueLight : Colors.white,
          borderRadius: FBRadius.all(FBRadius.button),
          border: Border.all(
            color: isSelected ? FBColors.blue : FBColors.cardBorder,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FBColors.tintSoft(type.tintHue),
                borderRadius: FBRadius.all(9),
              ),
              child: Icon(
                FBIcons.byKey(type.iconKey),
                size: 16,
                color: FBColors.tintStrong(type.tintHue),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              type.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FBText.bodyStrong,
            ),
            const SizedBox(height: 3),
            Expanded(
              child: Text(
                type.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: FBText.caption.copyWith(color: FBColors.textMid),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidePanel extends StatelessWidget {
  const _SidePanel({required this.workspace});

  final ReportsWorkspace workspace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FBCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FBHeading(MockReports.previewHeading),
              _PreviewPage(preview: workspace.preview),
            ],
          ),
        ),
        const SizedBox(height: 14),
        FBCard(
          padding: EdgeInsets.zero,
          clip: true,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: FBColors.cardBorder),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        workspace.historyHeading,
                        style: FBText.bodyStrong,
                      ),
                    ),
                    Text(
                      MockReports.viewAllLabel,
                      style: FBText.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: FBColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              for (var i = 0; i < workspace.history.length; i++)
                _HistoryRow(
                  report: workspace.history[i],
                  isLast: i == workspace.history.length - 1,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A miniature render of the report's first page.
class _PreviewPage extends StatelessWidget {
  const _PreviewPage({required this.preview});

  final ReportPreview preview;

  @override
  Widget build(BuildContext context) {
    // The preview mimics print, so it uses a serif face rather than Inter.
    const serif = TextStyle(fontFamilyFallback: ['Georgia', 'serif']);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.chip),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            preview.eyebrow,
            style: serif.copyWith(
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
              color: FBColors.textDim,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            preview.title,
            style: serif.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: FBColors.text,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            preview.periodLabel,
            style: serif.copyWith(fontSize: 9, color: FBColors.textMid),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final (label, value) in preview.figures)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: serif.copyWith(
                          fontSize: 9,
                          color: FBColors.textDim,
                        ),
                      ),
                      Text(
                        value,
                        style: serif.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: FBColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            // Explicit width: the surrounding Column is start-aligned, so
            // without it the container would collapse to the painter's
            // zero intrinsic width.
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [FBColors.blueLight, Colors.white],
              ),
              borderRadius: FBRadius.all(4),
            ),
            child: const CustomPaint(
              size: Size.infinite,
              painter: _SparklinePainter(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            preview.footer,
            style: serif.copyWith(
              fontSize: 8,
              color: FBColors.textDim,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter();

  /// Normalised sample points for the preview thumbnail's revenue line.
  static const _points = <(double, double)>[
    (0.00, 0.80),
    (0.15, 0.64),
    (0.30, 0.56),
    (0.45, 0.60),
    (0.60, 0.36),
    (0.75, 0.24),
    (0.90, 0.32),
    (1.00, 0.20),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    for (var i = 0; i < _points.length; i++) {
      final (fx, fy) = _points[i];
      final point = Offset(fx * size.width, fy * size.height);
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = FBColors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) => false;
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.report, required this.isLast});

  final GeneratedReport report;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isGenerating = report.state == ReportState.generating;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: isLast
          ? null
          : const BoxDecoration(
              border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
            ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isGenerating ? FBColors.amberBg : FBColors.redBg,
              borderRadius: FBRadius.all(6),
            ),
            child: Text(
              'PDF',
              style: FBText.micro.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: isGenerating ? FBColors.amber : FBColors.red,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FBText.label,
                ),
                const SizedBox(height: 1),
                Text(
                  '${report.type} · ${report.sizeLabel} · '
                  '${report.dateLabel}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FBText.micro.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textDim,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isGenerating)
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: FBColors.amber,
              ),
            )
          else
            const Icon(FBIcons.download, size: 15, color: FBColors.blue),
        ],
      ),
    );
  }
}
