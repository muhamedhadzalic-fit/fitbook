namespace FitBook.Domain.Entities;

/// <summary>
/// Reference data: a city. Both apps show cities in dropdowns, so every place a
/// city appears is an FK to this table and never a loose string.
/// </summary>
public class City
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string? PostalCode { get; set; }

    public int CountryId { get; set; }

    public Country Country { get; set; } = null!;

    public ICollection<User> Users { get; set; } = [];

    public ICollection<Location> Locations { get; set; } = [];
}
