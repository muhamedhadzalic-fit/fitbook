using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class BookingConfiguration : IEntityTypeConfiguration<Booking>
{
    public void Configure(EntityTypeBuilder<Booking> builder)
    {
        builder.HasKey(b => b.Id);

        builder.Property(b => b.Reference).IsRequired().HasMaxLength(20);
        builder.Property(b => b.Amount).HasPrecision(10, 2);
        builder.Property(b => b.ClientNotes).HasMaxLength(1000);
        builder.Property(b => b.CancellationReason).HasMaxLength(500);
        builder.Property(b => b.Status).HasConversion<int>();

        // Shown to users instead of the primary key.
        builder.HasIndex(b => b.Reference).IsUnique();

        // Restrict throughout: a booking is history and is never deleted along
        // with the rows it points at. It also keeps SQL Server free of multiple
        // cascade paths into this table.
        builder
            .HasOne(b => b.ClientProfile)
            .WithMany(c => c.Bookings)
            .HasForeignKey(b => b.ClientProfileId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(b => b.TrainerProfile)
            .WithMany(t => t.Bookings)
            .HasForeignKey(b => b.TrainerProfileId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(b => b.Service)
            .WithMany(s => s.Bookings)
            .HasForeignKey(b => b.ServiceId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(b => b.Location)
            .WithMany(l => l.Bookings)
            .HasForeignKey(b => b.LocationId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(b => b.Membership)
            .WithMany(m => m.Bookings)
            .HasForeignKey(b => b.MembershipId)
            .OnDelete(DeleteBehavior.Restrict);

        // Double-booking guard at the database level, not just in the service:
        // one live booking per trainer per start time. Cancelled (4) and
        // rejected (5) bookings are excluded so a slot can be rebooked.
        builder
            .HasIndex(b => new { b.TrainerProfileId, b.StartsAtUtc })
            .IsUnique()
            .HasFilter("[Status] < 4");

        builder.HasIndex(b => b.Status);

        builder.ToTable(t =>
            t.HasCheckConstraint("CK_Booking_Window", "[EndsAtUtc] > [StartsAtUtc]"));
    }
}
