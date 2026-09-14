using FitBook.Domain.Constants;
using FitBook.Domain.Entities;

namespace FitBook.Repository.Seed;

/// <summary>
/// Reference tables. These are the FK targets everything else points at, so
/// their ids are fixed and must not be renumbered.
/// </summary>
internal static class SeedReferenceData
{
    public static readonly Country[] Countries =
    [
        new() { Id = 1, Name = "Bosna i Hercegovina", IsoCode = "BA" },
        new() { Id = 2, Name = "Hrvatska", IsoCode = "HR" },
        new() { Id = 3, Name = "Srbija", IsoCode = "RS" },
    ];

    public static readonly City[] Cities =
    [
        new() { Id = 1, Name = "Sarajevo", PostalCode = "71000", CountryId = 1 },
        new() { Id = 2, Name = "Mostar", PostalCode = "88000", CountryId = 1 },
        new() { Id = 3, Name = "Tuzla", PostalCode = "75000", CountryId = 1 },
        new() { Id = 4, Name = "Zenica", PostalCode = "72000", CountryId = 1 },
        new() { Id = 5, Name = "Banja Luka", PostalCode = "78000", CountryId = 1 },
        new() { Id = 6, Name = "Bihać", PostalCode = "77000", CountryId = 1 },
    ];

    /// <summary>Roles. Names come from <see cref="RoleNames"/> so they match the authorization attributes exactly.</summary>
    public static readonly Role[] Roles =
    [
        new() { Id = 1, Name = RoleNames.Admin, Description = "Verifies trainers, manages reference data and reads reports." },
        new() { Id = 2, Name = RoleNames.Trainer, Description = "Offers services, manages availability, confirms or rejects bookings." },
        new() { Id = 3, Name = RoleNames.Client, Description = "Books sessions, pays, and reviews completed sessions." },
    ];

    public static readonly Category[] Categories =
    [
        new() { Id = 1, Name = "Strength & Conditioning", Description = "Barbell work, progressive overload and general strength." },
        new() { Id = 2, Name = "Cardio & Endurance", Description = "Heart-rate based training, intervals and stamina." },
        new() { Id = 3, Name = "Yoga & Mobility", Description = "Breathing, alignment and long-term mobility." },
        new() { Id = 4, Name = "Combat Sports", Description = "Striking, grappling and fight conditioning." },
        new() { Id = 5, Name = "Rehabilitation", Description = "Return-to-training work after injury." },
        new() { Id = 6, Name = "Nutrition Coaching", Description = "Meal planning alongside a training programme." },
    ];

    public static readonly Speciality[] Specialities =
    [
        new() { Id = 1, Name = "Yoga" },
        new() { Id = 2, Name = "Pilates" },
        new() { Id = 3, Name = "CrossFit" },
        new() { Id = 4, Name = "HIIT" },
        new() { Id = 5, Name = "Strength" },
        new() { Id = 6, Name = "Boxing" },
        new() { Id = 7, Name = "MMA" },
        new() { Id = 8, Name = "Cardio" },
        new() { Id = 9, Name = "Running" },
        new() { Id = 10, Name = "Nutrition" },
    ];

    public static readonly Location[] Locations =
    [
        new() { Id = 1, Name = "FitZone Centar", Address = "Maršala Tita 28", District = "Centar", CityId = 1 },
        new() { Id = 2, Name = "Olimp Gym", Address = "Zmaja od Bosne 4", District = "Marijin Dvor", CityId = 1 },
        new() { Id = 3, Name = "Studio Balans", Address = "Kralja Petra Krešimira IV 12", District = "Rondo", CityId = 2 },
        new() { Id = 4, Name = "Arena Fit", Address = "Slatina 9", District = "Slatina", CityId = 3 },
        new() { Id = 5, Name = "Core Studio", Address = "Školska 3", District = "Centar", CityId = 4 },
    ];

    public static readonly MembershipPlan[] MembershipPlans =
    [
        new()
        {
            Id = 1,
            Name = "Basic",
            Description = "Four coached sessions a month, booked at standard rates.",
            MonthlyPrice = 49m,
            SessionsIncluded = 4,
            IsActive = true,
        },
        new()
        {
            Id = 2,
            Name = "Premium",
            Description = "Ten coached sessions a month with priority booking.",
            MonthlyPrice = 99m,
            SessionsIncluded = 10,
            IsActive = true,
        },
        new()
        {
            Id = 3,
            Name = "Elite",
            Description = "Twenty sessions a month, nutrition coaching included.",
            MonthlyPrice = 169m,
            SessionsIncluded = 20,
            IsActive = true,
        },
    ];
}
