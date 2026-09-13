namespace FitBook.Domain.Entities;

/// <summary>
/// Something a trainer offers — the thing a client actually books. Price and
/// duration are server-owned; the client never reports either.
/// </summary>
public class Service
{
    public int Id { get; set; }

    public int TrainerProfileId { get; set; }

    public TrainerProfile TrainerProfile { get; set; } = null!;

    public int CategoryId { get; set; }

    public Category Category { get; set; } = null!;

    public string Title { get; set; } = string.Empty;

    public string Description { get; set; } = string.Empty;

    /// <summary>Price in KM, owned by the server.</summary>
    public decimal Price { get; set; }

    public int DurationMinutes { get; set; }

    public string? ImagePath { get; set; }

    public bool IsActive { get; set; } = true;

    public DateTime CreatedAt { get; set; }
}
