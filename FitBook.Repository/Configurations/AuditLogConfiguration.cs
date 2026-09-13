using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class AuditLogConfiguration : IEntityTypeConfiguration<AuditLog>
{
    public void Configure(EntityTypeBuilder<AuditLog> builder)
    {
        builder.HasKey(a => a.Id);

        builder.Property(a => a.EntityName).IsRequired().HasMaxLength(80);
        builder.Property(a => a.Action).IsRequired().HasMaxLength(80);
        builder.Property(a => a.Description).HasMaxLength(1000);

        // The trail survives the actor: SetNull rather than losing the entry.
        builder
            .HasOne(a => a.ActorUser)
            .WithMany()
            .HasForeignKey(a => a.ActorUserId)
            .OnDelete(DeleteBehavior.SetNull);

        // How the reservation detail screen loads one record's timeline.
        builder.HasIndex(a => new { a.EntityName, a.EntityId, a.CreatedAt });
    }
}
