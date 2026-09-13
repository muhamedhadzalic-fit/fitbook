using FitBook.Domain.Enums;

namespace FitBook.Domain.Entities;

/// <summary>
/// A client's subscription to a <see cref="MembershipPlan"/>. Drives the "8
/// sessions left this month" banner, the member status badge in the admin app,
/// and the expired-membership precondition check when a booking is created.
/// </summary>
public class Membership
{
    public int Id { get; set; }

    public int ClientProfileId { get; set; }

    public ClientProfile ClientProfile { get; set; } = null!;

    public int MembershipPlanId { get; set; }

    public MembershipPlan MembershipPlan { get; set; } = null!;

    public MembershipStatus Status { get; set; } = MembershipStatus.Active;

    public DateTime StartsAtUtc { get; set; }

    public DateTime EndsAtUtc { get; set; }

    /// <summary>Decremented as covered sessions are booked.</summary>
    public int SessionsRemaining { get; set; }

    public DateTime CreatedAt { get; set; }

    public ICollection<Booking> Bookings { get; set; } = [];

    public ICollection<Payment> Payments { get; set; } = [];
}
