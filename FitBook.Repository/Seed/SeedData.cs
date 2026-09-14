using Microsoft.EntityFrameworkCore;

namespace FitBook.Repository.Seed;

/// <summary>
/// The single entry point for seed data, called from
/// <see cref="FitBookDbContext.OnModelCreating"/>.
/// </summary>
/// <remarks>
/// Seed data lives here rather than inside the <c>IEntityTypeConfiguration</c>
/// classes on purpose: those files describe the *mapping* of a table, and
/// spreading <c>HasData</c> across all 23 of them would mean touching every
/// mapping file whenever a row changes. One place also makes the insert order
/// and the foreign-key relationships between the fixtures readable in a single
/// pass.
/// <para>
/// Everything here is a compile-time literal, including dates and password
/// hashes. HasData values must be deterministic — anything computed at
/// model-build time, such as <c>DateTime.UtcNow</c> or a freshly salted hash,
/// makes EF detect a model change on every migration.
/// </para>
/// </remarks>
internal static class SeedData
{
    public static void Apply(ModelBuilder modelBuilder)
    {
        // Reference data first: everything below points at it.
        modelBuilder.Entity<Domain.Entities.Country>().HasData(SeedReferenceData.Countries);
        modelBuilder.Entity<Domain.Entities.City>().HasData(SeedReferenceData.Cities);
        modelBuilder.Entity<Domain.Entities.Role>().HasData(SeedReferenceData.Roles);
        modelBuilder.Entity<Domain.Entities.Category>().HasData(SeedReferenceData.Categories);
        modelBuilder.Entity<Domain.Entities.Speciality>().HasData(SeedReferenceData.Specialities);
        modelBuilder.Entity<Domain.Entities.Location>().HasData(SeedReferenceData.Locations);
        modelBuilder.Entity<Domain.Entities.MembershipPlan>().HasData(SeedReferenceData.MembershipPlans);

        // Accounts and profiles.
        modelBuilder.Entity<Domain.Entities.User>().HasData(SeedAccounts.Users);
        modelBuilder.Entity<Domain.Entities.UserRole>().HasData(SeedAccounts.UserRoles);
        modelBuilder.Entity<Domain.Entities.ClientProfile>().HasData(SeedAccounts.ClientProfiles);
        modelBuilder.Entity<Domain.Entities.TrainerProfile>().HasData(SeedAccounts.TrainerProfiles);
        modelBuilder.Entity<Domain.Entities.TrainerSpeciality>().HasData(SeedAccounts.TrainerSpecialities);
        modelBuilder.Entity<Domain.Entities.TrainerDocument>().HasData(SeedAccounts.TrainerDocuments);

        // Offerings, scheduling, money.
        modelBuilder.Entity<Domain.Entities.Service>().HasData(SeedActivity.Services);
        modelBuilder.Entity<Domain.Entities.Availability>().HasData(SeedActivity.Availabilities);
        modelBuilder.Entity<Domain.Entities.Membership>().HasData(SeedActivity.Memberships);
        modelBuilder.Entity<Domain.Entities.Booking>().HasData(SeedActivity.Bookings);
        modelBuilder.Entity<Domain.Entities.Payment>().HasData(SeedActivity.Payments);
        modelBuilder.Entity<Domain.Entities.Review>().HasData(SeedActivity.Reviews);

        // Engagement, recommender signals and the audit trail.
        modelBuilder.Entity<Domain.Entities.Notification>().HasData(SeedEngagement.Notifications);
        modelBuilder.Entity<Domain.Entities.News>().HasData(SeedEngagement.News);
        modelBuilder.Entity<Domain.Entities.SearchHistory>().HasData(SeedEngagement.SearchHistory);
        modelBuilder.Entity<Domain.Entities.AuditLog>().HasData(SeedEngagement.AuditLogs);
    }
}
