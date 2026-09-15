using FitBook.Domain.Dtos;
using FitBook.Domain.Dtos.Reference;
using FitBook.Domain.Entities;
using FitBook.Domain.Exceptions;
using FitBook.Repository.Repositories;
using FitBook.Services.Mapping;

namespace FitBook.Services.Reference;

/// <inheritdoc cref="ICityService" />
public sealed class CityService(ICityRepository repository) : ICityService
{
    public async Task<PagedResult<CityDto>> SearchAsync(
        PagedRequest request,
        CancellationToken cancellationToken)
    {
        var page = await repository.SearchAsync(request, cancellationToken);

        // The paging numbers are the repository's; only the items are remapped,
        // so the totals always describe the same query the database answered.
        return new PagedResult<CityDto>(
            [.. page.Items.Select(city => city.ToDto())],
            page.Page,
            page.PageSize,
            page.TotalCount);
    }

    public async Task<CityDto> GetAsync(int id, CancellationToken cancellationToken)
    {
        var city = await repository.GetAsync(id, cancellationToken)
            ?? throw new NotFoundException(nameof(City), id);

        return city.ToDto();
    }
}
