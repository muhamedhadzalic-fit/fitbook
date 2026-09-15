using FitBook.Domain.Dtos;
using FitBook.Domain.Entities;

namespace FitBook.Repository.Repositories;

/// <summary>
/// Queries over <see cref="City"/>. Returns entities; turning them into DTOs is
/// the service layer's job.
/// </summary>
public interface ICityRepository
{
    /// <summary>One page of cities, optionally filtered by the request's search term.</summary>
    Task<PagedResult<City>> SearchAsync(PagedRequest request, CancellationToken cancellationToken);

    /// <summary>A single city, or null when no row has that id.</summary>
    Task<City?> GetAsync(int id, CancellationToken cancellationToken);
}
