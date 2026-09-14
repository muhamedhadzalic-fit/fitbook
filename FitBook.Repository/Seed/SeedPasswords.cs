namespace FitBook.Repository.Seed;

/// <summary>
/// Password hashes for the seeded accounts.
/// </summary>
/// <remarks>
/// These are literals on purpose. HasData values must be deterministic: hashing
/// at model-build time would produce a fresh salt on every run, and EF would
/// then detect a model change on every single migration.
/// <para>
/// Every value here was produced with exactly the parameters
/// <c>FitBook.Services.Security.PasswordHasher</c> uses — PBKDF2-HMAC-SHA256,
/// 100,000 iterations, 16-byte salt, 32-byte key, encoded as
/// <c>pbkdf2-sha256$iterations$saltBase64$keyBase64</c> — so <c>Verify</c>
/// accepts a seeded account exactly as it accepts a registered one. That
/// agreement is the whole point: a seeder and a runtime hasher that disagree on
/// format is a known trap, and it shows up as seeded users being unable to log
/// in.
/// </para>
/// <para>
/// The password for every seeded account is <c>test</c>, matching the
/// credentials table the README is required to carry. Salts differ per account,
/// so the shared password does not produce a shared hash.
/// </para>
/// <para>
/// FitBook.Repository cannot reference FitBook.Services — the dependency runs
/// the other way — which is a second reason these are literals rather than
/// generated here.
/// </para>
/// </remarks>
internal static class SeedPasswords
{
    // admin@fitbook.ba
    public const string User1 =
        "pbkdf2-sha256$100000$ny0xfaTUAvBf3rgIQ3J6qw==$0H3M0VGzhz3itClxkwl92U1o2eKzGzFEsmigUoUMZxg=";

    // ana.kovac@fitbook.ba
    public const string User2 =
        "pbkdf2-sha256$100000$K+KrapVdl/zLF0EUWzK89w==$w6EZ9bkVRphDmrvtvitcKUJv+jCYOOYJFxxo2Q2dl6Q=";

    // marko.petric@fitbook.ba
    public const string User3 =
        "pbkdf2-sha256$100000$j31JfiSWz7GcMLIKZfVvhA==$r+QX9ESyosHuu7eMMRg7YXOFE38WvZluDLyDwUA4p0g=";

    // iva.milic@fitbook.ba
    public const string User4 =
        "pbkdf2-sha256$100000$ltpovbtv5ncfhFxYwzjnXA==$iIJqdbOHv0qV7IXGtfyGpu75QRdu2Af77jky2Ler3tU=";

    // damir.juric@fitbook.ba
    public const string User5 =
        "pbkdf2-sha256$100000$HiikeDJXcIPlHgPoTL0kVg==$fGcOolGP14gZ84jo3DULhOU9HBNqLxUYTuZcjMm4KSo=";

    // lejla.hodzic@fitbook.ba
    public const string User6 =
        "pbkdf2-sha256$100000$Kv7gBFrn/IpggAbKSfp1ow==$rJtHBcul8tzCNxbuRG5sqvWwISMtPt7qbfqbLmc5CIM=";

    // goran.lukic@fitbook.ba
    public const string User7 =
        "pbkdf2-sha256$100000$78HrMlrBH7CGzci8cJBYcA==$4nrVMBFToM+SVjCgPGPcEXW6VdywMMJ+mYSjioymR5w=";

    // mirza.aldic@fitbook.ba
    public const string User8 =
        "pbkdf2-sha256$100000$bxn8OXUSeEIB2A0l3flRQQ==$Kph755Nz9mB6s4uJSQ97R5Ok17S9yI3hMUjGNgjEYpo=";

    // amila.dedovic@fitbook.ba
    public const string User9 =
        "pbkdf2-sha256$100000$LFycI6v7kw3iLqgl8mfMdg==$uMaTfBdxSBoKiyokC3jvsFtBTHy0slx33Gqo9O+P104=";

    // nedim.hadzic@fitbook.ba
    public const string User10 =
        "pbkdf2-sha256$100000$2/WzLWb8+W3FZ/y6+TfCbQ==$ZQCzKYlk1+3bgcszclfak0ftfgcKyiVQZo9odr4aMlg=";

    // selma.begic@fitbook.ba
    public const string User11 =
        "pbkdf2-sha256$100000$QHFOQ4Sur6M+rqhvdiHktg==$TA6FLCiALbHPMnfFpZX153511kk2K9NmWm2xWgnXZa0=";

    // haris.demirovic@fitbook.ba
    public const string User12 =
        "pbkdf2-sha256$100000$wTDcbwM7l5vyBDutBd6u1Q==$Kncnawf/bASKip4QuslogUH/N2R4OU1nZ6UTZxvyJV8=";

    // dzana.mujkic@fitbook.ba
    public const string User13 =
        "pbkdf2-sha256$100000$a15dqQh2iMbItUjbgz5pnA==$4d4kKeFheecZ87eizeFVTBJY+qM4Oqub2w7TZfs7ea8=";
}
