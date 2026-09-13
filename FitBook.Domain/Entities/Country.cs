namespace FitBook.Domain.Entities;

/// <summary>Reference data: a country, parent of <see cref="City"/>.</summary>
public class Country
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    /// <summary>ISO 3166-1 alpha-2 code, e.g. "BA".</summary>
    public string IsoCode { get; set; } = string.Empty;

    public ICollection<City> Cities { get; set; } = [];
}
