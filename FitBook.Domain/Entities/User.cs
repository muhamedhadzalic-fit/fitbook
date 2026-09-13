namespace FitBook.Domain.Entities;

/// <summary>
/// An account. One user is exactly one of Client, Trainer or Admin, carried
/// through <see cref="UserRoles"/> and surfaced as the JWT's role claim, which is
/// what routes the mobile app to the right shell.
/// </summary>
/// <remarks>
/// Deliberately a plain entity rather than <c>IdentityUser</c>: FitBook.Domain
/// must not reference ASP.NET or EF, and inheriting from Identity would force a
/// Microsoft.Extensions.Identity.Stores reference into this project. Password
/// hashing lives in FitBook.Services and uses PBKDF2/bcrypt.
/// </remarks>
public class User
{
    public int Id { get; set; }

    public string FirstName { get; set; } = string.Empty;

    public string LastName { get; set; } = string.Empty;

    public string Email { get; set; } = string.Empty;

    public string? PhoneNumber { get; set; }

    /// <summary>
    /// PBKDF2/bcrypt hash. The seeder and the runtime hasher must produce the
    /// same format — a mismatch here is a known trap.
    /// </summary>
    public string PasswordHash { get; set; } = string.Empty;

    public int? CityId { get; set; }

    public City? City { get; set; }

    /// <summary>Relative path to the avatar; never a base64 blob in a list response.</summary>
    public string? ProfileImagePath { get; set; }

    public bool IsActive { get; set; } = true;

    public DateTime CreatedAt { get; set; }

    public ICollection<UserRole> UserRoles { get; set; } = [];

    /// <summary>Set when this user is a client.</summary>
    public ClientProfile? ClientProfile { get; set; }

    /// <summary>Set when this user is a trainer.</summary>
    public TrainerProfile? TrainerProfile { get; set; }

    public string FullName => $"{FirstName} {LastName}";
}
