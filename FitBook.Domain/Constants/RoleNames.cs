namespace FitBook.Domain.Constants;

/// <summary>
/// The three role names, as a single source of truth. These exact strings are
/// what the seeder writes to the Role table and what
/// <c>[Authorize(Roles = "...")]</c> checks against — a mismatch between the two
/// silently locks users out, so neither side uses a literal.
/// </summary>
public static class RoleNames
{
    public const string Client = "Client";
    public const string Trainer = "Trainer";
    public const string Admin = "Admin";

    /// <summary>Every role, for seeding and validation.</summary>
    public static readonly IReadOnlyList<string> All = [Client, Trainer, Admin];
}
