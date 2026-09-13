namespace FitBook.Domain.Entities;

/// <summary>
/// A document a trainer uploaded for verification (ID scan, certification).
/// Shown in the admin verification queue. Download requires an ownership check,
/// and upload validates MIME type and magic bytes — not just the extension.
/// </summary>
public class TrainerDocument
{
    public int Id { get; set; }

    public int TrainerProfileId { get; set; }

    public TrainerProfile TrainerProfile { get; set; } = null!;

    public string FileName { get; set; } = string.Empty;

    /// <summary>Validated MIME type, e.g. "application/pdf".</summary>
    public string ContentType { get; set; } = string.Empty;

    public long SizeBytes { get; set; }

    /// <summary>Relative path on disk. The file itself never rides in a list response.</summary>
    public string StoragePath { get; set; } = string.Empty;

    public DateTime UploadedAt { get; set; }
}
