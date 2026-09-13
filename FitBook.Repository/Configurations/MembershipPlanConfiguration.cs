using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class MembershipPlanConfiguration : IEntityTypeConfiguration<MembershipPlan>
{
    public void Configure(EntityTypeBuilder<MembershipPlan> builder)
    {
        builder.HasKey(p => p.Id);

        builder.Property(p => p.Name).IsRequired().HasMaxLength(80);
        builder.Property(p => p.Description).HasMaxLength(400);
        builder.Property(p => p.MonthlyPrice).HasPrecision(10, 2);

        builder.HasIndex(p => p.Name).IsUnique();

        builder.ToTable(t =>
            t.HasCheckConstraint("CK_MembershipPlan_Price", "[MonthlyPrice] >= 0"));
    }
}
