using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class LocationConfiguration : IEntityTypeConfiguration<Location>
{
    public void Configure(EntityTypeBuilder<Location> builder)
    {
        builder.HasKey(l => l.Id);

        builder.Property(l => l.Name).IsRequired().HasMaxLength(120);
        builder.Property(l => l.Address).IsRequired().HasMaxLength(200);
        builder.Property(l => l.District).HasMaxLength(100);

        builder
            .HasOne(l => l.City)
            .WithMany(c => c.Locations)
            .HasForeignKey(l => l.CityId)
            .OnDelete(DeleteBehavior.Restrict);

        builder.HasIndex(l => new { l.CityId, l.Name });
    }
}
