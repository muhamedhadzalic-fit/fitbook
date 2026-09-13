using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class MembershipConfiguration : IEntityTypeConfiguration<Membership>
{
    public void Configure(EntityTypeBuilder<Membership> builder)
    {
        builder.HasKey(m => m.Id);

        builder.Property(m => m.Status).HasConversion<int>();

        builder
            .HasOne(m => m.ClientProfile)
            .WithMany(c => c.Memberships)
            .HasForeignKey(m => m.ClientProfileId)
            .OnDelete(DeleteBehavior.Cascade);

        builder
            .HasOne(m => m.MembershipPlan)
            .WithMany(p => p.Memberships)
            // A plan someone has bought cannot be deleted.
            .HasForeignKey(m => m.MembershipPlanId)
            .OnDelete(DeleteBehavior.Restrict);

        // The active-membership precondition check reads this way.
        builder.HasIndex(m => new { m.ClientProfileId, m.Status });

        builder.ToTable(t =>
        {
            t.HasCheckConstraint("CK_Membership_Window", "[EndsAtUtc] > [StartsAtUtc]");
            t.HasCheckConstraint("CK_Membership_Sessions", "[SessionsRemaining] >= 0");
        });
    }
}
