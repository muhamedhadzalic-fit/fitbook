import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// Trainers management — the reference CRUD screen: searchable table, create
/// modal, and a delete flow that refuses to hard-delete a trainer who still has
/// bookings.
class TrainersScreen extends StatefulWidget {
  const TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => TrainersScreenState();
}

class TrainersScreenState extends State<TrainersScreen> {
  final _searchController = TextEditingController();

  String _query = '';
  String _speciality = MockTrainers.specialityOptions.first;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TrainerRow> get _visibleRows {
    return Mockup.trainers.where((t) {
      final matchesQuery =
          _query.isEmpty || t.name.toLowerCase().contains(_query.toLowerCase());
      final matchesSpeciality =
          _speciality == MockTrainers.specialityOptions.first ||
          t.specialities.contains(_speciality);
      return matchesQuery && matchesSpeciality;
    }).toList();
  }

  /// Opens the create form. Public so the shell's header button can call it.
  Future<void> openCreateForm() => showDialog<void>(
    context: context,
    barrierColor: const Color(0x730F172A),
    builder: (context) => CreateTrainerDialog(form: Mockup.createTrainerForm),
  );

  Future<void> _confirmDelete(TrainerRow trainer) => showDialog<void>(
    context: context,
    barrierColor: const Color(0x660F172A),
    builder: (context) => DeleteTrainerDialog(trainer: trainer),
  );

  static (Color, Color, Color) _statusTint(
    TrainerStatus status,
  ) => switch (status) {
    TrainerStatus.active => (FBColors.greenBg, FBColors.green, FBColors.green),
    TrainerStatus.pending => (FBColors.amberBg, FBColors.amber, FBColors.amber),
    TrainerStatus.inactive => (
      FBColors.card,
      FBColors.textMid,
      FBColors.textDim,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final rows = _visibleRows;

    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 20, 28, 28),
      children: [
        FBFilterBar(
          padding: const EdgeInsets.all(14),
          search: FBSearchField(
            hint: MockTrainers.searchHint,
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
            onClear: () => setState(() {
              _searchController.clear();
              _query = '';
            }),
          ),
          filters: [
            FBDropdown(
              value: _speciality,
              options: MockTrainers.specialityOptions,
              onChanged: (v) => setState(() => _speciality = v),
            ),
            FBDropdown(
              value: MockTrainers.cityOptions.first,
              options: MockTrainers.cityOptions,
              onChanged: (_) {},
            ),
            FBDropdown(
              value: MockTrainers.statusOptions.first,
              options: MockTrainers.statusOptions,
              onChanged: (_) {},
            ),
          ],
        ),
        const SizedBox(height: 14),
        AdminTable<TrainerRow>(
          rows: rows,
          emptyMessage: MockTrainers.emptyMessage,
          columns: [
            TableColumnSpec(
              header: 'TRAINER',
              width: const FlexWidth(2),
              build: (context, row) => TableIdentityCell(
                avatar: FBAvatar(
                  name: row.name,
                  hue: row.identityHue,
                  size: 36,
                ),
                primary: row.name,
                secondary: row.email,
              ),
            ),
            TableColumnSpec(
              header: 'SPECIALIZATIONS',
              width: const FlexWidth(1.6),
              build: (context, row) => Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [for (final s in row.specialities) FBTag(label: s)],
              ),
            ),
            TableColumnSpec(
              header: 'CITY',
              width: const FlexWidth(1),
              build: (context, row) => Row(
                children: [
                  const Icon(FBIcons.pin, size: 12, color: FBColors.textMid),
                  const SizedBox(width: 5),
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
              header: 'PRICE/H',
              width: const FixedWidth(76),
              build: (context, row) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${row.hourlyRate}',
                    style: FBText.body.copyWith(
                      fontWeight: FontWeight.w700,
                      color: FBColors.navy,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    MockTrainers.rateSuffix,
                    style: FBText.micro.copyWith(
                      fontWeight: FontWeight.w500,
                      color: FBColors.textDim,
                    ),
                  ),
                ],
              ),
            ),
            TableColumnSpec(
              header: 'STATUS',
              width: const FixedWidth(104),
              build: (context, row) {
                final (bg, fg, dot) = _statusTint(row.status);
                final name = row.status.name;
                return FBBadge(
                  label: name[0].toUpperCase() + name.substring(1),
                  background: bg,
                  foreground: fg,
                  showDot: true,
                  dotColor: dot,
                );
              },
            ),
            TableColumnSpec(
              header: 'ACTIONS',
              width: const FixedWidth(72),
              alignment: Alignment.centerRight,
              build: (context, row) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TableActionButton(
                    icon: FBIcons.edit,
                    tooltip: MockTrainers.editTooltip,
                  ),
                  const SizedBox(width: 6),
                  // A trainer with upcoming bookings is never hard-deleted;
                  // the action is disabled and says why.
                  TableActionButton(
                    icon: FBIcons.trash,
                    tooltip: MockTrainers.deleteTooltip,
                    isDestructive: true,
                    isDisabled: !row.canDelete,
                    disabledReason: MockTrainers.deleteDisabledReason(
                      row.activeBookings,
                    ),
                    onPressed: () => _confirmDelete(row),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TablePagination(
          summary: MockTrainers.pageSummary(
            rows.length,
            Mockup.trainers.length,
          ),
          pageCount: 3,
          currentPage: 1,
        ),
      ],
    );
  }
}

/// Confirmation for deleting a trainer.
///
/// Two shapes: a straight destructive confirmation, and a blocked variant that
/// explains the constraint and offers deactivation instead of deletion.
class DeleteTrainerDialog extends StatelessWidget {
  const DeleteTrainerDialog({super.key, required this.trainer});

  final TrainerRow trainer;

  @override
  Widget build(BuildContext context) {
    final isBlocked = !trainer.canDelete;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: FBRadius.all(FBRadius.cardLg),
      ),
      child: SizedBox(
        width: 440,
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
                      color: isBlocked ? FBColors.amberBg : FBColors.redBg,
                      borderRadius: FBRadius.all(FBRadius.button),
                    ),
                    child: Icon(
                      FBIcons.alert,
                      size: 22,
                      color: isBlocked ? FBColors.amber : FBColors.red,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isBlocked
                              ? MockTrainers.deleteBlockedTitle
                              : MockTrainers.deleteConfirmTitle(trainer.name),
                          style: FBText.titleMd.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isBlocked
                              ? MockTrainers.deleteBlockedBody(
                                  trainer.name,
                                  trainer.activeBookings,
                                )
                              : MockTrainers.deleteWarning,
                          style: FBText.body.copyWith(
                            color: FBColors.textMid,
                            height: 1.5,
                          ),
                        ),
                        if (isBlocked) ...[
                          const SizedBox(height: 12),
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
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    MockTrainers.deleteBlockedCount(
                                      trainer.activeBookings,
                                    ),
                                    style: FBText.label.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: FBColors.textMid,
                                    ),
                                  ),
                                ),
                                Text(
                                  MockTrainers.deleteBlockedViewBookings,
                                  style: FBText.label.copyWith(
                                    color: FBColors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FBButton(
                    label: isBlocked
                        ? MockTrainers.deleteBlockedAcknowledge
                        : MockTrainers.deleteCancelLabel,
                    kind: FBButtonKind.outline,
                    height: 40,
                    fontSize: 13,
                    radius: FBRadius.control,
                    expand: false,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 10),
                  if (isBlocked)
                    FBButton(
                      label: MockTrainers.deleteBlockedAlternative,
                      height: 40,
                      fontSize: 13,
                      radius: FBRadius.control,
                      expand: false,
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  else
                    FBButton(
                      label: MockTrainers.deleteConfirmLabel,
                      kind: FBButtonKind.destructive,
                      height: 40,
                      fontSize: 13,
                      radius: FBRadius.control,
                      expand: false,
                      onPressed: () => Navigator.of(context).pop(),
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

/// The create-trainer modal.
class CreateTrainerDialog extends StatelessWidget {
  const CreateTrainerDialog({super.key, required this.form});

  final CreateTrainerForm form;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(
        borderRadius: FBRadius.all(FBRadius.cardLg),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 720),
        child: Column(
          children: [
            _dialogHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _photoRow(),
                    const SizedBox(height: 22),
                    _formGrid(),
                  ],
                ),
              ),
            ),
            _dialogFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _dialogHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(form.title, style: FBText.titleMd),
                const SizedBox(height: 2),
                Text(
                  form.subtitle,
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textDim,
                  ),
                ),
              ],
            ),
          ),
          // Close button, top-right.
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: FBRadius.all(FBRadius.chip),
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FBColors.card,
                borderRadius: FBRadius.all(FBRadius.chip),
              ),
              child: const Icon(
                FBIcons.close,
                size: 16,
                color: FBColors.textMid,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 96,
          height: 96,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: FBColors.card,
            borderRadius: FBRadius.all(FBRadius.cardLg),
            border: Border.all(color: FBColors.cardBorder, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(FBIcons.imageAdd, size: 22, color: FBColors.textMid),
              const SizedBox(height: 4),
              Text(
                form.photoEmptyLabel,
                style: FBText.micro.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: FBColors.textDim,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(form.photoTitle, style: FBText.label),
              const SizedBox(height: 4),
              Text(
                form.photoHint,
                style: FBText.label.copyWith(
                  fontWeight: FontWeight.w500,
                  color: FBColors.textMid,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  FBTextButton(
                    label: form.uploadLabel,
                    icon: FBIcons.upload,
                    isPrimary: true,
                  ),
                  const SizedBox(width: 8),
                  FBTextButton(label: form.libraryLabel),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formGrid() {
    final rows = <Widget>[];
    var index = 0;

    while (index < form.fields.length) {
      final field = form.fields[index];
      if (field.spansRow) {
        rows.add(_field(field));
        index += 1;
      } else {
        final next = index + 1 < form.fields.length
            ? form.fields[index + 1]
            : null;
        rows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _field(field)),
              const SizedBox(width: 14),
              Expanded(
                child: next != null && !next.spansRow
                    ? _field(next)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
        index += next != null && !next.spansRow ? 2 : 1;
      }
      rows.add(const SizedBox(height: 14));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }

  Widget _field(FormFieldSpec spec) => FBFormField(
    label: spec.label,
    value: spec.value,
    placeholder: spec.placeholder,
    isRequired: spec.isRequired,
    isDropdown: spec.isDropdown,
    isTextarea: spec.isTextarea,
    suffix: spec.suffix,
    chips: spec.isChips ? spec.value.split(', ') : null,
  );

  Widget _dialogFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: const BoxDecoration(
        color: FBColors.card,
        border: Border(top: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  '*',
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w700,
                    color: FBColors.red,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  form.requiredNote,
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textDim,
                  ),
                ),
              ],
            ),
          ),
          FBButton(
            label: form.cancelLabel,
            kind: FBButtonKind.outline,
            height: 40,
            fontSize: 13,
            radius: FBRadius.control,
            expand: false,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 10),
          FBButton(
            label: form.submitLabel,
            kind: FBButtonKind.accent,
            height: 40,
            fontSize: 13,
            radius: FBRadius.control,
            expand: false,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
