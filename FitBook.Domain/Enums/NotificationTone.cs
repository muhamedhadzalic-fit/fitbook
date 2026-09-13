namespace FitBook.Domain.Enums;

/// <summary>
/// Severity of a notification, which drives its icon and tint in both apps.
/// Mirrors <c>NotificationTone</c> in the Flutter models.
/// </summary>
public enum NotificationTone
{
    Info = 1,
    Success = 2,
    Warning = 3,
    Error = 4,
}
