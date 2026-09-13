using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class NewsConfiguration : IEntityTypeConfiguration<News>
{
    public void Configure(EntityTypeBuilder<News> builder)
    {
        builder.HasKey(n => n.Id);

        builder.Property(n => n.Title).IsRequired().HasMaxLength(160);
        builder.Property(n => n.Body).IsRequired().HasMaxLength(4000);
        builder.Property(n => n.ImagePath).HasMaxLength(400);

        // An announcement outlives its author's account.
        builder
            .HasOne(n => n.AuthorUser)
            .WithMany()
            .HasForeignKey(n => n.AuthorUserId)
            .OnDelete(DeleteBehavior.SetNull);

        builder.HasIndex(n => n.PublishedAt);
    }
}
