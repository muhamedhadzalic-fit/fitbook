using FitBook.Domain.Dtos;
using Microsoft.EntityFrameworkCore;

namespace FitBook.Repository.Repositories;

/// <summary>
/// The one piece of paging logic in the data layer, shared by every repository.
/// </summary>
/// <remarks>
/// This exists instead of a generic <c>IRepository&lt;T&gt;</c>. A generic
/// repository over EF Core hides <c>Include</c> and query composition behind a
/// lowest-common-denominator interface and buys nothing, since
/// <see cref="FitBookDbContext"/> is already a unit of work. Paging was the only
/// genuine duplication, so paging is the only thing shared.
/// </remarks>
public static class PagingExtensions
{
    /// <summary>
    /// Counts and pages a query <em>at the database</em> — one COUNT and one
    /// windowed SELECT, never "load everything and filter in memory".
    /// </summary>
    /// <remarks>
    /// The caller must order the query first: SQL Server rejects OFFSET/FETCH
    /// without an ORDER BY, and an unordered page is not reproducible anyway.
    /// </remarks>
    public static async Task<PagedResult<T>> ToPagedResultAsync<T>(
        this IQueryable<T> query,
        PagedRequest request,
        CancellationToken cancellationToken)
    {
        var totalCount = await query.CountAsync(cancellationToken);

        var items = await query
            .Skip(request.Skip)
            .Take(request.PageSize)
            .ToListAsync(cancellationToken);

        return new PagedResult<T>(items, request.Page, request.PageSize, totalCount);
    }
}
