namespace FitBook.Domain.Entities;

/// <summary>
/// Reference data: a gym or studio a session takes place at. The UI showed these
/// as free text ("FitZone Centar · Sarajevo"); referential data must be an FK, so
/// bookings point here instead of carrying a string.
/// </summary>
public class Location
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string Address { get; set; } = string.Empty;

    /// <summary>Neighbourhood shown beside the city, e.g. "Centar".</summary>
    public string? District { get; set; }

    public int CityId { get; set; }

    public City City { get; set; } = null!;
}
