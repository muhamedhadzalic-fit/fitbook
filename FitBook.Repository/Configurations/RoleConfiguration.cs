using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class RoleConfiguration : IEntityTypeConfiguration<Role>
{
    public void Configure(EntityTypeBuilder<Role> builder)
    {
        builder.HasKey(r => r.Id);

        builder.Property(r => r.Name).IsRequired().HasMaxLength(40);
        builder.Property(r => r.Description).HasMaxLength(200);

        // Authorization matches on this name, so duplicates are not allowed.
        builder.HasIndex(r => r.Name).IsUnique();
    }
}
