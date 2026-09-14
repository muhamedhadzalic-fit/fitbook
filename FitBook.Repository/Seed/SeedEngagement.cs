using FitBook.Domain.Entities;
using FitBook.Domain.Enums;

namespace FitBook.Repository.Seed;

/// <summary>
/// Notifications, announcements, recommender signals and the audit trail.
/// </summary>
/// <remarks>
/// <see cref="SearchHistory"/> is not decoration: it is the evidence the
/// recommender scores against, so the rows here correspond to real behaviour by
/// the seeded clients — the specialities they filtered by, the trainers they
/// opened, and the city they searched in. <see cref="AuditLogs"/> mirrors every
/// state change in <see cref="SeedActivity"/>, so each booking's timeline and
/// each verification decision can be traced to who did it and why.
/// </remarks>
internal static class SeedEngagement
{
    public static readonly Notification[] Notifications =
    [
        new() { Id = 1, UserId = 9, Title = "Booking confirmed", Body = "Ana Kovač confirmed your session on 15 September at 07:00.", Tone = NotificationTone.Success, IsRead = true, CreatedAt = new DateTime(2026, 9, 12, 18, 40, 0, DateTimeKind.Utc), ReadAt = new DateTime(2026, 9, 12, 19, 2, 0, DateTimeKind.Utc) },
        new() { Id = 2, UserId = 9, Title = "Payment received", Body = "Your membership payment of 99,00 KM was processed successfully.", Tone = NotificationTone.Success, IsRead = true, CreatedAt = new DateTime(2026, 9, 1, 8, 7, 0, DateTimeKind.Utc), ReadAt = new DateTime(2026, 9, 1, 9, 0, 0, DateTimeKind.Utc) },
        new() { Id = 3, UserId = 9, Title = "Eight sessions left", Body = "Your Premium membership renews on 1 October.", Tone = NotificationTone.Info, IsRead = false, CreatedAt = new DateTime(2026, 9, 13, 6, 0, 0, DateTimeKind.Utc) },
        new() { Id = 4, UserId = 10, Title = "Booking confirmed", Body = "Marko Petrić confirmed your session on 15 September at 16:00.", Tone = NotificationTone.Success, IsRead = false, CreatedAt = new DateTime(2026, 9, 12, 7, 5, 0, DateTimeKind.Utc) },
        new() { Id = 5, UserId = 11, Title = "Booking cancelled", Body = "Your session on 15 September was cancelled and 32,00 KM has been refunded.", Tone = NotificationTone.Warning, IsRead = false, CreatedAt = new DateTime(2026, 9, 10, 9, 30, 0, DateTimeKind.Utc) },
        new() { Id = 6, UserId = 13, Title = "Booking declined", Body = "Marko Petrić could not take your session on 15 September. The slot was already committed to another client.", Tone = NotificationTone.Error, IsRead = true, CreatedAt = new DateTime(2026, 9, 9, 19, 0, 0, DateTimeKind.Utc), ReadAt = new DateTime(2026, 9, 9, 20, 15, 0, DateTimeKind.Utc) },
        new() { Id = 7, UserId = 3, Title = "New booking request", Body = "Džana Mujkić requested HIIT conditioning on 17 September at 16:00.", Tone = NotificationTone.Info, IsRead = false, CreatedAt = new DateTime(2026, 9, 14, 6, 45, 0, DateTimeKind.Utc) },
        new() { Id = 8, UserId = 5, Title = "New booking request", Body = "Haris Demirović requested Boxing pads and footwork on 18 September at 18:00.", Tone = NotificationTone.Info, IsRead = false, CreatedAt = new DateTime(2026, 9, 14, 7, 10, 0, DateTimeKind.Utc) },
        new() { Id = 9, UserId = 6, Title = "Application received", Body = "Your trainer application is pending review. We will let you know as soon as an administrator has looked at it.", Tone = NotificationTone.Info, IsRead = true, CreatedAt = new DateTime(2026, 9, 12, 7, 30, 0, DateTimeKind.Utc), ReadAt = new DateTime(2026, 9, 12, 8, 0, 0, DateTimeKind.Utc) },
        new() { Id = 10, UserId = 8, Title = "Application rejected", Body = "Your application was not approved: the federation licence expired before submission. You can resubmit with a valid licence.", Tone = NotificationTone.Error, IsRead = false, CreatedAt = new DateTime(2026, 9, 2, 9, 10, 0, DateTimeKind.Utc) },
        new() { Id = 11, UserId = 2, Title = "New review", Body = "Amila Đedović left you a five star review.", Tone = NotificationTone.Success, IsRead = true, CreatedAt = new DateTime(2026, 8, 20, 12, 1, 0, DateTimeKind.Utc), ReadAt = new DateTime(2026, 8, 20, 18, 0, 0, DateTimeKind.Utc) },
        new() { Id = 12, UserId = 1, Title = "Two applications waiting", Body = "Lejla Hodžić and Goran Lukić are awaiting verification.", Tone = NotificationTone.Warning, IsRead = false, CreatedAt = new DateTime(2026, 9, 13, 11, 10, 0, DateTimeKind.Utc) },
    ];

    public static readonly News[] News =
    [
        new() { Id = 1, Title = "FitBook je sada dostupan u Tuzli i Zenici", Body = "Od ovog mjeseca možete rezervisati termine kod verifikovanih trenera u Tuzli i Zenici. Nove lokacije dodajemo svakog mjeseca.", ImagePath = "uploads/news/new-cities.jpg", IsPublished = true, PublishedAt = new DateTime(2026, 9, 1, 9, 0, 0, DateTimeKind.Utc), AuthorUserId = 1 },
        new() { Id = 2, Title = "Kako biramo i verifikujemo trenere", Body = "Svaki trener prolazi provjeru identiteta, certifikata i referenci prije nego što može primati rezervacije. Objašnjavamo cijeli proces korak po korak.", ImagePath = "uploads/news/verification.jpg", IsPublished = true, PublishedAt = new DateTime(2026, 8, 18, 10, 30, 0, DateTimeKind.Utc), AuthorUserId = 1 },
        new() { Id = 3, Title = "Nove članarine stižu u oktobru", Body = "Pripremamo godišnje pakete sa popustom. Detalji uskoro.", IsPublished = false, PublishedAt = new DateTime(2026, 9, 14, 8, 0, 0, DateTimeKind.Utc), AuthorUserId = 1 },
    ];

    public static readonly SearchHistory[] SearchHistory =
    [
        new() { Id = 1, UserId = 9, Query = "yoga sarajevo", SpecialityId = 1, CategoryId = 3, CityId = 1, CreatedAt = new DateTime(2026, 9, 10, 18, 12, 0, DateTimeKind.Utc) },
        new() { Id = 2, UserId = 9, SpecialityId = 1, ViewedTrainerProfileId = 1, CityId = 1, CreatedAt = new DateTime(2026, 9, 10, 18, 14, 0, DateTimeKind.Utc) },
        new() { Id = 3, UserId = 9, SpecialityId = 2, CategoryId = 3, CityId = 1, CreatedAt = new DateTime(2026, 9, 11, 7, 40, 0, DateTimeKind.Utc) },
        new() { Id = 4, UserId = 9, ViewedTrainerProfileId = 1, CreatedAt = new DateTime(2026, 9, 12, 17, 55, 0, DateTimeKind.Utc) },
        new() { Id = 5, UserId = 10, Query = "crossfit", SpecialityId = 3, CategoryId = 1, CityId = 1, CreatedAt = new DateTime(2026, 9, 9, 20, 0, 0, DateTimeKind.Utc) },
        new() { Id = 6, UserId = 10, SpecialityId = 4, ViewedTrainerProfileId = 2, CityId = 1, CreatedAt = new DateTime(2026, 9, 9, 20, 5, 0, DateTimeKind.Utc) },
        new() { Id = 7, UserId = 10, Query = "hiit večernji termini", SpecialityId = 4, CityId = 1, CreatedAt = new DateTime(2026, 9, 11, 19, 20, 0, DateTimeKind.Utc) },
        new() { Id = 8, UserId = 11, Query = "rehabilitacija koljeno", CategoryId = 5, CityId = 2, CreatedAt = new DateTime(2026, 8, 23, 13, 0, 0, DateTimeKind.Utc) },
        new() { Id = 9, UserId = 11, SpecialityId = 5, ViewedTrainerProfileId = 3, CityId = 2, CreatedAt = new DateTime(2026, 8, 23, 13, 6, 0, DateTimeKind.Utc) },
        new() { Id = 10, UserId = 12, Query = "trčanje priprema polumaraton", SpecialityId = 9, CategoryId = 2, CityId = 3, CreatedAt = new DateTime(2026, 9, 13, 8, 0, 0, DateTimeKind.Utc) },
        new() { Id = 11, UserId = 12, SpecialityId = 5, ViewedTrainerProfileId = 3, CityId = 2, CreatedAt = new DateTime(2026, 9, 13, 8, 20, 0, DateTimeKind.Utc) },
        new() { Id = 12, UserId = 12, ViewedTrainerProfileId = 4, CityId = 1, CreatedAt = new DateTime(2026, 9, 14, 7, 5, 0, DateTimeKind.Utc) },
        new() { Id = 13, UserId = 13, Query = "boks početnici", SpecialityId = 6, CategoryId = 4, CityId = 1, CreatedAt = new DateTime(2026, 9, 8, 21, 0, 0, DateTimeKind.Utc) },
        new() { Id = 14, UserId = 13, SpecialityId = 4, ViewedTrainerProfileId = 2, CityId = 1, CreatedAt = new DateTime(2026, 9, 14, 6, 40, 0, DateTimeKind.Utc) },
    ];

    public static readonly AuditLog[] AuditLogs =
    [
        // Trainer verification decisions
        new() { Id = 1, EntityName = "TrainerProfile", EntityId = 1, Action = "Verified", ActorUserId = 1, Description = "Identity, certification and references checked.", CreatedAt = new DateTime(2026, 2, 4, 9, 0, 0, DateTimeKind.Utc) },
        new() { Id = 2, EntityName = "TrainerProfile", EntityId = 2, Action = "Verified", ActorUserId = 1, Description = "Identity and CrossFit L2 certificate verified against the registry.", CreatedAt = new DateTime(2026, 2, 12, 10, 20, 0, DateTimeKind.Utc) },
        new() { Id = 3, EntityName = "TrainerProfile", EntityId = 3, Action = "Verified", ActorUserId = 1, Description = "Identity and coaching licence verified.", CreatedAt = new DateTime(2026, 3, 3, 8, 40, 0, DateTimeKind.Utc) },
        new() { Id = 4, EntityName = "TrainerProfile", EntityId = 4, Action = "Verified", ActorUserId = 1, Description = "Identity and federation licence verified.", CreatedAt = new DateTime(2026, 3, 20, 11, 15, 0, DateTimeKind.Utc) },
        new() { Id = 5, EntityName = "TrainerProfile", EntityId = 7, Action = "Rejected", ActorUserId = 1, Description = "Federation licence expired before the application was submitted.", CreatedAt = new DateTime(2026, 9, 2, 9, 10, 0, DateTimeKind.Utc) },

        // Booking transitions, one row per state change
        new() { Id = 6, EntityName = "Booking", EntityId = 1, Action = "Created", ActorUserId = 9, Description = "Client requested the session.", CreatedAt = new DateTime(2026, 8, 17, 19, 30, 0, DateTimeKind.Utc) },
        new() { Id = 7, EntityName = "Booking", EntityId = 1, Action = "Confirmed", ActorUserId = 2, Description = "Trainer accepted the request.", CreatedAt = new DateTime(2026, 8, 17, 20, 10, 0, DateTimeKind.Utc) },
        new() { Id = 8, EntityName = "Booking", EntityId = 1, Action = "Completed", ActorUserId = 2, Description = "Session took place.", CreatedAt = new DateTime(2026, 8, 20, 8, 5, 0, DateTimeKind.Utc) },
        new() { Id = 9, EntityName = "Booking", EntityId = 9, Action = "Cancelled", ActorUserId = 11, Description = "Client withdrew: travelling for work that week.", CreatedAt = new DateTime(2026, 9, 10, 9, 25, 0, DateTimeKind.Utc) },
        new() { Id = 10, EntityName = "Booking", EntityId = 10, Action = "Rejected", ActorUserId = 3, Description = "Trainer unavailable: the slot was already committed to another client.", CreatedAt = new DateTime(2026, 9, 9, 19, 0, 0, DateTimeKind.Utc) },
        new() { Id = 11, EntityName = "Booking", EntityId = 4, Action = "Confirmed", ActorUserId = 2, Description = "Trainer accepted the request.", CreatedAt = new DateTime(2026, 9, 12, 18, 40, 0, DateTimeKind.Utc) },

        // Payment events, where the actor is the provider rather than a person
        new() { Id = 12, EntityName = "Payment", EntityId = 1, Action = "Captured", Description = "Stripe confirmed the payment intent server-side.", CreatedAt = new DateTime(2026, 8, 17, 19, 33, 0, DateTimeKind.Utc) },
        new() { Id = 13, EntityName = "Payment", EntityId = 5, Action = "Refunded", Description = "Full refund of the amount actually charged after cancellation.", CreatedAt = new DateTime(2026, 9, 10, 9, 30, 0, DateTimeKind.Utc) },
    ];
}
