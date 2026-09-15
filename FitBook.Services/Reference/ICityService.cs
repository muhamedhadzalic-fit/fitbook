using FitBook.Domain.Dtos;
using FitBook.Domain.Dtos.Reference;

namespace FitBook.Services.Reference;

/// <summary>
/// Reads over the city reference table. Returns DTOs only — entities never leave
/// this layer.
/// </summary>
public interface ICityService
{
    Task<PagedResult<CityDto>> SearchAsync(PagedRequest request, CancellationToken cancellationToken);

    /// <summary>Throws <see cref="Domain.Exceptions.NotFoundException"/> when the id does not exist.</summary>
    Task<CityDto> GetAsync(int id, CancellationToken cancellationToken);
}
