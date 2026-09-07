import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 6.2 · Trainer verification — the queue where `Pending` trainers are approved
/// or rejected.
///
/// A master-detail pair: the queue on the left, the selected application on the
/// right. Rejection requires a reason, so the reject action opens a dialog
/// rather than firing straight away.
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  int _selectedIndex = 0;

  Future<void> _confirmApprove(VerificationApplication application) =>
      showDialog<void>(
        context: context,
        barrierColor: const Color(0x660F172A),
        builder: (context) =>
            _DecisionDialog(application: application, isApproval: true),
      );

  Future<void> _confirmReject(VerificationApplication application) =>
      showDialog<void>(
        context: context,
        barrierColor: const Color(0x660F172A),
        builder: (context) =>
            _DecisionDialog(application: application, isApproval: false),
      );

  @override
  Widget build(BuildContext context) {
    final queue = Mockup.verificationQueue;
    final selected = queue[_selectedIndex];

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              // The queue gives ground first when the window narrows; the
              // application detail is the part that needs the room.
              width: constraints.maxWidth < 900 ? 260 : 320,
              child: _Queue(
                applications: queue,
                selectedIndex: _selectedIndex,
                onSelected: (i) => setState(() => _selectedIndex = i),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _ApplicationDetail(
                application: selected,
                onApprove: () => _confirmApprove(selected),
                onReject: () => _confirmReject(selected),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Queue extends StatelessWidget {
  const _Queue({
    required this.applications,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<VerificationApplication> applications;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: EdgeInsets.zero,
      clip: true,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(MockVerification.queueHeading, style: FBText.bodyStrong),
                const SizedBox(height: 2),
                Text(
                  MockVerification.queueSubtitle(applications.length),
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: applications.length,
              itemBuilder: (context, i) {
                final application = applications[i];
                final isSelected = i == selectedIndex;
                return InkWell(
                  onTap: () => onSelected(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? FBColors.blueLight : Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: isSelected
                              ? FBColors.blue
                              : Colors.transparent,
                          width: 3,
                        ),
                        bottom: const BorderSide(color: FBColors.cardBorder),
                      ),
                    ),
                    child: Row(
                      children: [
                        FBAvatar(
                          name: application.name,
                          hue: application.identityHue,
                          size: 36,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                application.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FBText.label,
                              ),
                              const SizedBox(height: 1),
                              Text(
                                '${application.specialities.join(' · ')} · '
                                '${application.city}',
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
                        Text(
                          application.submittedLabel,
                          textAlign: TextAlign.right,
                          style: FBText.micro.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: FBColors.textDim,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ApplicationDetail extends StatelessWidget {
  const _ApplicationDetail({
    required this.application,
    required this.onApprove,
    required this.onReject,
  });

  final VerificationApplication application;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final actions = MockVerification.actions;

    return FBCard(
      padding: EdgeInsets.zero,
      clip: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FBAvatar(
                    name: application.name,
                    hue: application.identityHue,
                    size: 88,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                application.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: FBText.h2,
                              ),
                            ),
                            const SizedBox(width: 10),
                            FBBadge(
                              label: actions.pendingBadge,
                              background: FBColors.amberBg,
                              foreground: FBColors.amber,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          application.summary,
                          style: FBText.body.copyWith(color: FBColors.textMid),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          MockVerification.submittedSummary(
                            application.submittedLabel,
                            application.proposedRate,
                          ),
                          style: FBText.label.copyWith(
                            fontWeight: FontWeight.w500,
                            color: FBColors.textDim,
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Wraps so the three decisions stay reachable when
                        // the window is narrow.
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FBButton(
                              label: actions.approve,
                              kind: FBButtonKind.positive,
                              icon: FBIcons.check,
                              height: 38,
                              fontSize: 12,
                              radius: FBRadius.control,
                              expand: false,
                              onPressed: onApprove,
                            ),
                            FBButton(
                              label: actions.reject,
                              kind: FBButtonKind.danger,
                              icon: FBIcons.close,
                              height: 38,
                              fontSize: 12,
                              radius: FBRadius.control,
                              expand: false,
                              onPressed: onReject,
                            ),
                            FBButton(
                              label: actions.requestInfo,
                              kind: FBButtonKind.outline,
                              height: 38,
                              fontSize: 12,
                              radius: FBRadius.control,
                              expand: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FBHeading(MockVerification.checklistHeading),
                        for (final check in application.checklist)
                          _ChecklistRow(check: check),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FBHeading(MockVerification.documentsHeading),
                        for (final document in application.documents)
                          _DocumentRow(document: document),
                        const SizedBox(height: 18),
                        const FBHeading(MockVerification.bioHeading),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: FBColors.card,
                            borderRadius: FBRadius.all(FBRadius.control),
                            border: Border.all(color: FBColors.cardBorder),
                          ),
                          child: Text(
                            application.bio,
                            style: FBText.label.copyWith(
                              fontWeight: FontWeight.w500,
                              color: FBColors.textMid,
                              height: 1.55,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChecklistRow extends StatelessWidget {
  const _ChecklistRow({required this.check});

  final VerificationCheck check;

  ({Color bg, Color fg, IconData icon}) get _tone => switch (check.state) {
    CheckState.ok => (
      bg: FBColors.greenBg,
      fg: FBColors.green,
      icon: FBIcons.check,
    ),
    CheckState.warning => (
      bg: FBColors.amberBg,
      fg: FBColors.amber,
      icon: FBIcons.alert,
    ),
    CheckState.failed => (
      bg: FBColors.redBg,
      fg: FBColors.red,
      icon: FBIcons.close,
    ),
    CheckState.pending => (
      bg: FBColors.card,
      fg: FBColors.textDim,
      icon: FBIcons.clock,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final tone = _tone;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.bg,
              borderRadius: FBRadius.all(FBRadius.chip),
            ),
            child: Icon(tone.icon, size: 14, color: tone.fg),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(check.label, style: FBText.label),
                const SizedBox(height: 1),
                Text(
                  check.detail,
                  style: FBText.caption.copyWith(color: FBColors.textDim),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({required this.document});

  final UploadedDocument document;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: FBColors.blueLight,
              borderRadius: FBRadius.all(6),
            ),
            child: Text(
              document.kind,
              style: FBText.micro.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: FBColors.blue,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FBText.label,
                ),
                Text(
                  MockVerification.documentByline(
                    document.sizeLabel,
                    document.uploadedLabel,
                  ),
                  style: FBText.micro.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textDim,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            MockVerification.viewDocumentLabel,
            style: FBText.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: FBColors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

/// Approve / reject confirmation.
///
/// Rejection captures a reason — the trainer is told why, and the reason is
/// written to the audit trail.
class _DecisionDialog extends StatefulWidget {
  const _DecisionDialog({required this.application, required this.isApproval});

  final VerificationApplication application;
  final bool isApproval;

  @override
  State<_DecisionDialog> createState() => _DecisionDialogState();
}

class _DecisionDialogState extends State<_DecisionDialog> {
  final _reasonController = TextEditingController();

  /// A rejection with no reason is not submittable.
  bool get _canSubmit =>
      widget.isApproval || _reasonController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isApproval = widget.isApproval;
    final name = widget.application.name;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: FBRadius.all(FBRadius.cardLg),
      ),
      child: SizedBox(
        width: 460,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isApproval ? FBColors.greenBg : FBColors.redBg,
                      borderRadius: FBRadius.all(FBRadius.button),
                    ),
                    child: Icon(
                      isApproval ? FBIcons.check : FBIcons.close,
                      size: 22,
                      color: isApproval ? FBColors.green : FBColors.red,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isApproval
                              ? MockVerification.approveTitle(name)
                              : MockVerification.rejectTitle(name),
                          style: FBText.titleMd.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isApproval
                              ? MockVerification.approveBody(name)
                              : MockVerification.rejectBody(name),
                          style: FBText.body.copyWith(
                            color: FBColors.textMid,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (!isApproval) ...[
                const SizedBox(height: 16),
                Text(
                  MockVerification.reasonLabel,
                  style: FBText.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: FBColors.textMid,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  controller: _reasonController,
                  onChanged: (_) => setState(() {}),
                  maxLines: 3,
                  style: FBText.body.copyWith(color: FBColors.text),
                  decoration: InputDecoration(
                    hintText: MockVerification.reasonHint,
                    hintStyle: FBText.body.copyWith(color: FBColors.textDim),
                    filled: true,
                    fillColor: FBColors.card,
                    border: OutlineInputBorder(
                      borderRadius: FBRadius.all(FBRadius.control),
                      borderSide: const BorderSide(color: FBColors.cardBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: FBRadius.all(FBRadius.control),
                      borderSide: const BorderSide(color: FBColors.cardBorder),
                    ),
                  ),
                ),
                if (!_canSubmit) ...[
                  const SizedBox(height: 6),
                  // Validation message sits below the control, not inside it.
                  Text(
                    MockVerification.reasonRequired,
                    style: FBText.caption.copyWith(color: FBColors.red),
                  ),
                ],
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FBButton(
                    label: MockVerification.cancelLabel,
                    kind: FBButtonKind.outline,
                    height: 40,
                    fontSize: 13,
                    radius: FBRadius.control,
                    expand: false,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 10),
                  FBButton(
                    label: isApproval
                        ? MockVerification.approveConfirmLabel
                        : MockVerification.rejectConfirmLabel,
                    kind: isApproval
                        ? FBButtonKind.positive
                        : FBButtonKind.destructive,
                    height: 40,
                    fontSize: 13,
                    radius: FBRadius.control,
                    expand: false,
                    onPressed: _canSubmit
                        ? () => Navigator.of(context).pop()
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
