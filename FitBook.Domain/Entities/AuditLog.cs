namespace FitBook.Domain.Entities;

/// <summary>
/// One entry in the audit trail: who did what, when, and why. Every booking
/// status transition and every trainer approval or rejection writes one, which
/// is what the reservation detail screen's timeline renders.
/// </summary>
/// <remarks>
/// Deliberately generic (entity name + id) rather than an FK per target, so a
/// new auditable entity needs no schema change. <see cref="ActorUserId"/> is
/// nullable because the actor can be the system or a payment provider.
/// </remarks>
public class AuditLog
{
    public int Id { get; set; }

    /// <summary>The audited entity's type name, e.g. "Booking".</summary>
    public string EntityName { get; set; } = string.Empty;

    public int EntityId { get; set; }

    /// <summary>What happened, e.g. "Confirmed" or "Rejected".</summary>
    public string Action { get; set; } = string.Empty;

    /// <summary>Null when the actor is the system or Stripe rather than a person.</summary>
    public int? ActorUserId { get; set; }

    public User? ActorUser { get; set; }

    /// <summary>Why it happened — a rejection reason, or a description of the change.</summary>
    public string? Description { get; set; }

    public DateTime CreatedAt { get; set; }
}
