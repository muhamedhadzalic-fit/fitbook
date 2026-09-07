import 'package:flutter/material.dart';

import '../mockup/mock_nav.dart';
import '../theme/fb_theme.dart';
import 'fb_surfaces.dart';

/// How wide a table column is.
sealed class ColumnWidth {
  const ColumnWidth();
}

/// A fixed pixel width.
class FixedWidth extends ColumnWidth {
  const FixedWidth(this.pixels);

  final double pixels;
}

/// A share of the remaining space.
class FlexWidth extends ColumnWidth {
  const FlexWidth([this.factor = 1]);

  final double factor;
}

/// One column of an [AdminTable].
class TableColumnSpec<T> {
  const TableColumnSpec({
    required this.header,
    required this.width,
    required this.build,
    this.alignment = Alignment.centerLeft,
  });

  final String header;
  final ColumnWidth width;

  /// Renders the cell for one row.
  final Widget Function(BuildContext context, T row) build;

  final Alignment alignment;
}

/// The admin data table: tinted header strip, hairline-separated rows.
///
/// Every list in this app is paginated — [footer] carries the page state, and
/// no screen ever asks for an unbounded "retrieve all".
class AdminTable<T> extends StatelessWidget {
  const AdminTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.selectedRow,
    this.header,
    this.footer,
    this.rowPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.headerPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 10,
    ),
    this.emptyMessage = MockNav.tableEmptyFallback,
  });

  final List<TableColumnSpec<T>> columns;
  final List<T> rows;
  final ValueChanged<T>? onRowTap;

  /// Row rendered with the selected tint.
  final T? selectedRow;

  /// Optional title strip above the header row.
  final Widget? header;

  /// Optional footer inside the card, typically pagination.
  final Widget? footer;

  final EdgeInsetsGeometry rowPadding;
  final EdgeInsetsGeometry headerPadding;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return FBCard(
      padding: EdgeInsets.zero,
      clip: true,
      child: Column(
        children: [
          ?header,
          _headerRow(),
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                emptyMessage,
                style: FBText.body.copyWith(color: FBColors.textMid),
              ),
            )
          else
            for (var i = 0; i < rows.length; i++) _dataRow(context, i),
          ?footer,
        ],
      ),
    );
  }

  Widget _headerRow() {
    return Container(
      padding: headerPadding,
      decoration: const BoxDecoration(
        color: FBColors.card,
        border: Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < columns.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            _sized(
              columns[i].width,
              Align(
                alignment: columns[i].alignment,
                child: Text(
                  columns[i].header,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: FBColors.textDim,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _dataRow(BuildContext context, int index) {
    final row = rows[index];
    final isSelected = selectedRow != null && selectedRow == row;
    final isLast = index == rows.length - 1;

    final content = Container(
      padding: rowPadding,
      decoration: BoxDecoration(
        color: isSelected ? FBColors.blueLight : Colors.white,
        border: isLast && footer == null
            ? null
            : const Border(bottom: BorderSide(color: FBColors.cardBorder)),
      ),
      child: Row(
        children: [
          for (var i = 0; i < columns.length; i++) ...[
            if (i > 0) const SizedBox(width: 12),
            _sized(
              columns[i].width,
              Align(
                alignment: columns[i].alignment,
                child: columns[i].build(context, row),
              ),
            ),
          ],
        ],
      ),
    );

    if (onRowTap == null) return content;
    return InkWell(onTap: () => onRowTap!(row), child: content);
  }

  Widget _sized(ColumnWidth width, Widget child) => switch (width) {
    FixedWidth(:final pixels) => SizedBox(width: pixels, child: child),
    FlexWidth(:final factor) => Expanded(
      // Flex is an int, so fractional factors are scaled to hundredths.
      flex: (factor * 100).round(),
      child: child,
    ),
  };
}

/// The standard name-with-avatar cell.
class TableIdentityCell extends StatelessWidget {
  const TableIdentityCell({
    super.key,
    required this.avatar,
    required this.primary,
    this.secondary,
    this.primaryWeight = FontWeight.w600,
  });

  final Widget avatar;
  final String primary;
  final String? secondary;
  final FontWeight primaryWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        avatar,
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                primary,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FBText.label.copyWith(fontWeight: primaryWeight),
              ),
              if (secondary != null)
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Text(
                    secondary!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FBText.micro.copyWith(
                      fontWeight: FontWeight.w500,
                      color: FBColors.textDim,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A small square icon button used in table action columns.
class TableActionButton extends StatelessWidget {
  const TableActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.isDestructive = false,
    this.isDisabled = false,
    this.disabledReason,
    this.filled,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool isDestructive;

  /// Renders greyed out and unclickable.
  final bool isDisabled;

  /// Shown as the tooltip when disabled, so an unavailable action always
  /// explains itself.
  final String? disabledReason;

  /// Solid background, used for the inline "approve" affordance.
  final Color? filled;

  @override
  Widget build(BuildContext context) {
    final color = isDisabled
        ? FBColors.textDim
        : (filled != null
              ? Colors.white
              : (isDestructive ? FBColors.red : FBColors.textMid));

    final button = Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ?? (isDisabled ? FBColors.card : Colors.white),
          borderRadius: FBRadius.all(7),
          border: filled == null
              ? Border.all(color: FBColors.cardBorder)
              : null,
        ),
        child: Icon(icon, size: 13, color: color),
      ),
    );

    return Tooltip(
      message: isDisabled ? (disabledReason ?? '') : (tooltip ?? ''),
      child: isDisabled
          ? button
          : InkWell(
              onTap: onPressed,
              borderRadius: FBRadius.all(7),
              child: button,
            ),
    );
  }
}

/// The page control under a table.
class TablePagination extends StatelessWidget {
  const TablePagination({
    super.key,
    required this.summary,
    required this.pageCount,
    required this.currentPage,
    this.onPageChanged,
  });

  final String summary;
  final int pageCount;
  final int currentPage;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            summary,
            style: FBText.label.copyWith(
              fontWeight: FontWeight.w500,
              color: FBColors.textMid,
            ),
          ),
        ),
        _pageButton(
          '‹',
          isActive: false,
          onTap: currentPage > 1
              ? () => onPageChanged?.call(currentPage - 1)
              : null,
        ),
        for (var p = 1; p <= pageCount; p++)
          _pageButton(
            '$p',
            isActive: p == currentPage,
            onTap: () => onPageChanged?.call(p),
          ),
        _pageButton(
          '›',
          isActive: false,
          onTap: currentPage < pageCount
              ? () => onPageChanged?.call(currentPage + 1)
              : null,
        ),
      ],
    );
  }

  Widget _pageButton(
    String label, {
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Material(
        color: isActive ? FBColors.navy : Colors.white,
        borderRadius: FBRadius.all(FBRadius.chip),
        child: InkWell(
          onTap: onTap,
          borderRadius: FBRadius.all(FBRadius.chip),
          child: Container(
            constraints: const BoxConstraints(minWidth: 32),
            height: 32,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: FBRadius.all(FBRadius.chip),
              border: Border.all(
                color: isActive ? FBColors.navy : FBColors.cardBorder,
              ),
            ),
            child: Text(
              label,
              style: FBText.label.copyWith(
                color: isActive
                    ? Colors.white
                    : (onTap == null ? FBColors.textDim : FBColors.textMid),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
