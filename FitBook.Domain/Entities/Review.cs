namespace FitBook.Domain.Entities;

/// <summary>
/// A client's review of a completed booking. One per booking, and only once the
/// booking is Completed — reviewing earlier is rejected by the state machine.
/// Ratings feed the recommender's popularity signal.
/// </summary>
public class Review
{
    public int Id { get; set; }

    public int BookingId { get; set; }

    public Booking Booking { get; set; } = null!;

    public int ClientProfileId { get; set; }

    public ClientProfile ClientProfile { get; set; } = null!;

    public int TrainerProfileId { get; set; }

    public TrainerProfile TrainerProfile { get; set; } = null!;

    /// <summary>1 to 5, enforced by a check constraint.</summary>
    public int Rating { get; set; }

    public string? Comment { get; set; }

    public DateTime CreatedAt { get; set; }
}
