namespace FitBook.Domain.Entities;

/// <summary>Join table assigning a <see cref="Role"/> to a <see cref="User"/>.</summary>
public class UserRole
{
    public int UserId { get; set; }

    public User User { get; set; } = null!;

    public int RoleId { get; set; }

    public Role Role { get; set; } = null!;

    public DateTime AssignedAt { get; set; }
}
