namespace FitBook.Domain.Enums;

/// <summary>
/// Verification state of a trainer account. Trainers self-register from mobile
/// into <see cref="Pending"/>; an admin moves them on from the desktop app.
/// </summary>
public enum VerificationStatus
{
    /// <summary>Self-registered, awaiting admin review. Cannot take bookings.</summary>
    Pending = 1,

    /// <summary>Approved by an admin and able to accept bookings.</summary>
    Verified = 2,

    /// <summary>Rejected by an admin, which always carries a reason.</summary>
    Rejected = 3,
}
