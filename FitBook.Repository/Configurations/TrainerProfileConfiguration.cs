using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class TrainerProfileConfiguration : IEntityTypeConfiguration<TrainerProfile>
{
    public void Configure(EntityTypeBuilder<TrainerProfile> builder)
    {
        builder.HasKey(t => t.Id);

        builder.Property(t => t.Bio).IsRequired().HasMaxLength(2000);
        builder.Property(t => t.HourlyRate).HasPrecision(10, 2);
        builder.Property(t => t.District).HasMaxLength(100);
        builder.Property(t => t.RejectionReason).HasMaxLength(500);

        // Stored as int; the enum is the single source of truth in code.
        builder.Property(t => t.VerificationStatus).HasConversion<int>();

        builder
            .HasOne(t => t.User)
            .WithOne(u => u.TrainerProfile)
            .HasForeignKey<TrainerProfile>(t => t.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // The admin who reviewed the application. Restrict, so an audited
        // decision never loses its reviewer.
        builder
            .HasOne(t => t.ReviewedByUser)
            .WithMany()
            .HasForeignKey(t => t.ReviewedByUserId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(t => t.UserId).IsUnique();

        // The admin verification queue filters on this.
        builder.HasIndex(t => t.VerificationStatus);
    }
}
