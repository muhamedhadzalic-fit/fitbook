using FitBook.Domain.Enums;

namespace FitBook.Domain.Entities;

/// <summary>
/// The trainer-specific half of an account, including the verification state an
/// admin acts on. A trainer sits in <see cref="VerificationStatus.Pending"/>
/// after self-registering and cannot accept bookings until verified.
/// </summary>
public class TrainerProfile
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public User User { get; set; } = null!;

    public string Bio { get; set; } = string.Empty;

    /// <summary>Rate per session in KM. The server owns this price, never the client.</summary>
    public decimal HourlyRate { get; set; }

    public int YearsExperience { get; set; }

    public VerificationStatus VerificationStatus { get; set; } = VerificationStatus.Pending;

    public DateTime SubmittedAt { get; set; }

    public DateTime? ReviewedAt { get; set; }

    /// <summary>The admin who approved or rejected the application.</summary>
    public int? ReviewedByUserId { get; set; }

    public User? ReviewedByUser { get; set; }

    /// <summary>Required when <see cref="VerificationStatus"/> is Rejected.</summary>
    public string? RejectionReason { get; set; }

    /// <summary>Neighbourhood shown beside the trainer's city on the profile.</summary>
    public string? District { get; set; }

    public bool IsAcceptingClients { get; set; } = true;

    public ICollection<TrainerSpeciality> TrainerSpecialities { get; set; } = [];

    public ICollection<Service> Services { get; set; } = [];

    public ICollection<Availability> Availabilities { get; set; } = [];

    public ICollection<Booking> Bookings { get; set; } = [];

    public ICollection<Review> Reviews { get; set; } = [];
}
