namespace FitBook.Domain.Entities;

/// <summary>
/// A platform announcement (<c>Obavijest</c>) — title, text, image and
/// timestamp, authored by an admin.
/// </summary>
public class News
{
    public int Id { get; set; }

    public string Title { get; set; } = string.Empty;

    public string Body { get; set; } = string.Empty;

    /// <summary>Relative path, so list endpoints stay free of base64 payloads.</summary>
    public string? ImagePath { get; set; }

    public bool IsPublished { get; set; }

    public DateTime PublishedAt { get; set; }

    public int? AuthorUserId { get; set; }

    public User? AuthorUser { get; set; }
}
