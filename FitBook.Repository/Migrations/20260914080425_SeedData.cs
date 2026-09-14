using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace FitBook.Repository.Migrations
{
    /// <inheritdoc />
    public partial class SeedData : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "AuditLogs",
                columns: new[] { "Id", "Action", "ActorUserId", "CreatedAt", "Description", "EntityId", "EntityName" },
                values: new object[,]
                {
                    { 12, "Captured", null, new DateTime(2026, 8, 17, 19, 33, 0, 0, DateTimeKind.Utc), "Stripe confirmed the payment intent server-side.", 1, "Payment" },
                    { 13, "Refunded", null, new DateTime(2026, 9, 10, 9, 30, 0, 0, DateTimeKind.Utc), "Full refund of the amount actually charged after cancellation.", 5, "Payment" }
                });

            migrationBuilder.InsertData(
                table: "Categories",
                columns: new[] { "Id", "Description", "Name" },
                values: new object[,]
                {
                    { 1, "Barbell work, progressive overload and general strength.", "Strength & Conditioning" },
                    { 2, "Heart-rate based training, intervals and stamina.", "Cardio & Endurance" },
                    { 3, "Breathing, alignment and long-term mobility.", "Yoga & Mobility" },
                    { 4, "Striking, grappling and fight conditioning.", "Combat Sports" },
                    { 5, "Return-to-training work after injury.", "Rehabilitation" },
                    { 6, "Meal planning alongside a training programme.", "Nutrition Coaching" }
                });

            migrationBuilder.InsertData(
                table: "Countries",
                columns: new[] { "Id", "IsoCode", "Name" },
                values: new object[,]
                {
                    { 1, "BA", "Bosna i Hercegovina" },
                    { 2, "HR", "Hrvatska" },
                    { 3, "RS", "Srbija" }
                });

            migrationBuilder.InsertData(
                table: "MembershipPlans",
                columns: new[] { "Id", "Description", "IsActive", "MonthlyPrice", "Name", "SessionsIncluded" },
                values: new object[,]
                {
                    { 1, "Four coached sessions a month, booked at standard rates.", true, 49m, "Basic", 4 },
                    { 2, "Ten coached sessions a month with priority booking.", true, 99m, "Premium", 10 },
                    { 3, "Twenty sessions a month, nutrition coaching included.", true, 169m, "Elite", 20 }
                });

            migrationBuilder.InsertData(
                table: "Roles",
                columns: new[] { "Id", "Description", "Name" },
                values: new object[,]
                {
                    { 1, "Verifies trainers, manages reference data and reads reports.", "Admin" },
                    { 2, "Offers services, manages availability, confirms or rejects bookings.", "Trainer" },
                    { 3, "Books sessions, pays, and reviews completed sessions.", "Client" }
                });

            migrationBuilder.InsertData(
                table: "Specialities",
                columns: new[] { "Id", "Name" },
                values: new object[,]
                {
                    { 1, "Yoga" },
                    { 2, "Pilates" },
                    { 3, "CrossFit" },
                    { 4, "HIIT" },
                    { 5, "Strength" },
                    { 6, "Boxing" },
                    { 7, "MMA" },
                    { 8, "Cardio" },
                    { 9, "Running" },
                    { 10, "Nutrition" }
                });

            migrationBuilder.InsertData(
                table: "Cities",
                columns: new[] { "Id", "CountryId", "Name", "PostalCode" },
                values: new object[,]
                {
                    { 1, 1, "Sarajevo", "71000" },
                    { 2, 1, "Mostar", "88000" },
                    { 3, 1, "Tuzla", "75000" },
                    { 4, 1, "Zenica", "72000" },
                    { 5, 1, "Banja Luka", "78000" },
                    { 6, 1, "Bihać", "77000" }
                });

            migrationBuilder.InsertData(
                table: "Locations",
                columns: new[] { "Id", "Address", "CityId", "District", "Name" },
                values: new object[,]
                {
                    { 1, "Maršala Tita 28", 1, "Centar", "FitZone Centar" },
                    { 2, "Zmaja od Bosne 4", 1, "Marijin Dvor", "Olimp Gym" },
                    { 3, "Kralja Petra Krešimira IV 12", 2, "Rondo", "Studio Balans" },
                    { 4, "Slatina 9", 3, "Slatina", "Arena Fit" },
                    { 5, "Školska 3", 4, "Centar", "Core Studio" }
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "CityId", "CreatedAt", "Email", "FirstName", "IsActive", "LastName", "PasswordHash", "PhoneNumber", "ProfileImagePath" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2026, 1, 15, 9, 0, 0, 0, DateTimeKind.Utc), "admin@fitbook.ba", "Emir", true, "Selimović", "pbkdf2-sha256$100000$ny0xfaTUAvBf3rgIQ3J6qw==$0H3M0VGzhz3itClxkwl92U1o2eKzGzFEsmigUoUMZxg=", "+387 61 000 001", null },
                    { 2, 1, new DateTime(2026, 2, 3, 10, 30, 0, 0, DateTimeKind.Utc), "ana.kovac@fitbook.ba", "Ana", true, "Kovač", "pbkdf2-sha256$100000$K+KrapVdl/zLF0EUWzK89w==$w6EZ9bkVRphDmrvtvitcKUJv+jCYOOYJFxxo2Q2dl6Q=", "+387 61 234 111", "uploads/trainers/ana-kovac.jpg" },
                    { 3, 1, new DateTime(2026, 2, 11, 8, 15, 0, 0, DateTimeKind.Utc), "marko.petric@fitbook.ba", "Marko", true, "Petrić", "pbkdf2-sha256$100000$j31JfiSWz7GcMLIKZfVvhA==$r+QX9ESyosHuu7eMMRg7YXOFE38WvZluDLyDwUA4p0g=", "+387 61 234 222", "uploads/trainers/marko-petric.jpg" },
                    { 4, 2, new DateTime(2026, 3, 2, 12, 0, 0, 0, DateTimeKind.Utc), "iva.milic@fitbook.ba", "Iva", true, "Milić", "pbkdf2-sha256$100000$ltpovbtv5ncfhFxYwzjnXA==$iIJqdbOHv0qV7IXGtfyGpu75QRdu2Af77jky2Ler3tU=", "+387 63 234 333", "uploads/trainers/iva-milic.jpg" },
                    { 5, 1, new DateTime(2026, 3, 19, 16, 45, 0, 0, DateTimeKind.Utc), "damir.juric@fitbook.ba", "Damir", true, "Jurić", "pbkdf2-sha256$100000$HiikeDJXcIPlHgPoTL0kVg==$fGcOolGP14gZ84jo3DULhOU9HBNqLxUYTuZcjMm4KSo=", "+387 62 234 444", "uploads/trainers/damir-juric.jpg" },
                    { 6, 3, new DateTime(2026, 9, 12, 7, 20, 0, 0, DateTimeKind.Utc), "lejla.hodzic@fitbook.ba", "Lejla", true, "Hodžić", "pbkdf2-sha256$100000$Kv7gBFrn/IpggAbKSfp1ow==$rJtHBcul8tzCNxbuRG5sqvWwISMtPt7qbfqbLmc5CIM=", "+387 61 234 567", null },
                    { 7, 2, new DateTime(2026, 9, 13, 11, 5, 0, 0, DateTimeKind.Utc), "goran.lukic@fitbook.ba", "Goran", true, "Lukić", "pbkdf2-sha256$100000$78HrMlrBH7CGzci8cJBYcA==$4nrVMBFToM+SVjCgPGPcEXW6VdywMMJ+mYSjioymR5w=", "+387 63 771 402", null },
                    { 8, 1, new DateTime(2026, 8, 30, 14, 40, 0, 0, DateTimeKind.Utc), "mirza.aldic@fitbook.ba", "Mirza", true, "Aldić", "pbkdf2-sha256$100000$bxn8OXUSeEIB2A0l3flRQQ==$Kph755Nz9mB6s4uJSQ97R5Ok17S9yI3hMUjGNgjEYpo=", "+387 62 118 903", null },
                    { 9, 1, new DateTime(2026, 2, 20, 18, 0, 0, 0, DateTimeKind.Utc), "amila.dedovic@fitbook.ba", "Amila", true, "Đedović", "pbkdf2-sha256$100000$LFycI6v7kw3iLqgl8mfMdg==$uMaTfBdxSBoKiyokC3jvsFtBTHy0slx33Gqo9O+P104=", "+387 61 555 101", "uploads/clients/amila-dedovic.jpg" },
                    { 10, 1, new DateTime(2026, 4, 6, 9, 30, 0, 0, DateTimeKind.Utc), "nedim.hadzic@fitbook.ba", "Nedim", true, "Hadžić", "pbkdf2-sha256$100000$2/WzLWb8+W3FZ/y6+TfCbQ==$ZQCzKYlk1+3bgcszclfak0ftfgcKyiVQZo9odr4aMlg=", "+387 61 555 102", null },
                    { 11, 2, new DateTime(2026, 5, 14, 13, 10, 0, 0, DateTimeKind.Utc), "selma.begic@fitbook.ba", "Selma", true, "Begić", "pbkdf2-sha256$100000$QHFOQ4Sur6M+rqhvdiHktg==$TA6FLCiALbHPMnfFpZX153511kk2K9NmWm2xWgnXZa0=", "+387 62 555 103", null },
                    { 12, 3, new DateTime(2026, 6, 1, 7, 45, 0, 0, DateTimeKind.Utc), "haris.demirovic@fitbook.ba", "Haris", true, "Demirović", "pbkdf2-sha256$100000$wTDcbwM7l5vyBDutBd6u1Q==$Kncnawf/bASKip4QuslogUH/N2R4OU1nZ6UTZxvyJV8=", "+387 63 555 104", null },
                    { 13, 4, new DateTime(2026, 6, 22, 15, 25, 0, 0, DateTimeKind.Utc), "dzana.mujkic@fitbook.ba", "Džana", false, "Mujkić", "pbkdf2-sha256$100000$a15dqQh2iMbItUjbgz5pnA==$4d4kKeFheecZ87eizeFVTBJY+qM4Oqub2w7TZfs7ea8=", "+387 61 555 105", null }
                });

            migrationBuilder.InsertData(
                table: "AuditLogs",
                columns: new[] { "Id", "Action", "ActorUserId", "CreatedAt", "Description", "EntityId", "EntityName" },
                values: new object[,]
                {
                    { 1, "Verified", 1, new DateTime(2026, 2, 4, 9, 0, 0, 0, DateTimeKind.Utc), "Identity, certification and references checked.", 1, "TrainerProfile" },
                    { 2, "Verified", 1, new DateTime(2026, 2, 12, 10, 20, 0, 0, DateTimeKind.Utc), "Identity and CrossFit L2 certificate verified against the registry.", 2, "TrainerProfile" },
                    { 3, "Verified", 1, new DateTime(2026, 3, 3, 8, 40, 0, 0, DateTimeKind.Utc), "Identity and coaching licence verified.", 3, "TrainerProfile" },
                    { 4, "Verified", 1, new DateTime(2026, 3, 20, 11, 15, 0, 0, DateTimeKind.Utc), "Identity and federation licence verified.", 4, "TrainerProfile" },
                    { 5, "Rejected", 1, new DateTime(2026, 9, 2, 9, 10, 0, 0, DateTimeKind.Utc), "Federation licence expired before the application was submitted.", 7, "TrainerProfile" },
                    { 6, "Created", 9, new DateTime(2026, 8, 17, 19, 30, 0, 0, DateTimeKind.Utc), "Client requested the session.", 1, "Booking" },
                    { 7, "Confirmed", 2, new DateTime(2026, 8, 17, 20, 10, 0, 0, DateTimeKind.Utc), "Trainer accepted the request.", 1, "Booking" },
                    { 8, "Completed", 2, new DateTime(2026, 8, 20, 8, 5, 0, 0, DateTimeKind.Utc), "Session took place.", 1, "Booking" },
                    { 9, "Cancelled", 11, new DateTime(2026, 9, 10, 9, 25, 0, 0, DateTimeKind.Utc), "Client withdrew: travelling for work that week.", 9, "Booking" },
                    { 10, "Rejected", 3, new DateTime(2026, 9, 9, 19, 0, 0, 0, DateTimeKind.Utc), "Trainer unavailable: the slot was already committed to another client.", 10, "Booking" },
                    { 11, "Confirmed", 2, new DateTime(2026, 9, 12, 18, 40, 0, 0, DateTimeKind.Utc), "Trainer accepted the request.", 4, "Booking" }
                });

            migrationBuilder.InsertData(
                table: "ClientProfiles",
                columns: new[] { "Id", "DateOfBirth", "Goals", "Preferences", "UserId" },
                values: new object[,]
                {
                    { 1, new DateTime(1997, 4, 12, 0, 0, 0, 0, DateTimeKind.Utc), "Build general strength and improve posture after desk work.", "Morning sessions, city centre.", 9 },
                    { 2, new DateTime(1992, 11, 3, 0, 0, 0, 0, DateTimeKind.Utc), "Lose weight and rebuild cardio base.", "Evenings, high intensity.", 10 },
                    { 3, new DateTime(1989, 7, 28, 0, 0, 0, 0, DateTimeKind.Utc), "Return to training after a knee injury.", "Low impact only.", 11 },
                    { 4, new DateTime(1995, 1, 19, 0, 0, 0, 0, DateTimeKind.Utc), "Prepare for a half marathon in spring.", "Outdoor running sessions.", 12 },
                    { 5, new DateTime(2000, 9, 5, 0, 0, 0, 0, DateTimeKind.Utc), "General fitness, two sessions a week.", "Weekends.", 13 }
                });

            migrationBuilder.InsertData(
                table: "News",
                columns: new[] { "Id", "AuthorUserId", "Body", "ImagePath", "IsPublished", "PublishedAt", "Title" },
                values: new object[,]
                {
                    { 1, 1, "Od ovog mjeseca možete rezervisati termine kod verifikovanih trenera u Tuzli i Zenici. Nove lokacije dodajemo svakog mjeseca.", "uploads/news/new-cities.jpg", true, new DateTime(2026, 9, 1, 9, 0, 0, 0, DateTimeKind.Utc), "FitBook je sada dostupan u Tuzli i Zenici" },
                    { 2, 1, "Svaki trener prolazi provjeru identiteta, certifikata i referenci prije nego što može primati rezervacije. Objašnjavamo cijeli proces korak po korak.", "uploads/news/verification.jpg", true, new DateTime(2026, 8, 18, 10, 30, 0, 0, DateTimeKind.Utc), "Kako biramo i verifikujemo trenere" },
                    { 3, 1, "Pripremamo godišnje pakete sa popustom. Detalji uskoro.", null, false, new DateTime(2026, 9, 14, 8, 0, 0, 0, DateTimeKind.Utc), "Nove članarine stižu u oktobru" }
                });

            migrationBuilder.InsertData(
                table: "Notifications",
                columns: new[] { "Id", "Body", "CreatedAt", "IsRead", "ReadAt", "Title", "Tone", "UserId" },
                values: new object[,]
                {
                    { 1, "Ana Kovač confirmed your session on 15 September at 07:00.", new DateTime(2026, 9, 12, 18, 40, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 12, 19, 2, 0, 0, DateTimeKind.Utc), "Booking confirmed", 2, 9 },
                    { 2, "Your membership payment of 99,00 KM was processed successfully.", new DateTime(2026, 9, 1, 8, 7, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 1, 9, 0, 0, 0, DateTimeKind.Utc), "Payment received", 2, 9 },
                    { 3, "Your Premium membership renews on 1 October.", new DateTime(2026, 9, 13, 6, 0, 0, 0, DateTimeKind.Utc), false, null, "Eight sessions left", 1, 9 },
                    { 4, "Marko Petrić confirmed your session on 15 September at 16:00.", new DateTime(2026, 9, 12, 7, 5, 0, 0, DateTimeKind.Utc), false, null, "Booking confirmed", 2, 10 },
                    { 5, "Your session on 15 September was cancelled and 32,00 KM has been refunded.", new DateTime(2026, 9, 10, 9, 30, 0, 0, DateTimeKind.Utc), false, null, "Booking cancelled", 3, 11 },
                    { 6, "Marko Petrić could not take your session on 15 September. The slot was already committed to another client.", new DateTime(2026, 9, 9, 19, 0, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 9, 20, 15, 0, 0, DateTimeKind.Utc), "Booking declined", 4, 13 },
                    { 7, "Džana Mujkić requested HIIT conditioning on 17 September at 16:00.", new DateTime(2026, 9, 14, 6, 45, 0, 0, DateTimeKind.Utc), false, null, "New booking request", 1, 3 },
                    { 8, "Haris Demirović requested Boxing pads and footwork on 18 September at 18:00.", new DateTime(2026, 9, 14, 7, 10, 0, 0, DateTimeKind.Utc), false, null, "New booking request", 1, 5 },
                    { 9, "Your trainer application is pending review. We will let you know as soon as an administrator has looked at it.", new DateTime(2026, 9, 12, 7, 30, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 12, 8, 0, 0, 0, DateTimeKind.Utc), "Application received", 1, 6 },
                    { 10, "Your application was not approved: the federation licence expired before submission. You can resubmit with a valid licence.", new DateTime(2026, 9, 2, 9, 10, 0, 0, DateTimeKind.Utc), false, null, "Application rejected", 4, 8 },
                    { 11, "Amila Đedović left you a five star review.", new DateTime(2026, 8, 20, 12, 1, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 8, 20, 18, 0, 0, 0, DateTimeKind.Utc), "New review", 2, 2 },
                    { 12, "Lejla Hodžić and Goran Lukić are awaiting verification.", new DateTime(2026, 9, 13, 11, 10, 0, 0, DateTimeKind.Utc), false, null, "Two applications waiting", 3, 1 }
                });

            migrationBuilder.InsertData(
                table: "SearchHistory",
                columns: new[] { "Id", "CategoryId", "CityId", "CreatedAt", "Query", "SpecialityId", "UserId", "ViewedTrainerProfileId" },
                values: new object[,]
                {
                    { 1, 3, 1, new DateTime(2026, 9, 10, 18, 12, 0, 0, DateTimeKind.Utc), "yoga sarajevo", 1, 9, null },
                    { 3, 3, 1, new DateTime(2026, 9, 11, 7, 40, 0, 0, DateTimeKind.Utc), null, 2, 9, null },
                    { 5, 1, 1, new DateTime(2026, 9, 9, 20, 0, 0, 0, DateTimeKind.Utc), "crossfit", 3, 10, null },
                    { 7, null, 1, new DateTime(2026, 9, 11, 19, 20, 0, 0, DateTimeKind.Utc), "hiit večernji termini", 4, 10, null },
                    { 8, 5, 2, new DateTime(2026, 8, 23, 13, 0, 0, 0, DateTimeKind.Utc), "rehabilitacija koljeno", null, 11, null },
                    { 10, 2, 3, new DateTime(2026, 9, 13, 8, 0, 0, 0, DateTimeKind.Utc), "trčanje priprema polumaraton", 9, 12, null },
                    { 13, 4, 1, new DateTime(2026, 9, 8, 21, 0, 0, 0, DateTimeKind.Utc), "boks početnici", 6, 13, null }
                });

            migrationBuilder.InsertData(
                table: "TrainerProfiles",
                columns: new[] { "Id", "Bio", "District", "HourlyRate", "IsAcceptingClients", "RejectionReason", "ReviewedAt", "ReviewedByUserId", "SubmittedAt", "UserId", "VerificationStatus", "YearsExperience" },
                values: new object[,]
                {
                    { 1, "Certified yoga and Pilates instructor with 8 years of studio experience. I build slow, sustainable mobility programmes and pay close attention to breathing and alignment.", "Centar", 35m, true, null, new DateTime(2026, 2, 4, 9, 0, 0, 0, DateTimeKind.Utc), 1, new DateTime(2026, 2, 3, 10, 30, 0, 0, DateTimeKind.Utc), 2, 2, 8 },
                    { 2, "Certified personal trainer with 6+ years of experience in CrossFit and functional training. I focus on sustainable progress, balanced nutrition and injury prevention.", "Marijin Dvor", 45m, true, null, new DateTime(2026, 2, 12, 10, 20, 0, 0, DateTimeKind.Utc), 1, new DateTime(2026, 2, 11, 8, 15, 0, 0, DateTimeKind.Utc), 3, 2, 6 },
                    { 3, "Powerlifting background, now coaching general strength. Programmes are built around the big three lifts with a strong emphasis on technique before load.", "Rondo", 40m, true, null, new DateTime(2026, 3, 3, 8, 40, 0, 0, DateTimeKind.Utc), 1, new DateTime(2026, 3, 2, 12, 0, 0, 0, DateTimeKind.Utc), 4, 2, 5 },
                    { 4, "Former competitive boxer coaching striking and conditioning for all levels. Sessions mix pad work, footwork drills and high-intensity conditioning.", "Skenderija", 50m, false, null, new DateTime(2026, 3, 20, 11, 15, 0, 0, DateTimeKind.Utc), 1, new DateTime(2026, 3, 19, 16, 45, 0, 0, DateTimeKind.Utc), 5, 2, 11 },
                    { 5, "Certified cardio and HIIT instructor with 4 years of group-class experience in Tuzla. Specialising in fat-loss programmes and high-intensity interval training.", "Slatina", 35m, false, null, null, null, new DateTime(2026, 9, 12, 7, 20, 0, 0, DateTimeKind.Utc), 6, 1, 4 },
                    { 6, "Strength and conditioning coach with 7 years in commercial gyms. Focus on barbell technique and progressive overload for intermediate lifters.", "Rondo", 42m, false, null, null, null, new DateTime(2026, 9, 13, 11, 5, 0, 0, DateTimeKind.Utc), 7, 1, 7 },
                    { 7, "Amateur MMA competitor turned coach. Sessions cover striking, grappling fundamentals and fight-camp conditioning.", "Skenderija", 48m, false, "Federation licence expired before the application was submitted. Resubmit with a valid licence and the reference contacts completed.", new DateTime(2026, 9, 2, 9, 10, 0, 0, DateTimeKind.Utc), 1, new DateTime(2026, 8, 30, 14, 40, 0, 0, DateTimeKind.Utc), 8, 3, 5 }
                });

            migrationBuilder.InsertData(
                table: "UserRoles",
                columns: new[] { "RoleId", "UserId", "AssignedAt" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2026, 1, 15, 9, 0, 0, 0, DateTimeKind.Utc) },
                    { 2, 2, new DateTime(2026, 2, 3, 10, 30, 0, 0, DateTimeKind.Utc) },
                    { 2, 3, new DateTime(2026, 2, 11, 8, 15, 0, 0, DateTimeKind.Utc) },
                    { 2, 4, new DateTime(2026, 3, 2, 12, 0, 0, 0, DateTimeKind.Utc) },
                    { 2, 5, new DateTime(2026, 3, 19, 16, 45, 0, 0, DateTimeKind.Utc) },
                    { 2, 6, new DateTime(2026, 9, 12, 7, 20, 0, 0, DateTimeKind.Utc) },
                    { 2, 7, new DateTime(2026, 9, 13, 11, 5, 0, 0, DateTimeKind.Utc) },
                    { 2, 8, new DateTime(2026, 8, 30, 14, 40, 0, 0, DateTimeKind.Utc) },
                    { 3, 9, new DateTime(2026, 2, 20, 18, 0, 0, 0, DateTimeKind.Utc) },
                    { 3, 10, new DateTime(2026, 4, 6, 9, 30, 0, 0, DateTimeKind.Utc) },
                    { 3, 11, new DateTime(2026, 5, 14, 13, 10, 0, 0, DateTimeKind.Utc) },
                    { 3, 12, new DateTime(2026, 6, 1, 7, 45, 0, 0, DateTimeKind.Utc) },
                    { 3, 13, new DateTime(2026, 6, 22, 15, 25, 0, 0, DateTimeKind.Utc) }
                });

            migrationBuilder.InsertData(
                table: "Availabilities",
                columns: new[] { "Id", "EndsAtUtc", "IsBooked", "StartsAtUtc", "TrainerProfileId" },
                values: new object[,]
                {
                    { 1, new DateTime(2026, 9, 15, 8, 0, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 15, 7, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 2, new DateTime(2026, 9, 15, 9, 0, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 15, 8, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 3, new DateTime(2026, 9, 16, 8, 0, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 16, 7, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 4, new DateTime(2026, 9, 17, 18, 0, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 17, 17, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 5, new DateTime(2026, 9, 15, 17, 0, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 15, 16, 0, 0, 0, DateTimeKind.Utc), 2 },
                    { 6, new DateTime(2026, 9, 16, 17, 0, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 16, 16, 0, 0, 0, DateTimeKind.Utc), 2 },
                    { 7, new DateTime(2026, 9, 17, 17, 0, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 17, 16, 0, 0, 0, DateTimeKind.Utc), 2 },
                    { 8, new DateTime(2026, 9, 18, 9, 30, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 18, 9, 0, 0, 0, DateTimeKind.Utc), 2 },
                    { 9, new DateTime(2026, 9, 16, 11, 15, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 9, 16, 10, 0, 0, 0, DateTimeKind.Utc), 3 },
                    { 10, new DateTime(2026, 9, 17, 11, 15, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 17, 10, 0, 0, 0, DateTimeKind.Utc), 3 },
                    { 11, new DateTime(2026, 9, 19, 11, 0, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 19, 10, 0, 0, 0, DateTimeKind.Utc), 3 },
                    { 12, new DateTime(2026, 9, 18, 19, 0, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 18, 18, 0, 0, 0, DateTimeKind.Utc), 4 },
                    { 13, new DateTime(2026, 9, 19, 19, 30, 0, 0, DateTimeKind.Utc), false, new DateTime(2026, 9, 19, 18, 0, 0, 0, DateTimeKind.Utc), 4 },
                    { 14, new DateTime(2026, 8, 20, 8, 0, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 8, 20, 7, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 15, new DateTime(2026, 8, 25, 17, 0, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 8, 25, 16, 0, 0, 0, DateTimeKind.Utc), 2 },
                    { 16, new DateTime(2026, 8, 28, 11, 15, 0, 0, DateTimeKind.Utc), true, new DateTime(2026, 8, 28, 10, 0, 0, 0, DateTimeKind.Utc), 3 }
                });

            migrationBuilder.InsertData(
                table: "Memberships",
                columns: new[] { "Id", "ClientProfileId", "CreatedAt", "EndsAtUtc", "MembershipPlanId", "SessionsRemaining", "StartsAtUtc", "Status" },
                values: new object[,]
                {
                    { 1, 1, new DateTime(2026, 9, 1, 8, 5, 0, 0, DateTimeKind.Utc), new DateTime(2026, 10, 1, 0, 0, 0, 0, DateTimeKind.Utc), 2, 8, new DateTime(2026, 9, 1, 0, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 2, 2, new DateTime(2026, 9, 5, 19, 40, 0, 0, DateTimeKind.Utc), new DateTime(2026, 10, 5, 0, 0, 0, 0, DateTimeKind.Utc), 1, 3, new DateTime(2026, 9, 5, 0, 0, 0, 0, DateTimeKind.Utc), 1 },
                    { 3, 3, new DateTime(2026, 7, 1, 12, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 1, 0, 0, 0, 0, DateTimeKind.Utc), 1, 0, new DateTime(2026, 7, 1, 0, 0, 0, 0, DateTimeKind.Utc), 2 }
                });

            migrationBuilder.InsertData(
                table: "SearchHistory",
                columns: new[] { "Id", "CategoryId", "CityId", "CreatedAt", "Query", "SpecialityId", "UserId", "ViewedTrainerProfileId" },
                values: new object[,]
                {
                    { 2, null, 1, new DateTime(2026, 9, 10, 18, 14, 0, 0, DateTimeKind.Utc), null, 1, 9, 1 },
                    { 4, null, null, new DateTime(2026, 9, 12, 17, 55, 0, 0, DateTimeKind.Utc), null, null, 9, 1 },
                    { 6, null, 1, new DateTime(2026, 9, 9, 20, 5, 0, 0, DateTimeKind.Utc), null, 4, 10, 2 },
                    { 9, null, 2, new DateTime(2026, 8, 23, 13, 6, 0, 0, DateTimeKind.Utc), null, 5, 11, 3 },
                    { 11, null, 2, new DateTime(2026, 9, 13, 8, 20, 0, 0, DateTimeKind.Utc), null, 5, 12, 3 },
                    { 12, null, 1, new DateTime(2026, 9, 14, 7, 5, 0, 0, DateTimeKind.Utc), null, null, 12, 4 },
                    { 14, null, 1, new DateTime(2026, 9, 14, 6, 40, 0, 0, DateTimeKind.Utc), null, 4, 13, 2 }
                });

            migrationBuilder.InsertData(
                table: "Services",
                columns: new[] { "Id", "CategoryId", "CreatedAt", "Description", "DurationMinutes", "ImagePath", "IsActive", "Price", "Title", "TrainerProfileId" },
                values: new object[,]
                {
                    { 1, 3, new DateTime(2026, 2, 5, 9, 0, 0, 0, DateTimeKind.Utc), "Breath-led flow built around your current mobility, with adjustments throughout.", 60, "uploads/services/vinyasa.jpg", true, 35m, "Vinyasa yoga, one to one", 1 },
                    { 2, 3, new DateTime(2026, 2, 5, 9, 15, 0, 0, DateTimeKind.Utc), "Core control and alignment for beginners returning to movement.", 45, "uploads/services/pilates.jpg", true, 32m, "Pilates mat fundamentals", 1 },
                    { 3, 1, new DateTime(2026, 2, 13, 8, 0, 0, 0, DateTimeKind.Utc), "Compound lifts and accessory work programmed around your week.", 60, "uploads/services/functional.jpg", true, 45m, "Functional strength session", 2 },
                    { 4, 2, new DateTime(2026, 2, 13, 8, 20, 0, 0, DateTimeKind.Utc), "Thirty minutes of interval work, scaled to your current conditioning.", 30, "uploads/services/hiit.jpg", true, 30m, "HIIT conditioning", 2 },
                    { 5, 1, new DateTime(2026, 3, 4, 10, 0, 0, 0, DateTimeKind.Utc), "Squat, bench and deadlift technique, filmed and reviewed with you.", 75, "uploads/services/barbell.jpg", true, 40m, "Barbell technique clinic", 3 },
                    { 6, 5, new DateTime(2026, 3, 4, 10, 25, 0, 0, DateTimeKind.Utc), "Graded reloading programme written with your physiotherapist's notes.", 60, "uploads/services/rehab.jpg", true, 44m, "Return to lifting after injury", 3 },
                    { 7, 4, new DateTime(2026, 3, 21, 17, 0, 0, 0, DateTimeKind.Utc), "Technical striking work with pad rounds and movement drills.", 60, "uploads/services/boxing.jpg", true, 50m, "Boxing pads and footwork", 4 },
                    { 8, 4, new DateTime(2026, 3, 21, 17, 30, 0, 0, DateTimeKind.Utc), "Rounds-based conditioning for competitors in camp.", 90, "uploads/services/fightcamp.jpg", true, 55m, "Fight-camp conditioning", 4 },
                    { 9, 6, new DateTime(2026, 4, 2, 11, 0, 0, 0, DateTimeKind.Utc), "A single consultation reviewing your intake against your training load.", 45, null, true, 28m, "Nutrition review", 1 },
                    { 10, 1, new DateTime(2026, 4, 18, 9, 30, 0, 0, DateTimeKind.Utc), "Programme audit and next-block planning, no session included.", 30, null, false, 25m, "Strength block review", 2 }
                });

            migrationBuilder.InsertData(
                table: "TrainerDocuments",
                columns: new[] { "Id", "ContentType", "FileName", "SizeBytes", "StoragePath", "TrainerProfileId", "UploadedAt" },
                values: new object[,]
                {
                    { 1, "application/pdf", "ID_card_front.pdf", 1258291L, "uploads/documents/5/id-card-front.pdf", 5, new DateTime(2026, 9, 12, 7, 25, 0, 0, DateTimeKind.Utc) },
                    { 2, "application/pdf", "Yoga_Alliance_RYT200.pdf", 2516582L, "uploads/documents/5/ryt200.pdf", 5, new DateTime(2026, 9, 12, 7, 26, 0, 0, DateTimeKind.Utc) },
                    { 3, "image/jpeg", "HIIT_certification.jpg", 838860L, "uploads/documents/5/hiit-certification.jpg", 5, new DateTime(2026, 9, 12, 7, 28, 0, 0, DateTimeKind.Utc) },
                    { 4, "application/pdf", "Licna_karta.pdf", 943718L, "uploads/documents/6/licna-karta.pdf", 6, new DateTime(2026, 9, 13, 11, 10, 0, 0, DateTimeKind.Utc) },
                    { 5, "application/pdf", "NSCA_CSCS.pdf", 1677721L, "uploads/documents/6/nsca-cscs.pdf", 6, new DateTime(2026, 9, 13, 11, 12, 0, 0, DateTimeKind.Utc) },
                    { 6, "application/pdf", "MMA_licence_2026.pdf", 629145L, "uploads/documents/7/mma-licence-2026.pdf", 7, new DateTime(2026, 8, 30, 14, 50, 0, 0, DateTimeKind.Utc) }
                });

            migrationBuilder.InsertData(
                table: "TrainerSpecialities",
                columns: new[] { "SpecialityId", "TrainerProfileId" },
                values: new object[,]
                {
                    { 1, 1 },
                    { 2, 1 },
                    { 3, 2 },
                    { 4, 2 },
                    { 5, 3 },
                    { 6, 4 },
                    { 7, 4 },
                    { 4, 5 },
                    { 8, 5 },
                    { 5, 6 },
                    { 6, 7 },
                    { 7, 7 }
                });

            migrationBuilder.InsertData(
                table: "Bookings",
                columns: new[] { "Id", "Amount", "CancellationReason", "CancelledAt", "ClientNotes", "ClientProfileId", "CompletedAt", "ConfirmedAt", "CreatedAt", "EndsAtUtc", "LocationId", "MembershipId", "Reference", "ServiceId", "StartsAtUtc", "Status", "TrainerProfileId" },
                values: new object[,]
                {
                    { 1, 35m, null, null, "Lower back has been stiff all week.", 1, new DateTime(2026, 8, 20, 8, 5, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 17, 20, 10, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 17, 19, 30, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 20, 8, 0, 0, 0, DateTimeKind.Utc), 1, null, "FB-2801", 1, new DateTime(2026, 8, 20, 7, 0, 0, 0, DateTimeKind.Utc), 3, 1 },
                    { 2, 45m, null, null, null, 2, new DateTime(2026, 8, 25, 17, 10, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 22, 12, 45, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 22, 9, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 25, 17, 0, 0, 0, DateTimeKind.Utc), 2, null, "FB-2812", 3, new DateTime(2026, 8, 25, 16, 0, 0, 0, DateTimeKind.Utc), 3, 2 },
                    { 3, 44m, null, null, "Cleared by physio two weeks ago.", 3, new DateTime(2026, 8, 28, 11, 20, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 24, 15, 30, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 24, 14, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 8, 28, 11, 15, 0, 0, DateTimeKind.Utc), 3, null, "FB-2818", 6, new DateTime(2026, 8, 28, 10, 0, 0, 0, DateTimeKind.Utc), 3, 3 },
                    { 4, 35m, null, null, null, 1, null, new DateTime(2026, 9, 12, 18, 40, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 12, 18, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 15, 8, 0, 0, 0, DateTimeKind.Utc), 1, 1, "FB-2841", 1, new DateTime(2026, 9, 15, 7, 0, 0, 0, DateTimeKind.Utc), 2, 1 },
                    { 5, 45m, null, null, null, 2, null, new DateTime(2026, 9, 12, 7, 5, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 11, 20, 15, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 15, 17, 0, 0, 0, DateTimeKind.Utc), 2, 2, "FB-2847", 3, new DateTime(2026, 9, 15, 16, 0, 0, 0, DateTimeKind.Utc), 2, 2 },
                    { 6, 40m, null, null, "Filming the squat set if that is alright.", 4, null, new DateTime(2026, 9, 13, 9, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 13, 8, 30, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 16, 11, 15, 0, 0, DateTimeKind.Utc), 3, null, "FB-2852", 5, new DateTime(2026, 9, 16, 10, 0, 0, 0, DateTimeKind.Utc), 2, 3 },
                    { 7, 30m, null, null, "First HIIT session, please start easy.", 5, null, null, new DateTime(2026, 9, 14, 6, 45, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 17, 16, 30, 0, 0, DateTimeKind.Utc), 2, null, "FB-2860", 4, new DateTime(2026, 9, 17, 16, 0, 0, 0, DateTimeKind.Utc), 1, 2 },
                    { 8, 50m, null, null, null, 4, null, null, new DateTime(2026, 9, 14, 7, 10, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 18, 19, 0, 0, 0, DateTimeKind.Utc), 1, null, "FB-2861", 7, new DateTime(2026, 9, 18, 18, 0, 0, 0, DateTimeKind.Utc), 1, 4 },
                    { 9, 32m, "Client withdrew: travelling for work that week.", new DateTime(2026, 9, 10, 9, 25, 0, 0, DateTimeKind.Utc), null, 3, null, new DateTime(2026, 9, 8, 12, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 8, 11, 0, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 15, 7, 45, 0, 0, DateTimeKind.Utc), 1, null, "FB-2833", 2, new DateTime(2026, 9, 15, 7, 0, 0, 0, DateTimeKind.Utc), 4, 1 },
                    { 10, 45m, "Trainer unavailable: the slot was already committed to another client.", new DateTime(2026, 9, 9, 19, 0, 0, 0, DateTimeKind.Utc), null, 5, null, null, new DateTime(2026, 9, 9, 17, 30, 0, 0, DateTimeKind.Utc), new DateTime(2026, 9, 15, 17, 0, 0, 0, DateTimeKind.Utc), 2, null, "FB-2839", 3, new DateTime(2026, 9, 15, 16, 0, 0, 0, DateTimeKind.Utc), 5, 2 }
                });

            migrationBuilder.InsertData(
                table: "Payments",
                columns: new[] { "Id", "Amount", "BookingId", "CapturedAtUtc", "CardBrand", "CardLast4", "CreatedAt", "Currency", "IsPaid", "MembershipId", "RefundedAmount", "RefundedAtUtc", "Status", "StripePaymentIntentId" },
                values: new object[,]
                {
                    { 7, 99m, null, new DateTime(2026, 9, 1, 8, 7, 0, 0, DateTimeKind.Utc), "Visa", "4242", new DateTime(2026, 9, 1, 8, 6, 0, 0, DateTimeKind.Utc), "BAM", true, 1, null, null, 2, "pi_seed_mem_1" },
                    { 8, 49m, null, new DateTime(2026, 9, 5, 19, 43, 0, 0, DateTimeKind.Utc), "Mastercard", "5556", new DateTime(2026, 9, 5, 19, 42, 0, 0, DateTimeKind.Utc), "BAM", true, 2, null, null, 2, "pi_seed_mem_2" },
                    { 9, 49m, null, new DateTime(2026, 7, 1, 12, 3, 0, 0, DateTimeKind.Utc), "Visa", "1881", new DateTime(2026, 7, 1, 12, 2, 0, 0, DateTimeKind.Utc), "BAM", true, 3, null, null, 2, "pi_seed_mem_3" },
                    { 1, 35m, 1, new DateTime(2026, 8, 17, 19, 33, 0, 0, DateTimeKind.Utc), "Visa", "4242", new DateTime(2026, 8, 17, 19, 32, 0, 0, DateTimeKind.Utc), "BAM", true, null, null, null, 2, "pi_seed_2801" },
                    { 2, 45m, 2, new DateTime(2026, 8, 22, 9, 3, 0, 0, DateTimeKind.Utc), "Mastercard", "5556", new DateTime(2026, 8, 22, 9, 2, 0, 0, DateTimeKind.Utc), "BAM", true, null, null, null, 2, "pi_seed_2812" },
                    { 3, 44m, 3, new DateTime(2026, 8, 24, 14, 4, 0, 0, DateTimeKind.Utc), "Visa", "1881", new DateTime(2026, 8, 24, 14, 3, 0, 0, DateTimeKind.Utc), "BAM", true, null, null, null, 2, "pi_seed_2818" },
                    { 4, 40m, 6, new DateTime(2026, 9, 13, 8, 33, 0, 0, DateTimeKind.Utc), "Visa", "4242", new DateTime(2026, 9, 13, 8, 32, 0, 0, DateTimeKind.Utc), "BAM", true, null, null, null, 2, "pi_seed_2852" },
                    { 5, 32m, 9, new DateTime(2026, 9, 8, 11, 3, 0, 0, DateTimeKind.Utc), "Mastercard", "5556", new DateTime(2026, 9, 8, 11, 2, 0, 0, DateTimeKind.Utc), "BAM", false, null, 32m, new DateTime(2026, 9, 10, 9, 30, 0, 0, DateTimeKind.Utc), 4, "pi_seed_2833" },
                    { 6, 50m, 8, null, null, null, new DateTime(2026, 9, 14, 7, 12, 0, 0, DateTimeKind.Utc), "BAM", false, null, null, null, 1, "pi_seed_2861" }
                });

            migrationBuilder.InsertData(
                table: "Reviews",
                columns: new[] { "Id", "BookingId", "ClientProfileId", "Comment", "CreatedAt", "Rating", "TrainerProfileId" },
                values: new object[,]
                {
                    { 1, 1, 1, "Calm, precise and very attentive to how my back was feeling. Best session I have had.", new DateTime(2026, 8, 20, 12, 0, 0, 0, DateTimeKind.Utc), 5, 1 },
                    { 2, 2, 2, "Hard but scaled well. Explained why each block was there.", new DateTime(2026, 8, 26, 8, 30, 0, 0, DateTimeKind.Utc), 5, 2 },
                    { 3, 3, 3, "Careful with the knee and adjusted the loading twice. Would book again.", new DateTime(2026, 8, 29, 10, 15, 0, 0, DateTimeKind.Utc), 4, 3 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "AuditLogs",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Availabilities",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Cities",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Cities",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "MembershipPlans",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "News",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "News",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "News",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Notifications",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Payments",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Reviews",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Reviews",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Reviews",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "SearchHistory",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "TrainerDocuments",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "TrainerDocuments",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "TrainerDocuments",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "TrainerDocuments",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "TrainerDocuments",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "TrainerDocuments",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 2, 1 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 3, 2 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 4, 2 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 5, 3 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 6, 4 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 7, 4 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 4, 5 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 8, 5 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 5, 6 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 6, 7 });

            migrationBuilder.DeleteData(
                table: "TrainerSpecialities",
                keyColumns: new[] { "SpecialityId", "TrainerProfileId" },
                keyValues: new object[] { 7, 7 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 1, 1 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 2 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 3 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 4 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 5 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 6 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 7 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 2, 8 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 3, 9 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 3, 10 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 3, 11 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 3, 12 });

            migrationBuilder.DeleteData(
                table: "UserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { 3, 13 });

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Bookings",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Categories",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "ClientProfiles",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Memberships",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Memberships",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Memberships",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Roles",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Specialities",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Categories",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "ClientProfiles",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "ClientProfiles",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "ClientProfiles",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "ClientProfiles",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Locations",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "MembershipPlans",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "MembershipPlans",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Services",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 6);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 8);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Categories",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Categories",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Categories",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Categories",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Cities",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "TrainerProfiles",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 9);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 10);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Cities",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 4);

            migrationBuilder.DeleteData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 5);

            migrationBuilder.DeleteData(
                table: "Cities",
                keyColumn: "Id",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Cities",
                keyColumn: "Id",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Countries",
                keyColumn: "Id",
                keyValue: 1);
        }
    }
}
