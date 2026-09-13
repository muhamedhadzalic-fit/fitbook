namespace FitBook.Domain.Entities;

/// <summary>
/// Reference data: a trainer speciality (Yoga, CrossFit, Strength...). Drives the
/// speciality filter chips on the mobile home feed and the trainer-registration
/// picker, and feeds the recommender's content-based scoring.
/// </summary>
public class Speciality
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public ICollection<TrainerSpeciality> TrainerSpecialities { get; set; } = [];
}
