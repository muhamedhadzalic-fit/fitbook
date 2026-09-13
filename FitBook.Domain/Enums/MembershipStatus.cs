namespace FitBook.Domain.Enums;

/// <summary>
/// Subscription state of a client's membership. Drives the member status badge
/// in the admin app and the precondition check when a booking is created.
/// </summary>
public enum MembershipStatus
{
    /// <summary>Paid and inside its validity window.</summary>
    Active = 1,

    /// <summary>Past its end date.</summary>
    Expired = 2,

    /// <summary>Suspended by an admin.</summary>
    Suspended = 3,

    /// <summary>Cancelled by the client.</summary>
    Cancelled = 4,
}
