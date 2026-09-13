using FitBook.Domain.Constants;

namespace FitBook.Domain.Entities;

/// <summary>
/// Reference data: a role. Seeded from <see cref="RoleNames"/> so the stored
/// names match the strings used in authorization attributes exactly.
/// </summary>
public class Role
{
    public int Id { get; set; }

    public string Name { get; set; } = string.Empty;

    public string? Description { get; set; }

    public ICollection<UserRole> UserRoles { get; set; } = [];
}
