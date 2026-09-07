import 'package:flutter/material.dart';

import '../theme/fb_theme.dart';

/// A rounded selectable chip — the design's filter and speciality selector.
class FBChoiceChip extends StatelessWidget {
  const FBChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.trailingCount,
    this.fontSize = 13,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  /// Optional count rendered in a nested bubble, as on the notification tabs.
  final int? trailingCount;

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? FBColors.navy : Colors.white,
      borderRadius: FBRadius.all(FBRadius.pill),
      child: InkWell(
        onTap: onTap,
        borderRadius: FBRadius.all(FBRadius.pill),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: FBRadius.all(FBRadius.pill),
            border: Border.all(
              color: selected ? FBColors.navy : FBColors.cardBorder,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : FBColors.textMid,
                ),
              ),
              if (trailingCount != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white.withValues(alpha: 0.22)
                        : FBColors.card,
                    borderRadius: FBRadius.all(FBRadius.pill),
                  ),
                  child: Text(
                    '$trailingCount',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : FBColors.textMid,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// The inset segmented control used above reservation and booking lists.
class FBSegmentedTabs extends StatelessWidget {
  const FBSegmentedTabs({
    super.key,
    required this.labels,
    required this.counts,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final List<int> counts;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: FBColors.card,
        borderRadius: FBRadius.all(FBRadius.control),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: i == selectedIndex ? Colors.white : null,
                    borderRadius: FBRadius.all(7),
                    boxShadow: i == selectedIndex
                        ? const [
                            BoxShadow(
                              color: Color(0x140F172A),
                              offset: Offset(0, 1),
                              blurRadius: 3,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        labels[i],
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: i == selectedIndex
                              ? FBColors.text
                              : FBColors.textMid,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${counts[i]}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              (i == selectedIndex
                                      ? FBColors.text
                                      : FBColors.textMid)
                                  .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A read-only labelled field, as the mockups render form inputs.
///
/// The registration and report screens are presentation-only at this stage, so
/// their inputs are display surfaces rather than live [TextField]s. Real
/// [TextField]s replace these when validation and submission land.
class FBReadField extends StatelessWidget {
  const FBReadField({
    super.key,
    required this.label,
    required this.value,
    this.suffix,
    this.isDropdown = false,
    this.background,
  });

  final String label;
  final String value;
  final String? suffix;
  final bool isDropdown;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FBText.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: FBColors.textMid,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: background ?? FBColors.card,
            borderRadius: FBRadius.all(FBRadius.button),
            border: Border.all(color: FBColors.cardBorder),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: FBText.bodyLg.copyWith(color: FBColors.text),
                ),
              ),
              if (suffix != null)
                Text(
                  suffix!,
                  style: FBText.caption.copyWith(
                    fontWeight: FontWeight.w600,
                    color: FBColors.blue,
                  ),
                ),
              if (isDropdown)
                const Icon(
                  FBIcons.chevronDown,
                  size: 14,
                  color: FBColors.textMid,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The design's pill switch.
class FBSwitch extends StatelessWidget {
  const FBSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 36,
        height: 22,
        decoration: BoxDecoration(
          color: value ? FBColors.blue : FBColors.cardBorder,
          borderRadius: FBRadius.all(FBRadius.button),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.all(2),
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x330F172A),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A square checkbox in the design's own idiom.
class FBCheckbox extends StatelessWidget {
  const FBCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 18,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!value),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: value ? FBColors.blue : Colors.white,
          borderRadius: FBRadius.all(size / 3.5),
          border: Border.all(
            color: value ? FBColors.blue : FBColors.cardBorder,
            width: 1.5,
          ),
        ),
        child: value
            ? Icon(FBIcons.check, size: size * 0.62, color: Colors.white)
            : null,
      ),
    );
  }
}
