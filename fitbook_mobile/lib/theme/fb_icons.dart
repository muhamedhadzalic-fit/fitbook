import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// The icon vocabulary of the design, named after its role rather than its
/// glyph so a screen never reaches for a raw Lucide constant.
///
/// The mockups are drawn with Lucide at 1.75 stroke; `lucide_icons_flutter`
/// ships that exact set as a bundled font.
abstract final class FBIcons {
  static const search = LucideIcons.search;
  static const bell = LucideIcons.bell;
  static const home = LucideIcons.house;
  static const calendar = LucideIcons.calendar;
  static const user = LucideIcons.user;
  static const users = LucideIcons.users;
  static const star = LucideIcons.star;
  static const pin = LucideIcons.mapPin;
  static const back = LucideIcons.arrowLeft;
  static const filter = LucideIcons.slidersHorizontal;
  static const filterAlt = LucideIcons.filter;
  static const send = LucideIcons.send;
  static const bot = LucideIcons.bot;
  static const check = LucideIcons.check;
  static const close = LucideIcons.x;
  static const alert = LucideIcons.triangleAlert;
  static const chevronRight = LucideIcons.chevronRight;
  static const chevronDown = LucideIcons.chevronDown;
  static const plus = LucideIcons.plus;
  static const more = LucideIcons.ellipsisVertical;
  static const heart = LucideIcons.heart;
  static const share = LucideIcons.share2;
  static const clock = LucideIcons.clock;
  static const dumbbell = LucideIcons.dumbbell;
  static const sparkles = LucideIcons.sparkles;
  static const chart = LucideIcons.chartNoAxesColumn;
  static const settings = LucideIcons.settings;
  static const download = LucideIcons.download;
  static const print = LucideIcons.printer;
  static const file = LucideIcons.fileText;
  static const refresh = LucideIcons.refreshCw;
  static const thumbUp = LucideIcons.thumbsUp;
  static const thumbDown = LucideIcons.thumbsDown;
  static const eye = LucideIcons.eye;
  static const edit = LucideIcons.pencil;
  static const trash = LucideIcons.trash2;
  static const imageAdd = LucideIcons.imagePlus;
  static const upload = LucideIcons.upload;
  static const target = LucideIcons.target;
  static const help = LucideIcons.circleHelp;
  static const logout = LucideIcons.logOut;
  static const mail = LucideIcons.mail;
  static const phone = LucideIcons.phone;
  static const building = LucideIcons.building2;
  static const card = LucideIcons.creditCard;
  static const money = LucideIcons.banknote;

  /// Resolves an icon by the key the mockup data uses, so mock records can
  /// name an icon without importing Flutter.
  static IconData byKey(String key) => switch (key) {
    'search' => search,
    'bell' => bell,
    'home' => home,
    'calendar' => calendar,
    'user' => user,
    'users' => users,
    'star' => star,
    'pin' => pin,
    'filter' => filter,
    'check' => check,
    'close' => close,
    'alert' => alert,
    'clock' => clock,
    'dumbbell' => dumbbell,
    'sparkles' => sparkles,
    'chart' => chart,
    'settings' => settings,
    'money' => money,
    'card' => card,
    'heart' => heart,
    'target' => target,
    'help' => help,
    'logout' => logout,
    'file' => file,
    'plus' => plus,
    _ => help,
  };
}
