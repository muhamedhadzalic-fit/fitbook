using System.Security.Cryptography;
using System.Text;

namespace FitBook.Services.Security;

/// <summary>
/// Password hashing for the whole application: PBKDF2-HMAC-SHA256, salted per
/// password, with the parameters embedded in the encoded string so they can be
/// raised later without invalidating existing hashes.
/// </summary>
/// <remarks>
/// The encoded format is <c>pbkdf2-sha256$iterations$saltBase64$keyBase64</c>.
/// Seed data in FitBook.Repository stores literals produced with exactly these
/// parameters, so <see cref="Verify"/> accepts seeded and runtime-created
/// accounts alike — a mismatch between the two is a known trap. Seed hashes are
/// literals rather than generated at model-build time because HasData values
/// must be deterministic; a fresh salt on every run would make EF detect a model
/// change on every migration.
/// </remarks>
public static class PasswordHasher
{
    private const string Algorithm = "pbkdf2-sha256";
    private const int Iterations = 100_000;
    private const int SaltSize = 16;
    private const int KeySize = 32;
    private const char Separator = '$';

    /// <summary>Hashes a password with a fresh cryptographically random salt.</summary>
    public static string Hash(string password)
    {
        ArgumentException.ThrowIfNullOrEmpty(password);

        // RandomNumberGenerator, never System.Random, for anything security related.
        var salt = RandomNumberGenerator.GetBytes(SaltSize);
        return Encode(password, salt, Iterations);
    }

    /// <summary>
    /// Verifies a password against an encoded hash. Returns false rather than
    /// throwing on a malformed hash, so a corrupted record cannot take the
    /// login endpoint down.
    /// </summary>
    public static bool Verify(string password, string encodedHash)
    {
        if (string.IsNullOrEmpty(password) || string.IsNullOrEmpty(encodedHash))
        {
            return false;
        }

        var parts = encodedHash.Split(Separator);
        if (parts.Length != 4 || parts[0] != Algorithm)
        {
            return false;
        }

        if (!int.TryParse(parts[1], out var iterations) || iterations <= 0)
        {
            return false;
        }

        byte[] salt;
        byte[] expected;
        try
        {
            salt = Convert.FromBase64String(parts[2]);
            expected = Convert.FromBase64String(parts[3]);
        }
        catch (FormatException)
        {
            return false;
        }

        var actual = Rfc2898DeriveBytes.Pbkdf2(
            Encoding.UTF8.GetBytes(password),
            salt,
            iterations,
            HashAlgorithmName.SHA256,
            expected.Length);

        // Fixed-time comparison, so a wrong password cannot be narrowed down by
        // timing how long the check took.
        return CryptographicOperations.FixedTimeEquals(actual, expected);
    }

    private static string Encode(string password, byte[] salt, int iterations)
    {
        var key = Rfc2898DeriveBytes.Pbkdf2(
            Encoding.UTF8.GetBytes(password),
            salt,
            iterations,
            HashAlgorithmName.SHA256,
            KeySize);

        return string.Join(
            Separator,
            Algorithm,
            iterations,
            Convert.ToBase64String(salt),
            Convert.ToBase64String(key));
    }
}
