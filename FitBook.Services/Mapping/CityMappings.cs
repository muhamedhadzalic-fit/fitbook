using FitBook.Domain.Dtos.Reference;
using FitBook.Domain.Entities;

namespace FitBook.Services.Mapping;

/// <summary>
/// Entity to DTO mapping for cities, written by hand rather than through a
/// mapping library.
/// </summary>
/// <remarks>
/// Mapping is a pure function over data that is already loaded. It must never
/// touch the database — the repository's <c>Include</c> is what makes
/// <see cref="City.Country"/> available here, and a mapper that lazily reached
/// for it would produce an N+1 query per row.
/// </remarks>
public static class CityMappings
{
    public static CityDto ToDto(this City city) =>
        new(city.Id, city.Name, city.PostalCode, city.Country.ToDto());

    public static CountryDto ToDto(this Country country) =>
        new(country.Id, country.Name, country.IsoCode);
}
