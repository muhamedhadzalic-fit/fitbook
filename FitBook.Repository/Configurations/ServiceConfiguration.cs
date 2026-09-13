using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class ServiceConfiguration : IEntityTypeConfiguration<Service>
{
    public void Configure(EntityTypeBuilder<Service> builder)
    {
        builder.HasKey(s => s.Id);

        builder.Property(s => s.Title).IsRequired().HasMaxLength(140);
        builder.Property(s => s.Description).IsRequired().HasMaxLength(2000);
        builder.Property(s => s.Price).HasPrecision(10, 2);
        builder.Property(s => s.ImagePath).HasMaxLength(400);

        builder
            .HasOne(s => s.TrainerProfile)
            .WithMany(t => t.Services)
            .HasForeignKey(s => s.TrainerProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder
            .HasOne(s => s.Category)
            .WithMany(c => c.Services)
            .HasForeignKey(s => s.CategoryId)
            // A category in use cannot be deleted.
            .OnDelete(DeleteBehavior.Restrict);

        builder.ToTable(t =>
            t.HasCheckConstraint("CK_Service_Duration", "[DurationMinutes] > 0"));

        builder.HasIndex(s => s.CategoryId);
    }
}
