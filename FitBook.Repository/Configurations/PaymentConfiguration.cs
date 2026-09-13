using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace FitBook.Repository.Configurations;

public class PaymentConfiguration : IEntityTypeConfiguration<Payment>
{
    public void Configure(EntityTypeBuilder<Payment> builder)
    {
        builder.HasKey(p => p.Id);

        builder.Property(p => p.Amount).HasPrecision(10, 2);
        builder.Property(p => p.RefundedAmount).HasPrecision(10, 2);
        builder.Property(p => p.Currency).IsRequired().HasMaxLength(3);
        builder.Property(p => p.Status).HasConversion<int>();
        builder.Property(p => p.StripePaymentIntentId).HasMaxLength(120);
        builder.Property(p => p.CardBrand).HasMaxLength(40);
        builder.Property(p => p.CardLast4).HasMaxLength(4);

        // One payment per booking, and payments outlive nothing they reference.
        builder
            .HasOne(p => p.Booking)
            .WithOne(b => b.Payment)
            .HasForeignKey<Payment>(p => p.BookingId)
            .OnDelete(DeleteBehavior.Restrict);

        builder
            .HasOne(p => p.Membership)
            .WithMany(m => m.Payments)
            .HasForeignKey(p => p.MembershipId)
            .OnDelete(DeleteBehavior.Restrict);

        // What makes confirm-payment idempotent: the same PaymentIntent can
        // never be recorded twice. Filtered, because the id is null until Stripe
        // issues it.
        builder
            .HasIndex(p => p.StripePaymentIntentId)
            .IsUnique()
            .HasFilter("[StripePaymentIntentId] IS NOT NULL");

        builder.ToTable(t =>
        {
            // A payment settles exactly one thing: a booking or a membership.
            t.HasCheckConstraint(
                "CK_Payment_Target",
                "([BookingId] IS NOT NULL AND [MembershipId] IS NULL) "
                    + "OR ([BookingId] IS NULL AND [MembershipId] IS NOT NULL)");

            t.HasCheckConstraint("CK_Payment_Amount", "[Amount] >= 0");
        });
    }
}
