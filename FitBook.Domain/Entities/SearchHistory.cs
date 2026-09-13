namespace FitBook.Domain.Entities;

/// <summary>
/// A real signal captured when a client searches or views a trainer. This table
/// is what makes the recommender explainable rather than decorative: every
/// column here is actually read during scoring, and every recommendation names
/// the signals it came from.
/// </summary>
public class SearchHistory
{
    public int Id { get; set; }

    public int UserId { get; set; }

    public User User { get; set; } = null!;

    /// <summary>The raw search term, when the signal came from the search box.</summary>
    public string? Query { get; set; }

    /// <summary>Set when the client filtered by a speciality chip.</summary>
    public int? SpecialityId { get; set; }

    public Speciality? Speciality { get; set; }

    /// <summary>Set when the client filtered by category.</summary>
    public int? CategoryId { get; set; }

    public Category? Category { get; set; }

    /// <summary>Set when the signal was opening a trainer's profile.</summary>
    public int? ViewedTrainerProfileId { get; set; }

    public TrainerProfile? ViewedTrainerProfile { get; set; }

    /// <summary>Where the client was searching, which weights nearby trainers.</summary>
    public int? CityId { get; set; }

    public City? City { get; set; }

    public DateTime CreatedAt { get; set; }
}
