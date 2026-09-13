using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class ReviewConfiguration : IEntityTypeConfiguration<Review>
{
    public void Configure(EntityTypeBuilder<Review> builder)
    {
        builder.HasKey(r => r.Id);

        builder.Property(r => r.Comment).HasMaxLength(1000);

        // One review per booking.
        builder
            .HasOne(r => r.Booking)
            .WithOne(b => b.Review)
            .HasForeignKey<Review>(r => r.BookingId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(r => r.ClientProfile)
            .WithMany(c => c.Reviews)
            .HasForeignKey(r => r.ClientProfileId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(r => r.TrainerProfile)
            .WithMany(t => t.Reviews)
            .HasForeignKey(r => r.TrainerProfileId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(r => r.BookingId).IsUnique();

        // The recommender averages ratings per trainer.
        builder.HasIndex(r => r.TrainerProfileId);

        builder.ToTable(t =>
            t.HasCheckConstraint("CK_Review_Rating", "[Rating] BETWEEN 1 AND 5"));
    }
}
