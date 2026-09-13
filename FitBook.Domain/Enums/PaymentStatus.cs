namespace FitBook.Domain.Enums;

/// <summary>
/// State of a Stripe payment. Only the server sets this — never the client.
/// </summary>
public enum PaymentStatus
{
    /// <summary>Intent created, not yet confirmed by Stripe.</summary>
    Pending = 1,

    /// <summary>Funds captured, verified server-side.</summary>
    Succeeded = 2,

    /// <summary>Stripe reported a failure.</summary>
    Failed = 3,

    /// <summary>Fully refunded, based on the amount actually charged.</summary>
    Refunded = 4,

    /// <summary>Partially refunded, based on the amount actually charged.</summary>
    PartiallyRefunded = 5,
}
