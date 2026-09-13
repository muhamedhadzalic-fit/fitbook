using FitBook.Domain.Enums;

namespace FitBook.Domain.Entities;

/// <summary>
/// A client's reserved session — the centre of the domain. Status moves only
/// through the state machine in FitBook.Services, and every transition writes an
/// <see cref="AuditLog"/> entry. Bookings are never hard-deleted.
/// </summary>
public class Booking
{
    public int Id { get; set; }

    /// <summary>
    /// Human-readable reference shown instead of the primary key, e.g. "FB-2841"
    /// — forms must never display raw database IDs.
    /// </summary>
    public string Reference { get; set; } = string.Empty;

    public int ClientProfileId { get; set; }

    public ClientProfile ClientProfile { get; set; } = null!;

    public int TrainerProfileId { get; set; }

    public TrainerProfile TrainerProfile { get; set; } = null!;

    public int ServiceId { get; set; }

    public Service Service { get; set; } = null!;

    public int? LocationId { get; set; }

    public Location? Location { get; set; }

    /// <summary>Set when the session is covered by an active membership.</summary>
    public int? MembershipId { get; set; }

    public Membership? Membership { get; set; }

    public DateTime StartsAtUtc { get; set; }

    public DateTime EndsAtUtc { get; set; }

    public BookingStatus Status { get; set; } = BookingStatus.Pending;

    /// <summary>Price captured when the booking was made, calculated server-side.</summary>
    public decimal Amount { get; set; }

    public string? ClientNotes { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ConfirmedAt { get; set; }

    public DateTime? CompletedAt { get; set; }

    public DateTime? CancelledAt { get; set; }

    /// <summary>Required when the booking is cancelled or rejected.</summary>
    public string? CancellationReason { get; set; }

    public Payment? Payment { get; set; }

    public Review? Review { get; set; }
}
