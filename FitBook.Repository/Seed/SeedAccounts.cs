using FitBook.Domain.Entities;
using FitBook.Domain.Enums;

namespace FitBook.Repository.Seed;

/// <summary>
/// Accounts and profiles: one admin, seven trainers and five clients.
/// </summary>
/// <remarks>
/// The trainer set deliberately covers every verification state, so the admin
/// app's queue has real work in it: four Verified, two Pending awaiting review,
/// and one Rejected carrying its reason. Every password is <c>test</c>; the
/// hashes live in <see cref="SeedPasswords"/>.
/// </remarks>
internal static class SeedAccounts
{
    private static readonly DateTime Registered = new(2026, 1, 15, 9, 0, 0, DateTimeKind.Utc);

    public static readonly User[] Users =
    [
        new()
        {
            Id = 1, FirstName = "Emir", LastName = "Selimović", Email = "admin@fitbook.ba",
            PhoneNumber = "+387 61 000 001", PasswordHash = SeedPasswords.User1,
            CityId = 1, IsActive = true, CreatedAt = Registered,
        },

        // Trainers
        new()
        {
            Id = 2, FirstName = "Ana", LastName = "Kovač", Email = "ana.kovac@fitbook.ba",
            PhoneNumber = "+387 61 234 111", PasswordHash = SeedPasswords.User2,
            CityId = 1, ProfileImagePath = "uploads/trainers/ana-kovac.jpg",
            IsActive = true, CreatedAt = new DateTime(2026, 2, 3, 10, 30, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 3, FirstName = "Marko", LastName = "Petrić", Email = "marko.petric@fitbook.ba",
            PhoneNumber = "+387 61 234 222", PasswordHash = SeedPasswords.User3,
            CityId = 1, ProfileImagePath = "uploads/trainers/marko-petric.jpg",
            IsActive = true, CreatedAt = new DateTime(2026, 2, 11, 8, 15, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 4, FirstName = "Iva", LastName = "Milić", Email = "iva.milic@fitbook.ba",
            PhoneNumber = "+387 63 234 333", PasswordHash = SeedPasswords.User4,
            CityId = 2, ProfileImagePath = "uploads/trainers/iva-milic.jpg",
            IsActive = true, CreatedAt = new DateTime(2026, 3, 2, 12, 0, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 5, FirstName = "Damir", LastName = "Jurić", Email = "damir.juric@fitbook.ba",
            PhoneNumber = "+387 62 234 444", PasswordHash = SeedPasswords.User5,
            CityId = 1, ProfileImagePath = "uploads/trainers/damir-juric.jpg",
            IsActive = true, CreatedAt = new DateTime(2026, 3, 19, 16, 45, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 6, FirstName = "Lejla", LastName = "Hodžić", Email = "lejla.hodzic@fitbook.ba",
            PhoneNumber = "+387 61 234 567", PasswordHash = SeedPasswords.User6,
            CityId = 3, IsActive = true, CreatedAt = new DateTime(2026, 9, 12, 7, 20, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 7, FirstName = "Goran", LastName = "Lukić", Email = "goran.lukic@fitbook.ba",
            PhoneNumber = "+387 63 771 402", PasswordHash = SeedPasswords.User7,
            CityId = 2, IsActive = true, CreatedAt = new DateTime(2026, 9, 13, 11, 5, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 8, FirstName = "Mirza", LastName = "Aldić", Email = "mirza.aldic@fitbook.ba",
            PhoneNumber = "+387 62 118 903", PasswordHash = SeedPasswords.User8,
            CityId = 1, IsActive = true, CreatedAt = new DateTime(2026, 8, 30, 14, 40, 0, DateTimeKind.Utc),
        },

        // Clients
        new()
        {
            Id = 9, FirstName = "Amila", LastName = "Đedović", Email = "amila.dedovic@fitbook.ba",
            PhoneNumber = "+387 61 555 101", PasswordHash = SeedPasswords.User9,
            CityId = 1, ProfileImagePath = "uploads/clients/amila-dedovic.jpg",
            IsActive = true, CreatedAt = new DateTime(2026, 2, 20, 18, 0, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 10, FirstName = "Nedim", LastName = "Hadžić", Email = "nedim.hadzic@fitbook.ba",
            PhoneNumber = "+387 61 555 102", PasswordHash = SeedPasswords.User10,
            CityId = 1, IsActive = true, CreatedAt = new DateTime(2026, 4, 6, 9, 30, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 11, FirstName = "Selma", LastName = "Begić", Email = "selma.begic@fitbook.ba",
            PhoneNumber = "+387 62 555 103", PasswordHash = SeedPasswords.User11,
            CityId = 2, IsActive = true, CreatedAt = new DateTime(2026, 5, 14, 13, 10, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 12, FirstName = "Haris", LastName = "Demirović", Email = "haris.demirovic@fitbook.ba",
            PhoneNumber = "+387 63 555 104", PasswordHash = SeedPasswords.User12,
            CityId = 3, IsActive = true, CreatedAt = new DateTime(2026, 6, 1, 7, 45, 0, DateTimeKind.Utc),
        },
        new()
        {
            Id = 13, FirstName = "Džana", LastName = "Mujkić", Email = "dzana.mujkic@fitbook.ba",
            PhoneNumber = "+387 61 555 105", PasswordHash = SeedPasswords.User13,
            CityId = 4, IsActive = false, CreatedAt = new DateTime(2026, 6, 22, 15, 25, 0, DateTimeKind.Utc),
        },
    ];

    public static readonly UserRole[] UserRoles =
    [
        new() { UserId = 1, RoleId = 1, AssignedAt = Registered },
        new() { UserId = 2, RoleId = 2, AssignedAt = new DateTime(2026, 2, 3, 10, 30, 0, DateTimeKind.Utc) },
        new() { UserId = 3, RoleId = 2, AssignedAt = new DateTime(2026, 2, 11, 8, 15, 0, DateTimeKind.Utc) },
        new() { UserId = 4, RoleId = 2, AssignedAt = new DateTime(2026, 3, 2, 12, 0, 0, DateTimeKind.Utc) },
        new() { UserId = 5, RoleId = 2, AssignedAt = new DateTime(2026, 3, 19, 16, 45, 0, DateTimeKind.Utc) },
        new() { UserId = 6, RoleId = 2, AssignedAt = new DateTime(2026, 9, 12, 7, 20, 0, DateTimeKind.Utc) },
        new() { UserId = 7, RoleId = 2, AssignedAt = new DateTime(2026, 9, 13, 11, 5, 0, DateTimeKind.Utc) },
        new() { UserId = 8, RoleId = 2, AssignedAt = new DateTime(2026, 8, 30, 14, 40, 0, DateTimeKind.Utc) },
        new() { UserId = 9, RoleId = 3, AssignedAt = new DateTime(2026, 2, 20, 18, 0, 0, DateTimeKind.Utc) },
        new() { UserId = 10, RoleId = 3, AssignedAt = new DateTime(2026, 4, 6, 9, 30, 0, DateTimeKind.Utc) },
        new() { UserId = 11, RoleId = 3, AssignedAt = new DateTime(2026, 5, 14, 13, 10, 0, DateTimeKind.Utc) },
        new() { UserId = 12, RoleId = 3, AssignedAt = new DateTime(2026, 6, 1, 7, 45, 0, DateTimeKind.Utc) },
        new() { UserId = 13, RoleId = 3, AssignedAt = new DateTime(2026, 6, 22, 15, 25, 0, DateTimeKind.Utc) },
    ];

    public static readonly ClientProfile[] ClientProfiles =
    [
        new() { Id = 1, UserId = 9, Goals = "Build general strength and improve posture after desk work.", Preferences = "Morning sessions, city centre.", DateOfBirth = new DateTime(1997, 4, 12, 0, 0, 0, DateTimeKind.Utc) },
        new() { Id = 2, UserId = 10, Goals = "Lose weight and rebuild cardio base.", Preferences = "Evenings, high intensity.", DateOfBirth = new DateTime(1992, 11, 3, 0, 0, 0, DateTimeKind.Utc) },
        new() { Id = 3, UserId = 11, Goals = "Return to training after a knee injury.", Preferences = "Low impact only.", DateOfBirth = new DateTime(1989, 7, 28, 0, 0, 0, DateTimeKind.Utc) },
        new() { Id = 4, UserId = 12, Goals = "Prepare for a half marathon in spring.", Preferences = "Outdoor running sessions.", DateOfBirth = new DateTime(1995, 1, 19, 0, 0, 0, DateTimeKind.Utc) },
        new() { Id = 5, UserId = 13, Goals = "General fitness, two sessions a week.", Preferences = "Weekends.", DateOfBirth = new DateTime(2000, 9, 5, 0, 0, 0, DateTimeKind.Utc) },
    ];

    public static readonly TrainerProfile[] TrainerProfiles =
    [
        new()
        {
            Id = 1, UserId = 2,
            Bio = "Certified yoga and Pilates instructor with 8 years of studio experience. I build slow, sustainable mobility programmes and pay close attention to breathing and alignment.",
            HourlyRate = 35m, YearsExperience = 8, District = "Centar",
            VerificationStatus = VerificationStatus.Verified,
            SubmittedAt = new DateTime(2026, 2, 3, 10, 30, 0, DateTimeKind.Utc),
            ReviewedAt = new DateTime(2026, 2, 4, 9, 0, 0, DateTimeKind.Utc),
            ReviewedByUserId = 1, IsAcceptingClients = true,
        },
        new()
        {
            Id = 2, UserId = 3,
            Bio = "Certified personal trainer with 6+ years of experience in CrossFit and functional training. I focus on sustainable progress, balanced nutrition and injury prevention.",
            HourlyRate = 45m, YearsExperience = 6, District = "Marijin Dvor",
            VerificationStatus = VerificationStatus.Verified,
            SubmittedAt = new DateTime(2026, 2, 11, 8, 15, 0, DateTimeKind.Utc),
            ReviewedAt = new DateTime(2026, 2, 12, 10, 20, 0, DateTimeKind.Utc),
            ReviewedByUserId = 1, IsAcceptingClients = true,
        },
        new()
        {
            Id = 3, UserId = 4,
            Bio = "Powerlifting background, now coaching general strength. Programmes are built around the big three lifts with a strong emphasis on technique before load.",
            HourlyRate = 40m, YearsExperience = 5, District = "Rondo",
            VerificationStatus = VerificationStatus.Verified,
            SubmittedAt = new DateTime(2026, 3, 2, 12, 0, 0, DateTimeKind.Utc),
            ReviewedAt = new DateTime(2026, 3, 3, 8, 40, 0, DateTimeKind.Utc),
            ReviewedByUserId = 1, IsAcceptingClients = true,
        },
        new()
        {
            Id = 4, UserId = 5,
            Bio = "Former competitive boxer coaching striking and conditioning for all levels. Sessions mix pad work, footwork drills and high-intensity conditioning.",
            HourlyRate = 50m, YearsExperience = 11, District = "Skenderija",
            VerificationStatus = VerificationStatus.Verified,
            SubmittedAt = new DateTime(2026, 3, 19, 16, 45, 0, DateTimeKind.Utc),
            ReviewedAt = new DateTime(2026, 3, 20, 11, 15, 0, DateTimeKind.Utc),
            ReviewedByUserId = 1, IsAcceptingClients = false,
        },

        // Awaiting review — this is what the admin verification queue shows.
        new()
        {
            Id = 5, UserId = 6,
            Bio = "Certified cardio and HIIT instructor with 4 years of group-class experience in Tuzla. Specialising in fat-loss programmes and high-intensity interval training.",
            HourlyRate = 35m, YearsExperience = 4, District = "Slatina",
            VerificationStatus = VerificationStatus.Pending,
            SubmittedAt = new DateTime(2026, 9, 12, 7, 20, 0, DateTimeKind.Utc),
            IsAcceptingClients = false,
        },
        new()
        {
            Id = 6, UserId = 7,
            Bio = "Strength and conditioning coach with 7 years in commercial gyms. Focus on barbell technique and progressive overload for intermediate lifters.",
            HourlyRate = 42m, YearsExperience = 7, District = "Rondo",
            VerificationStatus = VerificationStatus.Pending,
            SubmittedAt = new DateTime(2026, 9, 13, 11, 5, 0, DateTimeKind.Utc),
            IsAcceptingClients = false,
        },

        // Rejected, with the reason the rubric requires a rejection to carry.
        new()
        {
            Id = 7, UserId = 8,
            Bio = "Amateur MMA competitor turned coach. Sessions cover striking, grappling fundamentals and fight-camp conditioning.",
            HourlyRate = 48m, YearsExperience = 5, District = "Skenderija",
            VerificationStatus = VerificationStatus.Rejected,
            SubmittedAt = new DateTime(2026, 8, 30, 14, 40, 0, DateTimeKind.Utc),
            ReviewedAt = new DateTime(2026, 9, 2, 9, 10, 0, DateTimeKind.Utc),
            ReviewedByUserId = 1,
            RejectionReason = "Federation licence expired before the application was submitted. Resubmit with a valid licence and the reference contacts completed.",
            IsAcceptingClients = false,
        },
    ];

    public static readonly TrainerSpeciality[] TrainerSpecialities =
    [
        new() { TrainerProfileId = 1, SpecialityId = 1 },
        new() { TrainerProfileId = 1, SpecialityId = 2 },
        new() { TrainerProfileId = 2, SpecialityId = 3 },
        new() { TrainerProfileId = 2, SpecialityId = 4 },
        new() { TrainerProfileId = 3, SpecialityId = 5 },
        new() { TrainerProfileId = 4, SpecialityId = 6 },
        new() { TrainerProfileId = 4, SpecialityId = 7 },
        new() { TrainerProfileId = 5, SpecialityId = 8 },
        new() { TrainerProfileId = 5, SpecialityId = 4 },
        new() { TrainerProfileId = 6, SpecialityId = 5 },
        new() { TrainerProfileId = 7, SpecialityId = 7 },
        new() { TrainerProfileId = 7, SpecialityId = 6 },
    ];

    /// <summary>Documents attached to the applications an admin still has to judge.</summary>
    public static readonly TrainerDocument[] TrainerDocuments =
    [
        new() { Id = 1, TrainerProfileId = 5, FileName = "ID_card_front.pdf", ContentType = "application/pdf", SizeBytes = 1_258_291, StoragePath = "uploads/documents/5/id-card-front.pdf", UploadedAt = new DateTime(2026, 9, 12, 7, 25, 0, DateTimeKind.Utc) },
        new() { Id = 2, TrainerProfileId = 5, FileName = "Yoga_Alliance_RYT200.pdf", ContentType = "application/pdf", SizeBytes = 2_516_582, StoragePath = "uploads/documents/5/ryt200.pdf", UploadedAt = new DateTime(2026, 9, 12, 7, 26, 0, DateTimeKind.Utc) },
        new() { Id = 3, TrainerProfileId = 5, FileName = "HIIT_certification.jpg", ContentType = "image/jpeg", SizeBytes = 838_860, StoragePath = "uploads/documents/5/hiit-certification.jpg", UploadedAt = new DateTime(2026, 9, 12, 7, 28, 0, DateTimeKind.Utc) },
        new() { Id = 4, TrainerProfileId = 6, FileName = "Licna_karta.pdf", ContentType = "application/pdf", SizeBytes = 943_718, StoragePath = "uploads/documents/6/licna-karta.pdf", UploadedAt = new DateTime(2026, 9, 13, 11, 10, 0, DateTimeKind.Utc) },
        new() { Id = 5, TrainerProfileId = 6, FileName = "NSCA_CSCS.pdf", ContentType = "application/pdf", SizeBytes = 1_677_721, StoragePath = "uploads/documents/6/nsca-cscs.pdf", UploadedAt = new DateTime(2026, 9, 13, 11, 12, 0, DateTimeKind.Utc) },
        new() { Id = 6, TrainerProfileId = 7, FileName = "MMA_licence_2026.pdf", ContentType = "application/pdf", SizeBytes = 629_145, StoragePath = "uploads/documents/7/mma-licence-2026.pdf", UploadedAt = new DateTime(2026, 8, 30, 14, 50, 0, DateTimeKind.Utc) },
    ];
}
