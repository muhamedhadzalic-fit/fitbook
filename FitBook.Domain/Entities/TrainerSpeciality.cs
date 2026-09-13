namespace FitBook.Domain.Entities;

/// <summary>
/// Join table between <see cref="TrainerProfile"/> and <see cref="Speciality"/>.
/// A trainer lists several specialities and the UI renders them as chips.
/// </summary>
public class TrainerSpeciality
{
    public int TrainerProfileId { get; set; }

    public TrainerProfile TrainerProfile { get; set; } = null!;

    public int SpecialityId { get; set; }

    public Speciality Speciality { get; set; } = null!;
}
