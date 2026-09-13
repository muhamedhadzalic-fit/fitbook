using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class TrainerSpecialityConfiguration : IEntityTypeConfiguration<TrainerSpeciality>
{
    public void Configure(EntityTypeBuilder<TrainerSpeciality> builder)
    {
        // Composite key: a trainer lists a speciality at most once.
        builder.HasKey(ts => new { ts.TrainerProfileId, ts.SpecialityId });

        builder
            .HasOne(ts => ts.TrainerProfile)
            .WithMany(t => t.TrainerSpecialities)
            .HasForeignKey(ts => ts.TrainerProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder
            .HasOne(ts => ts.Speciality)
            .WithMany(s => s.TrainerSpecialities)
            .HasForeignKey(ts => ts.SpecialityId)
            // A speciality in use cannot be deleted.
            .OnDelete(DeleteBehavior.Restrict);
    }
}
