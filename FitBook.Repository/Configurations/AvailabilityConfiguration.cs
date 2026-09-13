using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class AvailabilityConfiguration : IEntityTypeConfiguration<Availability>
{
    public void Configure(EntityTypeBuilder<Availability> builder)
    {
        builder.HasKey(a => a.Id);

        builder
            .HasOne(a => a.TrainerProfile)
            .WithMany(t => t.Availabilities)
            .HasForeignKey(a => a.TrainerProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        // The same trainer cannot publish the same slot twice.
        builder.HasIndex(a => new { a.TrainerProfileId, a.StartsAtUtc }).IsUnique();

        builder.ToTable(t =>
            t.HasCheckConstraint("CK_Availability_Window", "[EndsAtUtc] > [StartsAtUtc]"));
    }
}
