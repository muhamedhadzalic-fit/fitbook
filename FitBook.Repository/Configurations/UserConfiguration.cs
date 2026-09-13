using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.HasKey(u => u.Id);

        builder.Property(u => u.FirstName).IsRequired().HasMaxLength(80);
        builder.Property(u => u.LastName).IsRequired().HasMaxLength(80);
        builder.Property(u => u.Email).IsRequired().HasMaxLength(256);
        builder.Property(u => u.PhoneNumber).HasMaxLength(32);
        builder.Property(u => u.PasswordHash).IsRequired().HasMaxLength(256);
        builder.Property(u => u.ProfileImagePath).HasMaxLength(400);

        // FullName is computed from the two name columns, not stored.
        builder.Ignore(u => u.FullName);

        // Login is by email, so it must be unique.
        builder.HasIndex(u => u.Email).IsUnique();

        builder
            .HasOne(u => u.City)
            .WithMany(c => c.Users)
            .HasForeignKey(u => u.CityId)
            .OnDelete(DeleteBehavior.Restrict);
    }
}
