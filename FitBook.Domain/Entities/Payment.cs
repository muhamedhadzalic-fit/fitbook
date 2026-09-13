using FitBook.Domain.Enums;

namespace FitBook.Domain.Entities;

/// <summary>
/// A Stripe payment for either a booking or a membership. Finalized server-side
/// via webhook or server-side verification — the client never records a
/// successful payment — and confirmation is idempotent.
/// </summary>
public class Payment
{
    public int Id { get; set; }

    /// <summary>Set when this payment is for a single session.</summary>
    public int? BookingId { get; set; }

    public Booking? Booking { get; set; }

    /// <summary>Set when this payment is for a membership.</summary>
    public int? MembershipId { get; set; }

    public Membership? Membership { get; set; }

    /// <summary>Amount actually charged. Refunds are calculated from this, never from a recalculated price.</summary>
    public decimal Amount { get; set; }

    public string Currency { get; set; } = "BAM";

    public PaymentStatus Status { get; set; } = PaymentStatus.Pending;

    /// <summary>
    /// Stripe's PaymentIntent id. Unique, which is what makes confirmation
    /// idempotent and blocks double payment of the same item.
    /// </summary>
    public string? StripePaymentIntentId { get; set; }

    /// <summary>Drives the "Plaćeno" state and hides the pay button in both apps.</summary>
    public bool IsPaid { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? CapturedAtUtc { get; set; }

    public decimal? RefundedAmount { get; set; }

    public DateTime? RefundedAtUtc { get; set; }

    /// <summary>Display-only card metadata from Stripe; never full card data.</summary>
    public string? CardBrand { get; set; }

    public string? CardLast4 { get; set; }
}
