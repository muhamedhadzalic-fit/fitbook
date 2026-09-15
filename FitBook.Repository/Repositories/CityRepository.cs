using FitBook.Domain.Dtos;
using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace FitBook.Repository.Repositories;

/// <inheritdoc cref="ICityRepository" />
public sealed class CityRepository(FitBookDbContext context) : ICityRepository
{
    public Task<PagedResult<City>> SearchAsync(
        PagedRequest request,
        CancellationToken cancellationToken)
    {
        var query = context.Cities
            .AsNoTracking()
            .Include(city => city.Country)
            .AsQueryable();

        if (request.Search is { } term)
        {
            // Translated to SQL and run at the database. Contains rather than
            // ToLower: the database collation is already case-insensitive, and
            // lowering both sides would stop an index from being usable.
            query = query.Where(city =>
                city.Name.Contains(term) || city.Country.Name.Contains(term));
        }

        // Ordered before paging: SQL Server needs it for OFFSET, and Id breaks
        // ties so a row cannot appear on two pages.
        return query
            .OrderBy(city => city.Name)
            .ThenBy(city => city.Id)
            .ToPagedResultAsync(request, cancellationToken);
    }

    public Task<City?> GetAsync(int id, CancellationToken cancellationToken) =>
        context.Cities
            .AsNoTracking()
            .Include(city => city.Country)
            .FirstOrDefaultAsync(city => city.Id == id, cancellationToken);
}
