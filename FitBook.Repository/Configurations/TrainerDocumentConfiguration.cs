using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class TrainerDocumentConfiguration : IEntityTypeConfiguration<TrainerDocument>
{
    public void Configure(EntityTypeBuilder<TrainerDocument> builder)
    {
        builder.HasKey(d => d.Id);

        builder.Property(d => d.FileName).IsRequired().HasMaxLength(260);
        builder.Property(d => d.ContentType).IsRequired().HasMaxLength(100);
        builder.Property(d => d.StoragePath).IsRequired().HasMaxLength(400);

        builder
            .HasOne(d => d.TrainerProfile)
            .WithMany(t => t.Documents)
            .HasForeignKey(d => d.TrainerProfileId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
