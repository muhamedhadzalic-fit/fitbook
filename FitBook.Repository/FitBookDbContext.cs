using FitBook.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace FitBook.Repository;

/// <summary>
/// The application's EF Core context. Entity configuration lives in
/// <c>Configurations/</c> as <see cref="IEntityTypeConfiguration{TEntity}"/>
/// classes rather than inline here, so each table's mapping sits in one file.
/// </summary>
public class FitBookDbContext(DbContextOptions<FitBookDbContext> options) : DbContext(options)
{
    // Accounts and roles
    public DbSet<User> Users => Set<User>();
    public DbSet<Role> Roles => Set<Role>();
    public DbSet<UserRole> UserRoles => Set<UserRole>();
    public DbSet<ClientProfile> ClientProfiles => Set<ClientProfile>();
    public DbSet<TrainerProfile> TrainerProfiles => Set<TrainerProfile>();
    public DbSet<TrainerDocument> TrainerDocuments => Set<TrainerDocument>();

    // Offerings and scheduling
    public DbSet<Service> Services => Set<Service>();
    public DbSet<Availability> Availabilities => Set<Availability>();
    public DbSet<Booking> Bookings => Set<Booking>();

    // Money
    public DbSet<Payment> Payments => Set<Payment>();
    public DbSet<MembershipPlan> MembershipPlans => Set<MembershipPlan>();
    public DbSet<Membership> Memberships => Set<Membership>();

    // Engagement
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<News> News => Set<News>();
    public DbSet<SearchHistory> SearchHistory => Set<SearchHistory>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();

    // Reference data
    public DbSet<Country> Countries => Set<Country>();
    public DbSet<City> Cities => Set<City>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Speciality> Specialities => Set<Speciality>();
    public DbSet<TrainerSpeciality> TrainerSpecialities => Set<TrainerSpeciality>();
    public DbSet<Location> Locations => Set<Location>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(FitBookDbContext).Assembly);
    }
}
