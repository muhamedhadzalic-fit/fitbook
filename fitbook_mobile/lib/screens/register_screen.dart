import 'package:flutter/material.dart';

import '../mockup/mockup.dart';
import '../theme/fb_theme.dart';
import '../widgets/widgets.dart';

/// 7.1b · User registration.
///
/// A single registration form with a role chooser — the client and trainer
/// paths diverge after this step, they do not get separate screens. Whatever
/// the user picks here, the server ignores any client-supplied role claim and
/// assigns the role itself.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, this.onBack, this.onContinue});

  final VoidCallback? onBack;
  final ValueChanged<String>? onContinue;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registration = Mockup.memberRegistration;

  late String _roleId = _registration.selectedRoleId;
  bool _consented = true;

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
              FBIconButton(icon: FBIcons.back, onPressed: widget.onBack),
              const SizedBox(height: 18),
              Text(_registration.title, style: FBText.h1),
              const SizedBox(height: 6),
              Text(
                _registration.stepLabel,
                style: FBText.bodyLg.copyWith(color: FBColors.textMid),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  for (var i = 0; i < _registration.roles.length; i++) ...[
                    if (i > 0) const SizedBox(width: 8),
                    Expanded(
                      child: _RoleCard(
                        choice: _registration.roles[i],
                        isSelected: _registration.roles[i].id == _roleId,
                        onTap: () =>
                            setState(() => _roleId = _registration.roles[i].id),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 18),
              for (final f in _registration.fields)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FBReadField(
                    label: f.label,
                    value: f.value,
                    suffix: f.suffix,
                    isDropdown: f.isDropdown,
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                children: [
                  FBCheckbox(
                    value: _consented,
                    onChanged: (v) => setState(() => _consented = v),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _registration.consentLabel,
                      style: FBText.label.copyWith(
                        fontWeight: FontWeight.w500,
                        color: FBColors.textMid,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              FBButton(
                label: _registration.submitLabel,
                height: 50,
                onPressed: _consented
                    ? () => widget.onContinue?.call(_roleId)
                    : null,
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  _registration.signInPrompt,
                  style: FBText.label.copyWith(
                    fontWeight: FontWeight.w500,
                    color: FBColors.textMid,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.choice,
    required this.isSelected,
    required this.onTap,
  });

  final RoleChoice choice;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? FBColors.blueLight : Colors.white,
          borderRadius: FBRadius.all(FBRadius.card),
          border: Border.all(
            color: isSelected ? FBColors.blue : FBColors.cardBorder,
            width: isSelected ? 2 : 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              choice.title,
              style: FBText.bodyStrong.copyWith(
                color: isSelected ? FBColors.blue : FBColors.text,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              choice.subtitle,
              style: FBText.caption.copyWith(color: FBColors.textMid),
            ),
          ],
        ),
      ),
    );
  }
}
