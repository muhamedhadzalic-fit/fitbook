import 'package:flutter/material.dart';

import '../mockup/mock_nav.dart';
import '../theme/fb_theme.dart';
import 'fb_surfaces.dart';

/// A dropdown-shaped filter control.
///
/// Options come from reference tables in the real app — a city is never a
/// free-text box.
class FBDropdown extends StatelessWidget {
  const FBDropdown({
    super.key,
    required this.value,
    this.options = const [],
    this.onChanged,
    this.width = 170,
    this.label,
    this.isRequired = false,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String>? onChanged;

  /// Fixed width for toolbar use. Pass null to fill whatever the parent
  /// allows — a Row gives non-flexible children unbounded width, so without a
  /// width here the control would try to grow forever.
  final double? width;

  /// When set, renders a labelled form field instead of a bare control.
  final String? label;

  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    Widget control = Container(
      padding: const EdgeInsets.fromLTRB(14, 9, 12, 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: FBRadius.all(FBRadius.control),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FBText.label.copyWith(color: FBColors.text),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(FBIcons.chevronDown, size: 12, color: FBColors.textMid),
        ],
      ),
    );

    if (width != null) control = SizedBox(width: width, child: control);

    final tappable = options.isEmpty || onChanged == null
        ? control
        : PopupMenuButton<String>(
            tooltip: '',
            position: PopupMenuPosition.under,
            onSelected: onChanged,
            itemBuilder: (context) => [
              for (final option in options)
                PopupMenuItem(
                  value: option,
                  child: Text(option, style: FBText.label),
                ),
            ],
            child: control,
          );

    if (label == null) return tappable;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label!, isRequired: isRequired),
        const SizedBox(height: 6),
        tappable,
      ],
    );
  }
}

/// The search input on every list screen.
///
/// Every data list in this app has at least one search parameter.
class FBSearchField extends StatelessWidget {
  const FBSearchField({
    super.key,
    required this.hint,
    this.controller,
    this.onChanged,
    this.onClear,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final hasText = controller?.text.isNotEmpty ?? false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.control),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(FBIcons.search, size: 15, color: FBColors.textMid),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: FBText.body.copyWith(color: FBColors.text, height: 1.2),
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: FBText.body.copyWith(color: FBColors.textDim),
              ),
            ),
          ),
          if (hasText)
            InkWell(
              onTap: onClear,
              child: const Icon(
                FBIcons.close,
                size: 14,
                color: FBColors.textMid,
              ),
            ),
        ],
      ),
    );
  }
}

/// The global search box in the dashboard header.
///
/// Presentation-only: it names the shortcut that will focus it once a real
/// command palette exists, and is deliberately narrower than the per-list
/// [FBSearchField] it sits above.
class FBGlobalSearch extends StatelessWidget {
  const FBGlobalSearch({
    super.key,
    required this.hint,
    required this.shortcut,
    this.width = 280,
  });

  final String hint;

  /// Keyboard hint rendered as a keycap on the trailing edge.
  final String shortcut;

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.control),
        border: Border.all(color: FBColors.cardBorder),
      ),
      child: Row(
        children: [
          const Icon(FBIcons.search, size: 14, color: FBColors.textMid),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              hint,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FBText.body.copyWith(color: FBColors.textDim),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: FBRadius.all(4),
              border: Border.all(color: FBColors.cardBorder),
            ),
            child: Text(
              shortcut,
              style: FBText.micro.copyWith(
                fontWeight: FontWeight.w500,
                color: FBColors.textDim,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A read-only labelled field in the admin forms.
///
/// The create/edit forms are presentation-only at this stage; real
/// [TextFormField]s with validators replace these when submission lands.
class FBFormField extends StatelessWidget {
  const FBFormField({
    super.key,
    required this.label,
    required this.value,
    this.placeholder = '',
    this.isRequired = false,
    this.isDropdown = false,
    this.isTextarea = false,
    this.chips,
    this.suffix,
  });

  final String label;
  final String value;
  final String placeholder;
  final bool isRequired;
  final bool isDropdown;
  final bool isTextarea;

  /// When set, renders these as removable chips instead of plain text.
  final List<String>? chips;

  final String? suffix;

  @override
  Widget build(BuildContext context) {
    final hasValue = value.isNotEmpty;
    final display = hasValue ? value : placeholder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label, isRequired: isRequired),
        const SizedBox(height: 6),
        if (isTextarea)
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 72),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: _boxDecoration,
            child: Text(
              display,
              style: FBText.body.copyWith(
                color: hasValue ? FBColors.text : FBColors.textDim,
              ),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: _boxDecoration,
            child: Row(
              children: [
                Expanded(
                  child: chips != null
                      ? Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                            for (final chip in chips!) _RemovableChip(chip),
                            Text(
                              MockNav.addMoreLabel,
                              style: FBText.label.copyWith(
                                fontWeight: FontWeight.w500,
                                color: FBColors.textDim,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          display,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FBText.body.copyWith(
                            color: hasValue ? FBColors.text : FBColors.textDim,
                          ),
                        ),
                ),
                if (suffix != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    suffix!,
                    style: FBText.caption.copyWith(
                      fontWeight: FontWeight.w600,
                      color: FBColors.textDim,
                    ),
                  ),
                ],
                if (isDropdown) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    FBIcons.chevronDown,
                    size: 12,
                    color: FBColors.textMid,
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }

  BoxDecoration get _boxDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: FBRadius.all(FBRadius.control),
    border: Border.all(color: FBColors.cardBorder),
  );
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.isRequired});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: FBText.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: FBColors.textMid,
          ),
        ),
        if (isRequired)
          Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              '*',
              style: FBText.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: FBColors.red,
              ),
            ),
          ),
      ],
    );
  }
}

class _RemovableChip extends StatelessWidget {
  const _RemovableChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: FBColors.blueLight,
        borderRadius: FBRadius.all(FBRadius.badge),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: FBText.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: FBColors.blue,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            FBIcons.close,
            size: 10,
            color: FBColors.blue.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}

/// A checkbox-style chip used to toggle report sections.
class FBToggleChip extends StatelessWidget {
  const FBToggleChip({
    super.key,
    required this.label,
    required this.isOn,
    this.onTap,
  });

  final String label;
  final bool isOn;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: FBRadius.all(FBRadius.chip),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 6, 12, 6),
        decoration: BoxDecoration(
          color: isOn ? FBColors.blueLight : Colors.white,
          borderRadius: FBRadius.all(FBRadius.chip),
          border: Border.all(
            color: isOn
                ? FBColors.blue.withValues(alpha: 0.35)
                : FBColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 14,
              height: 14,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isOn ? FBColors.blue : Colors.white,
                borderRadius: FBRadius.all(3),
                border: Border.all(
                  color: isOn ? FBColors.blue : FBColors.cardBorder,
                  width: 1.5,
                ),
              ),
              child: isOn
                  ? const Icon(FBIcons.check, size: 9, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: FBText.label.copyWith(
                color: isOn ? FBColors.blue : FBColors.textMid,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A tab in the status filter row above a table.
class FBStatusTab extends StatelessWidget {
  const FBStatusTab({
    super.key,
    required this.label,
    required this.count,
    required this.isActive,
    this.onTap,
  });

  final String label;
  final int count;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: FBRadius.all(FBRadius.chip),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? FBColors.navy : Colors.transparent,
          borderRadius: FBRadius.all(FBRadius.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: FBText.label.copyWith(
                color: isActive ? Colors.white : FBColors.textMid,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '$count',
              style: FBText.micro.copyWith(
                color: (isActive ? Colors.white : FBColors.textMid).withValues(
                  alpha: 0.7,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A titled heading above a block of detail fields.
class FBHeading extends StatelessWidget {
  const FBHeading(this.text, {super.key, this.bottomSpacing = 10});

  final String text;
  final double bottomSpacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomSpacing),
      child: Text(
        text.toUpperCase(),
        style: FBText.caption.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: FBColors.textDim,
        ),
      ),
    );
  }
}

/// A read-only key/value pair.
class FBReadField extends StatelessWidget {
  const FBReadField({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: FBText.micro.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: FBColors.textDim,
          ),
        ),
        const SizedBox(height: 4),
        Text(value, style: FBText.body.copyWith(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

/// The filter bar above a list: one search field plus a set of dropdowns.
///
/// Lays out as a single row when there is room, and stacks the dropdowns
/// underneath the search field when the window is too narrow — an admin
/// resizing the window must never push controls off the edge.
class FBFilterBar extends StatelessWidget {
  const FBFilterBar({
    super.key,
    required this.search,
    required this.filters,
    this.trailing,
    this.padding = const EdgeInsets.all(12),
  });

  final Widget search;
  final List<Widget> filters;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  /// Width each dropdown asks for, matched to [FBDropdown]'s default.
  static const _filterWidth = 170.0;

  /// Space the search field needs before stacking becomes the better layout.
  static const _minSearchWidth = 220.0;

  @override
  Widget build(BuildContext context) {
    final all = [...filters, ?trailing];

    return FBCard(
      radius: FBRadius.button,
      padding: padding,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final filtersWidth = all.length * _filterWidth + all.length * 8;
          final fitsOneRow =
              constraints.maxWidth - filtersWidth >= _minSearchWidth;

          if (fitsOneRow) {
            return Row(
              children: [
                Expanded(child: search),
                for (final filter in all) ...[const SizedBox(width: 8), filter],
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              search,
              const SizedBox(height: 8),
              Wrap(spacing: 8, runSpacing: 8, children: all),
            ],
          );
        },
      ),
    );
  }
}
