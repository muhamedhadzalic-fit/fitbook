namespace FitBook.Domain.Dtos;

/// <summary>
/// Paging and search parameters accepted by every list endpoint.
/// </summary>
/// <remarks>
/// The limits are enforced in the property setters rather than in each
/// controller. That is deliberate: model binding runs through these setters, so
/// a request asking for <c>pageSize=100000</c> cannot produce an out-of-range
/// value in the first place, and a future endpoint cannot forget to clamp it.
/// </remarks>
public class PagedRequest
{
    /// <summary>Hard ceiling on how many rows one request may ask for.</summary>
    public const int MaxPageSize = 100;

    public const int DefaultPageSize = 20;

    private int _page = 1;
    private int _pageSize = DefaultPageSize;
    private string? _search;

    /// <summary>1-based page number. Anything lower is treated as the first page.</summary>
    public int Page
    {
        get => _page;
        set => _page = value < 1 ? 1 : value;
    }

    /// <summary>Rows per page, clamped to <see cref="MaxPageSize"/>.</summary>
    public int PageSize
    {
        get => _pageSize;
        set => _pageSize = value switch
        {
            <= 0 => DefaultPageSize,
            > MaxPageSize => MaxPageSize,
            _ => value,
        };
    }

    /// <summary>Free-text search term. Blank input is normalised to null.</summary>
    public string? Search
    {
        get => _search;
        set
        {
            var trimmed = value?.Trim();
            _search = string.IsNullOrEmpty(trimmed) ? null : trimmed;
        }
    }

    /// <summary>Rows to skip for the current page.</summary>
    public int Skip => (Page - 1) * PageSize;
}
