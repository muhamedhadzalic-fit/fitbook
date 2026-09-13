namespace FitBook.Domain.Enums;

/// <summary>
/// Lifecycle of a booking. Transitions are owned by the booking state machine in
/// FitBook.Services; a booking is never hard-deleted, only transitioned.
/// </summary>
public enum BookingStatus
{
    /// <summary>Created by the client, awaiting the trainer's decision.</summary>
    Pending = 1,

    /// <summary>Accepted by the trainer.</summary>
    Confirmed = 2,

    /// <summary>The session took place. Only a completed booking can be reviewed.</summary>
    Completed = 3,

    /// <summary>Withdrawn by the client or an admin.</summary>
    Cancelled = 4,

    /// <summary>Declined by the trainer, which always carries a reason.</summary>
    Rejected = 5,
}
