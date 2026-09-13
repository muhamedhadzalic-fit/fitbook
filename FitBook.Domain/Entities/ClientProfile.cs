namespace FitBook.Domain.Entities;

/// <summary>
/// The client-specific half of an account: what they are training for, and
/// everything they own (bookings, memberships, reviews).
/// </summary>
public class ClientProfile
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public User User { get; set; } = null!;

    /// <summary>Free-text training goal, used as a recommender signal.</summary>
    public string? Goals { get; set; }

    public string? Preferences { get; set; }

    public DateTime? DateOfBirth { get; set; }

    public ICollection<Booking> Bookings { get; set; } = [];

    public ICollection<Membership> Memberships { get; set; } = [];

    public ICollection<Review> Reviews { get; set; } = [];
}
