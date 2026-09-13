namespace FitBook.Domain.Entities;

/// <summary>
/// Reference data: the category a <see cref="Service"/> belongs to. Also one of
/// the signals the recommender scores against.
/// </summary>
public class Category
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public ICollection<Service> Services { get; set; } = [];
}
