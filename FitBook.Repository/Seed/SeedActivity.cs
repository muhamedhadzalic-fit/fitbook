using FitBook.Domain.Entities;
using FitBook.Domain.Enums;

namespace FitBook.Repository.Seed;

/// <summary>
/// What the platform actually does: offerings, slots, memberships, bookings,
/// payments and reviews.
/// </summary>
/// <remarks>
/// Bookings cover every state the machine can reach, so the state machine and
/// both apps have something real to render. Two database rules shape the data:
/// the filtered unique index forbids two live bookings for one trainer at one
/// start time (cancelled and rejected rows are excluded, which is why one slot
/// legitimately appears twice), and a payment must settle exactly one of a
/// booking or a membership, never both.
/// </remarks>
internal static class SeedActivity
{
    public static readonly Service[] Services =
    [
        new() { Id = 1, TrainerProfileId = 1, CategoryId = 3, Title = "Vinyasa yoga, one to one", Description = "Breath-led flow built around your current mobility, with adjustments throughout.", Price = 35m, DurationMinutes = 60, ImagePath = "uploads/services/vinyasa.jpg", IsActive = true, CreatedAt = new DateTime(2026, 2, 5, 9, 0, 0, DateTimeKind.Utc) },
        new() { Id = 2, TrainerProfileId = 1, CategoryId = 3, Title = "Pilates mat fundamentals", Description = "Core control and alignment for beginners returning to movement.", Price = 32m, DurationMinutes = 45, ImagePath = "uploads/services/pilates.jpg", IsActive = true, CreatedAt = new DateTime(2026, 2, 5, 9, 15, 0, DateTimeKind.Utc) },
        new() { Id = 3, TrainerProfileId = 2, CategoryId = 1, Title = "Functional strength session", Description = "Compound lifts and accessory work programmed around your week.", Price = 45m, DurationMinutes = 60, ImagePath = "uploads/services/functional.jpg", IsActive = true, CreatedAt = new DateTime(2026, 2, 13, 8, 0, 0, DateTimeKind.Utc) },
        new() { Id = 4, TrainerProfileId = 2, CategoryId = 2, Title = "HIIT conditioning", Description = "Thirty minutes of interval work, scaled to your current conditioning.", Price = 30m, DurationMinutes = 30, ImagePath = "uploads/services/hiit.jpg", IsActive = true, CreatedAt = new DateTime(2026, 2, 13, 8, 20, 0, DateTimeKind.Utc) },
        new() { Id = 5, TrainerProfileId = 3, CategoryId = 1, Title = "Barbell technique clinic", Description = "Squat, bench and deadlift technique, filmed and reviewed with you.", Price = 40m, DurationMinutes = 75, ImagePath = "uploads/services/barbell.jpg", IsActive = true, CreatedAt = new DateTime(2026, 3, 4, 10, 0, 0, DateTimeKind.Utc) },
        new() { Id = 6, TrainerProfileId = 3, CategoryId = 5, Title = "Return to lifting after injury", Description = "Graded reloading programme written with your physiotherapist's notes.", Price = 44m, DurationMinutes = 60, ImagePath = "uploads/services/rehab.jpg", IsActive = true, CreatedAt = new DateTime(2026, 3, 4, 10, 25, 0, DateTimeKind.Utc) },
        new() { Id = 7, TrainerProfileId = 4, CategoryId = 4, Title = "Boxing pads and footwork", Description = "Technical striking work with pad rounds and movement drills.", Price = 50m, DurationMinutes = 60, ImagePath = "uploads/services/boxing.jpg", IsActive = true, CreatedAt = new DateTime(2026, 3, 21, 17, 0, 0, DateTimeKind.Utc) },
        new() { Id = 8, TrainerProfileId = 4, CategoryId = 4, Title = "Fight-camp conditioning", Description = "Rounds-based conditioning for competitors in camp.", Price = 55m, DurationMinutes = 90, ImagePath = "uploads/services/fightcamp.jpg", IsActive = true, CreatedAt = new DateTime(2026, 3, 21, 17, 30, 0, DateTimeKind.Utc) },
        new() { Id = 9, TrainerProfileId = 1, CategoryId = 6, Title = "Nutrition review", Description = "A single consultation reviewing your intake against your training load.", Price = 28m, DurationMinutes = 45, IsActive = true, CreatedAt = new DateTime(2026, 4, 2, 11, 0, 0, DateTimeKind.Utc) },
        new() { Id = 10, TrainerProfileId = 2, CategoryId = 1, Title = "Strength block review", Description = "Programme audit and next-block planning, no session included.", Price = 25m, DurationMinutes = 30, IsActive = false, CreatedAt = new DateTime(2026, 4, 18, 9, 30, 0, DateTimeKind.Utc) },
    ];

    public static readonly Availability[] Availabilities =
    [
        new() { Id = 1, TrainerProfileId = 1, StartsAtUtc = new DateTime(2026, 9, 15, 7, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 8, 0, 0, DateTimeKind.Utc), IsBooked = true },
        new() { Id = 2, TrainerProfileId = 1, StartsAtUtc = new DateTime(2026, 9, 15, 8, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 9, 0, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 3, TrainerProfileId = 1, StartsAtUtc = new DateTime(2026, 9, 16, 7, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 16, 8, 0, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 4, TrainerProfileId = 1, StartsAtUtc = new DateTime(2026, 9, 17, 17, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 17, 18, 0, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 5, TrainerProfileId = 2, StartsAtUtc = new DateTime(2026, 9, 15, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 17, 0, 0, DateTimeKind.Utc), IsBooked = true },
        new() { Id = 6, TrainerProfileId = 2, StartsAtUtc = new DateTime(2026, 9, 16, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 16, 17, 0, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 7, TrainerProfileId = 2, StartsAtUtc = new DateTime(2026, 9, 17, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 17, 17, 0, 0, DateTimeKind.Utc), IsBooked = true },
        new() { Id = 8, TrainerProfileId = 2, StartsAtUtc = new DateTime(2026, 9, 18, 9, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 18, 9, 30, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 9, TrainerProfileId = 3, StartsAtUtc = new DateTime(2026, 9, 16, 10, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 16, 11, 15, 0, DateTimeKind.Utc), IsBooked = true },
        new() { Id = 10, TrainerProfileId = 3, StartsAtUtc = new DateTime(2026, 9, 17, 10, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 17, 11, 15, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 11, TrainerProfileId = 3, StartsAtUtc = new DateTime(2026, 9, 19, 10, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 19, 11, 0, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 12, TrainerProfileId = 4, StartsAtUtc = new DateTime(2026, 9, 18, 18, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 18, 19, 0, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 13, TrainerProfileId = 4, StartsAtUtc = new DateTime(2026, 9, 19, 18, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 19, 19, 30, 0, DateTimeKind.Utc), IsBooked = false },
        new() { Id = 14, TrainerProfileId = 1, StartsAtUtc = new DateTime(2026, 8, 20, 7, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 20, 8, 0, 0, DateTimeKind.Utc), IsBooked = true },
        new() { Id = 15, TrainerProfileId = 2, StartsAtUtc = new DateTime(2026, 8, 25, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 25, 17, 0, 0, DateTimeKind.Utc), IsBooked = true },
        new() { Id = 16, TrainerProfileId = 3, StartsAtUtc = new DateTime(2026, 8, 28, 10, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 28, 11, 15, 0, DateTimeKind.Utc), IsBooked = true },
    ];

    public static readonly Membership[] Memberships =
    [
        new() { Id = 1, ClientProfileId = 1, MembershipPlanId = 2, Status = MembershipStatus.Active, StartsAtUtc = new DateTime(2026, 9, 1, 0, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 10, 1, 0, 0, 0, DateTimeKind.Utc), SessionsRemaining = 8, CreatedAt = new DateTime(2026, 9, 1, 8, 5, 0, DateTimeKind.Utc) },
        new() { Id = 2, ClientProfileId = 2, MembershipPlanId = 1, Status = MembershipStatus.Active, StartsAtUtc = new DateTime(2026, 9, 5, 0, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 10, 5, 0, 0, 0, DateTimeKind.Utc), SessionsRemaining = 3, CreatedAt = new DateTime(2026, 9, 5, 19, 40, 0, DateTimeKind.Utc) },
        new() { Id = 3, ClientProfileId = 3, MembershipPlanId = 1, Status = MembershipStatus.Expired, StartsAtUtc = new DateTime(2026, 7, 1, 0, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 1, 0, 0, 0, DateTimeKind.Utc), SessionsRemaining = 0, CreatedAt = new DateTime(2026, 7, 1, 12, 0, 0, DateTimeKind.Utc) },
    ];

    public static readonly Booking[] Bookings =
    [
        // Completed, reviewed
        new() { Id = 1, Reference = "FB-2801", ClientProfileId = 1, TrainerProfileId = 1, ServiceId = 1, LocationId = 1, StartsAtUtc = new DateTime(2026, 8, 20, 7, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 20, 8, 0, 0, DateTimeKind.Utc), Status = BookingStatus.Completed, Amount = 35m, ClientNotes = "Lower back has been stiff all week.", CreatedAt = new DateTime(2026, 8, 17, 19, 30, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 8, 17, 20, 10, 0, DateTimeKind.Utc), CompletedAt = new DateTime(2026, 8, 20, 8, 5, 0, DateTimeKind.Utc) },
        new() { Id = 2, Reference = "FB-2812", ClientProfileId = 2, TrainerProfileId = 2, ServiceId = 3, LocationId = 2, StartsAtUtc = new DateTime(2026, 8, 25, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 25, 17, 0, 0, DateTimeKind.Utc), Status = BookingStatus.Completed, Amount = 45m, CreatedAt = new DateTime(2026, 8, 22, 9, 0, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 8, 22, 12, 45, 0, DateTimeKind.Utc), CompletedAt = new DateTime(2026, 8, 25, 17, 10, 0, DateTimeKind.Utc) },
        new() { Id = 3, Reference = "FB-2818", ClientProfileId = 3, TrainerProfileId = 3, ServiceId = 6, LocationId = 3, StartsAtUtc = new DateTime(2026, 8, 28, 10, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 8, 28, 11, 15, 0, DateTimeKind.Utc), Status = BookingStatus.Completed, Amount = 44m, ClientNotes = "Cleared by physio two weeks ago.", CreatedAt = new DateTime(2026, 8, 24, 14, 0, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 8, 24, 15, 30, 0, DateTimeKind.Utc), CompletedAt = new DateTime(2026, 8, 28, 11, 20, 0, DateTimeKind.Utc) },

        // Confirmed, upcoming
        new() { Id = 4, Reference = "FB-2841", ClientProfileId = 1, TrainerProfileId = 1, ServiceId = 1, LocationId = 1, MembershipId = 1, StartsAtUtc = new DateTime(2026, 9, 15, 7, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 8, 0, 0, DateTimeKind.Utc), Status = BookingStatus.Confirmed, Amount = 35m, CreatedAt = new DateTime(2026, 9, 12, 18, 0, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 9, 12, 18, 40, 0, DateTimeKind.Utc) },
        new() { Id = 5, Reference = "FB-2847", ClientProfileId = 2, TrainerProfileId = 2, ServiceId = 3, LocationId = 2, MembershipId = 2, StartsAtUtc = new DateTime(2026, 9, 15, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 17, 0, 0, DateTimeKind.Utc), Status = BookingStatus.Confirmed, Amount = 45m, CreatedAt = new DateTime(2026, 9, 11, 20, 15, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 9, 12, 7, 5, 0, DateTimeKind.Utc) },
        new() { Id = 6, Reference = "FB-2852", ClientProfileId = 4, TrainerProfileId = 3, ServiceId = 5, LocationId = 3, StartsAtUtc = new DateTime(2026, 9, 16, 10, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 16, 11, 15, 0, DateTimeKind.Utc), Status = BookingStatus.Confirmed, Amount = 40m, ClientNotes = "Filming the squat set if that is alright.", CreatedAt = new DateTime(2026, 9, 13, 8, 30, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 9, 13, 9, 0, 0, DateTimeKind.Utc) },

        // Pending — the trainer's decision queue
        new() { Id = 7, Reference = "FB-2860", ClientProfileId = 5, TrainerProfileId = 2, ServiceId = 4, LocationId = 2, StartsAtUtc = new DateTime(2026, 9, 17, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 17, 16, 30, 0, DateTimeKind.Utc), Status = BookingStatus.Pending, Amount = 30m, ClientNotes = "First HIIT session, please start easy.", CreatedAt = new DateTime(2026, 9, 14, 6, 45, 0, DateTimeKind.Utc) },
        new() { Id = 8, Reference = "FB-2861", ClientProfileId = 4, TrainerProfileId = 4, ServiceId = 7, LocationId = 1, StartsAtUtc = new DateTime(2026, 9, 18, 18, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 18, 19, 0, 0, DateTimeKind.Utc), Status = BookingStatus.Pending, Amount = 50m, CreatedAt = new DateTime(2026, 9, 14, 7, 10, 0, DateTimeKind.Utc) },

        // Cancelled by the client, and rejected by the trainer with a reason.
        // Both sit on slots that live bookings also use, which the filtered
        // unique index permits precisely because their status is 4 or higher.
        new() { Id = 9, Reference = "FB-2833", ClientProfileId = 3, TrainerProfileId = 1, ServiceId = 2, LocationId = 1, StartsAtUtc = new DateTime(2026, 9, 15, 7, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 7, 45, 0, DateTimeKind.Utc), Status = BookingStatus.Cancelled, Amount = 32m, CreatedAt = new DateTime(2026, 9, 8, 11, 0, 0, DateTimeKind.Utc), ConfirmedAt = new DateTime(2026, 9, 8, 12, 0, 0, DateTimeKind.Utc), CancelledAt = new DateTime(2026, 9, 10, 9, 25, 0, DateTimeKind.Utc), CancellationReason = "Client withdrew: travelling for work that week." },
        new() { Id = 10, Reference = "FB-2839", ClientProfileId = 5, TrainerProfileId = 2, ServiceId = 3, LocationId = 2, StartsAtUtc = new DateTime(2026, 9, 15, 16, 0, 0, DateTimeKind.Utc), EndsAtUtc = new DateTime(2026, 9, 15, 17, 0, 0, DateTimeKind.Utc), Status = BookingStatus.Rejected, Amount = 45m, CreatedAt = new DateTime(2026, 9, 9, 17, 30, 0, DateTimeKind.Utc), CancelledAt = new DateTime(2026, 9, 9, 19, 0, 0, DateTimeKind.Utc), CancellationReason = "Trainer unavailable: the slot was already committed to another client." },
    ];

    public static readonly Payment[] Payments =
    [
        // Session payments. Exactly one of BookingId / MembershipId is set.
        new() { Id = 1, BookingId = 1, Amount = 35m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_2801", IsPaid = true, CreatedAt = new DateTime(2026, 8, 17, 19, 32, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 8, 17, 19, 33, 0, DateTimeKind.Utc), CardBrand = "Visa", CardLast4 = "4242" },
        new() { Id = 2, BookingId = 2, Amount = 45m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_2812", IsPaid = true, CreatedAt = new DateTime(2026, 8, 22, 9, 2, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 8, 22, 9, 3, 0, DateTimeKind.Utc), CardBrand = "Mastercard", CardLast4 = "5556" },
        new() { Id = 3, BookingId = 3, Amount = 44m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_2818", IsPaid = true, CreatedAt = new DateTime(2026, 8, 24, 14, 3, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 8, 24, 14, 4, 0, DateTimeKind.Utc), CardBrand = "Visa", CardLast4 = "1881" },
        new() { Id = 4, BookingId = 6, Amount = 40m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_2852", IsPaid = true, CreatedAt = new DateTime(2026, 9, 13, 8, 32, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 9, 13, 8, 33, 0, DateTimeKind.Utc), CardBrand = "Visa", CardLast4 = "4242" },

        // Refunded, based on the amount actually charged, after the cancellation.
        new() { Id = 5, BookingId = 9, Amount = 32m, Currency = "BAM", Status = PaymentStatus.Refunded, StripePaymentIntentId = "pi_seed_2833", IsPaid = false, CreatedAt = new DateTime(2026, 9, 8, 11, 2, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 9, 8, 11, 3, 0, DateTimeKind.Utc), RefundedAmount = 32m, RefundedAtUtc = new DateTime(2026, 9, 10, 9, 30, 0, DateTimeKind.Utc), CardBrand = "Mastercard", CardLast4 = "5556" },

        // A payment still awaiting confirmation from Stripe.
        new() { Id = 6, BookingId = 8, Amount = 50m, Currency = "BAM", Status = PaymentStatus.Pending, StripePaymentIntentId = "pi_seed_2861", IsPaid = false, CreatedAt = new DateTime(2026, 9, 14, 7, 12, 0, DateTimeKind.Utc) },

        // Membership payments.
        new() { Id = 7, MembershipId = 1, Amount = 99m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_mem_1", IsPaid = true, CreatedAt = new DateTime(2026, 9, 1, 8, 6, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 9, 1, 8, 7, 0, DateTimeKind.Utc), CardBrand = "Visa", CardLast4 = "4242" },
        new() { Id = 8, MembershipId = 2, Amount = 49m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_mem_2", IsPaid = true, CreatedAt = new DateTime(2026, 9, 5, 19, 42, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 9, 5, 19, 43, 0, DateTimeKind.Utc), CardBrand = "Mastercard", CardLast4 = "5556" },
        new() { Id = 9, MembershipId = 3, Amount = 49m, Currency = "BAM", Status = PaymentStatus.Succeeded, StripePaymentIntentId = "pi_seed_mem_3", IsPaid = true, CreatedAt = new DateTime(2026, 7, 1, 12, 2, 0, DateTimeKind.Utc), CapturedAtUtc = new DateTime(2026, 7, 1, 12, 3, 0, DateTimeKind.Utc), CardBrand = "Visa", CardLast4 = "1881" },
    ];

    /// <summary>Only completed bookings carry a review — the state machine refuses one any earlier.</summary>
    public static readonly Review[] Reviews =
    [
        new() { Id = 1, BookingId = 1, ClientProfileId = 1, TrainerProfileId = 1, Rating = 5, Comment = "Calm, precise and very attentive to how my back was feeling. Best session I have had.", CreatedAt = new DateTime(2026, 8, 20, 12, 0, 0, DateTimeKind.Utc) },
        new() { Id = 2, BookingId = 2, ClientProfileId = 2, TrainerProfileId = 2, Rating = 5, Comment = "Hard but scaled well. Explained why each block was there.", CreatedAt = new DateTime(2026, 8, 26, 8, 30, 0, DateTimeKind.Utc) },
        new() { Id = 3, BookingId = 3, ClientProfileId = 3, TrainerProfileId = 3, Rating = 4, Comment = "Careful with the knee and adjusted the loading twice. Would book again.", CreatedAt = new DateTime(2026, 8, 29, 10, 15, 0, DateTimeKind.Utc) },
    ];
}
