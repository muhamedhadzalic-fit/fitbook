namespace FitBook.Domain.Entities;

/// <summary>
/// A purchasable plan (Basic, Premium...), as shown on the mobile membership
/// screen. The server owns the price the client is charged.
/// </summary>
public class MembershipPlan
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    /// <summary>Monthly price in KM, owned by the server.</summary>
    public decimal MonthlyPrice { get; set; }

    /// <summary>Sessions the plan covers per month.</summary>
    public int SessionsIncluded { get; set; }

    public bool IsActive { get; set; } = true;

    public ICollection<Membership> Memberships { get; set; } = [];
}
