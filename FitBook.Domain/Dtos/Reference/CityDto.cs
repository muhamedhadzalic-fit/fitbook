namespace FitBook.Domain.Dtos.Reference;

/// <summary>
/// A city as the API returns it.
/// </summary>
/// <remarks>
/// The country travels as a nested object rather than a flattened name, so a
/// client never has to reconcile a display string against an id it also needs.
/// Reference data is modelled the same way everywhere: an id plus the object.
/// </remarks>
public record CityDto(int Id, string Name, string? PostalCode, CountryDto Country);

/// <summary>A country as the API returns it.</summary>
public record CountryDto(int Id, string Name, string IsoCode);
