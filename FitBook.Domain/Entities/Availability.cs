namespace FitBook.Domain.Entities;

/// <summary>
/// A bookable slot in a trainer's calendar, rendered as the weekly availability
/// strip on the trainer profile. Overlap and double-booking are checked against
/// this table on the server — a frontend check does not count.
/// </summary>
public class Availability
{
    public int Id { get; set; }

    public int TrainerProfileId { get; set; }

    public TrainerProfile TrainerProfile { get; set; } = null!;

    public DateTime StartsAtUtc { get; set; }

    public DateTime EndsAtUtc { get; set; }

    /// <summary>Taken slots still render, greyed out, so the week reads honestly.</summary>
    public bool IsBooked { get; set; }
}
