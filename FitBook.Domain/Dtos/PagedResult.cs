namespace FitBook.Domain.Dtos;

/// <summary>
/// One page of results, as every list endpoint returns them.
/// </summary>
/// <remarks>
/// Pagination is mandatory on every list endpoint with an enforced maximum page
/// size; there is no unbounded "retrieve all" anywhere in this API. The counts
/// come from the database, never from materialising everything and measuring it.
/// </remarks>
public record PagedResult<T>(IReadOnlyList<T> Items, int Page, int PageSize, int TotalCount)
{
    /// <summary>Total pages available at the current <see cref="PageSize"/>.</summary>
    public int TotalPages => PageSize <= 0 ? 0 : (int)Math.Ceiling(TotalCount / (double)PageSize);

    public bool HasPrevious => Page > 1;

    public bool HasNext => Page < TotalPages;
}
