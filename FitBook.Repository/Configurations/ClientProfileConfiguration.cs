using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class ClientProfileConfiguration : IEntityTypeConfiguration<ClientProfile>
{
    public void Configure(EntityTypeBuilder<ClientProfile> builder)
    {
        builder.HasKey(c => c.Id);

        builder.Property(c => c.Goals).HasMaxLength(500);
        builder.Property(c => c.Preferences).HasMaxLength(500);

        // One profile per account.
        builder
            .HasOne(c => c.User)
            .WithOne(u => u.ClientProfile)
            .HasForeignKey<ClientProfile>(c => c.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        builder.HasIndex(c => c.UserId).IsUnique();
    }
}
