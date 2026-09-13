using FitBook.Domain.Enums;

namespace FitBook.Domain.Entities;

/// <summary>
/// An in-app notification. Written for every relevant event — booking created,
/// confirmed, rejected, cancelled, paid — by FitBook.Worker off the RabbitMQ
/// queue, and pushed to clients over SignalR so no manual refresh is needed.
/// </summary>
public class Notification
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public User User { get; set; } = null!;

    public string Title { get; set; } = string.Empty;

    public string Body { get; set; } = string.Empty;

    public NotificationTone Tone { get; set; } = NotificationTone.Info;

    public bool IsRead { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ReadAt { get; set; }
}
