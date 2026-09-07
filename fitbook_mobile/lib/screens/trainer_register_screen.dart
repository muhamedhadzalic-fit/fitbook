import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.2 · Trainer registration — specializations and rate.
///
/// Trainers self-register here into the `Pending` state; an admin verifies them
/// from the desktop app before they can accept bookings. The notice at the
/// bottom of the form says so explicitly.
class TrainerRegisterScreen extends StatefulWidget {
  const TrainerRegisterScreen({super.key, this.onBack, this.onContinue});

  final VoidCallback? onBack;
  final VoidCallback? onContinue;

  @override
  State<TrainerRegisterScreen> createState() => _TrainerRegisterScreenState();
}

class _TrainerRegisterScreenState extends State<TrainerRegisterScreen> {
  final _form = Mockup.trainerRegistration;

  late final Set<String> _selected = {
    for (final s in _form.specialities)
      if (s.isSelected) s.label,
  };

  static const _maxSpecialities = 4;

  void _toggle(String label) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else if (_selected.length < _maxSpecialities) {
        _selected.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FBColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  FBIconButton(icon: FBIcons.back, onPressed: widget.onBack),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _form.flowLabel,
                          style: FBText.caption.copyWith(
                            color: FBColors.textDim,
                          ),
                        ),
                        Text(_form.stepTitle, style: FBText.h4),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  for (var i = 1; i <= _form.stepCount; i++) ...[
                    if (i > 1) const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: i <= _form.currentStep
                              ? FBColors.blue
                              : FBColors.cardBorder,
                          borderRadius: FBRadius.all(2),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              _PhotoRow(form: _form),
              const SizedBox(height: 18),
              Text(
                _form.specialityPrompt,
                style: FBText.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: FBColors.textMid,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final s in _form.specialities)
                    FBChoiceChip(
                      label: s.label,
                      selected: _selected.contains(s.label),
                      fontSize: 12,
                      onTap: () => _toggle(s.label),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              for (final f in _form.fields)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FBReadField(
                    label: f.label,
                    value: f.value,
                    isDropdown: f.isDropdown,
                  ),
                ),
              Text(
                _form.certificationLabel,
                style: FBText.caption.copyWith(
                  fontWeight: FontWeight.w600,
                  color: FBColors.textMid,
                ),
              ),
              const SizedBox(height: 5),
              _DocumentRow(document: _form.certification),
              const SizedBox(height: 18),
              FBNotice(
                background: FBColors.amberBg,
                icon: FBIcons.alert,
                iconColor: FBColors.amber,
                child: Text(
                  _form.verificationNotice,
                  style: FBText.caption.copyWith(
                    color: FBColors.text,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: FBButton(
                      label: MockChrome.backLabel,
                      kind: FBButtonKind.outline,
                      onPressed: widget.onBack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: FBButton(
                      label: MockChrome.continueLabel,
                      onPressed: widget.onContinue,
                    ),
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

class _PhotoRow extends StatelessWidget {
  const _PhotoRow({required this.form});

  final TrainerRegistration form;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 76,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: FBColors.card,
                borderRadius: FBRadius.all(FBRadius.cardLg),
                border: Border.all(color: FBColors.cardBorder, width: 2),
              ),
              child: FBAvatar(
                name: form.photoOwnerName,
                hue: form.photoHue,
                size: 68,
              ),
            ),
            Positioned(
              bottom: -4,
              right: -4,
              child: Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: FBColors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(FBIcons.plus, size: 12, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(form.photoTitle, style: FBText.bodyStrong),
              const SizedBox(height: 3),
              Text(
                form.photoHint,
                style: FBText.caption.copyWith(
                  color: FBColors.textMid,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({required this.document});

  final UploadedDocument document;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.button),
        border: Border.all(color: FBColors.cardBorder, width: 1.5),
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
              style: TextStyle(
                fontFamily: 'Inter',
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
                const SizedBox(height: 1),
                Text(
                  document.detail,
                  style: FBText.micro.copyWith(
                    color: FBColors.textDim,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(FBIcons.check, size: 16, color: FBColors.green),
        ],
      ),
    );
  }
}
