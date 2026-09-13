using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class SearchHistoryConfiguration : IEntityTypeConfiguration<SearchHistory>
{
    public void Configure(EntityTypeBuilder<SearchHistory> builder)
    {
        builder.HasKey(s => s.Id);

        builder.Property(s => s.Query).HasMaxLength(200);

        builder
            .HasOne(s => s.User)
            .WithMany(u => u.SearchHistory)
            .HasForeignKey(s => s.UserId)
            .OnDelete(DeleteBehavior.Cascade);

        // Each signal is optional and independent; SetNull keeps the row (and so
        // the recommender's history) intact if reference data is removed.
        builder
            .HasOne(s => s.Speciality)
            .WithMany()
            .HasForeignKey(s => s.SpecialityId)
            .OnDelete(DeleteBehavior.SetNull);

        builder
            .HasOne(s => s.Category)
            .WithMany()
            .HasForeignKey(s => s.CategoryId)
            .OnDelete(DeleteBehavior.SetNull);

        builder
            .HasOne(s => s.ViewedTrainerProfile)
            .WithMany()
            .HasForeignKey(s => s.ViewedTrainerProfileId)
            .OnDelete(DeleteBehavior.SetNull);

        builder
            .HasOne(s => s.City)
            .WithMany()
            .HasForeignKey(s => s.CityId)
            .OnDelete(DeleteBehavior.SetNull);

        // How the recommender reads a user's recent signals.
        builder.HasIndex(s => new { s.UserId, s.CreatedAt });
    }
}
