/// One entry in the admin sidebar.
class NavItem {
  const NavItem({
    required this.id,
    required this.label,
    required this.iconKey,
    this.badge,
    this.isImplemented = true,
  });

  final String id;
  final String label;

  /// Key resolved through `FBIcons.byKey`, so mock data stays Flutter-free.
  final String iconKey;

  /// Count shown on the right of the row.
  final String? badge;

  /// False for sections that are still placeholders, so the shell can say so
  /// rather than opening an empty screen.
  final bool isImplemented;
}

/// A titled group of sidebar entries.
class NavGroup {
  const NavGroup({required this.label, required this.items});

  final String label;
  final List<NavItem> items;
}

/// The product name and build label shown at the top of the sidebar.
class AdminBranding {
  const AdminBranding({required this.appName, required this.appSubtitle});

  final String appName;
  final String appSubtitle;
}

/// The signed-in administrator, shown at the foot of the sidebar.
class AdminIdentity {
  const AdminIdentity({
    required this.name,
    required this.role,
    required this.identityHue,
  });

  final String name;
  final String role;
  final double identityHue;
}

/// Header copy for one screen: the title, an optional breadcrumb path, and the
/// labels of any toolbar buttons.
class ScreenChrome {
  const ScreenChrome({
    required this.title,
    this.breadcrumb,
    this.actions = const [],
  });

  final String title;
  final String? breadcrumb;
  final List<String> actions;
}
