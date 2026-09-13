namespace FitBook.Services.Configuration;

/// <summary>
/// Loads the environment's <c>.env</c> file into the process environment before
/// the host builds its configuration, so .NET's environment-variable provider
/// picks the values up with its normal <c>__</c> to <c>:</c> mapping. No custom
/// configuration source is needed.
/// </summary>
/// <remarks>
/// Lives in FitBook.Services because both hosts reference it and FitBook.Domain
/// must stay free of packages.
/// </remarks>
public static class EnvFile
{
    private const string DevelopmentFile = ".env.dev";
    private const string ProductionFile = ".env.prod";

    /// <summary>
    /// Loads the file matching <c>ASPNETCORE_ENVIRONMENT</c> (or
    /// <c>DOTNET_ENVIRONMENT</c> for the Worker) and returns the path it used,
    /// or <c>null</c> when no file was found.
    /// </summary>
    /// <remarks>
    /// A missing file is not an error — a container injects its variables
    /// directly. Missing <em>keys</em> are: each consumer validates its own
    /// section at startup.
    /// </remarks>
    public static string? Load()
    {
        var environment =
            Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT")
            ?? Environment.GetEnvironmentVariable("DOTNET_ENVIRONMENT")
            ?? "Production";

        var fileName = environment switch
        {
            "Development" => DevelopmentFile,
            "Production" => ProductionFile,

            // A typo in the environment name must not silently run the app
            // against the wrong database.
            _ => throw new InvalidOperationException(
                $"Unsupported environment '{environment}'. "
                    + "Expected 'Development' or 'Production'."),
        };

        var path = FindUpwards(fileName);
        if (path is null)
        {
            return null;
        }

        // NoClobber: a variable already in the process environment wins over the
        // file, which is what lets Docker Compose inject values later with no
        // code change.
        DotNetEnv.Env.NoClobber().Load(path);

        return path;
    }

    /// <summary>
    /// Walks up from the current directory looking for <paramref name="fileName"/>.
    /// The file sits at the repository root, but <c>dotnet run --project</c>, an
    /// IDE and <c>dotnet ef</c> all start in different directories.
    /// </summary>
    private static string? FindUpwards(string fileName)
    {
        var directory = new DirectoryInfo(Directory.GetCurrentDirectory());

        while (directory is not null)
        {
            var candidate = Path.Combine(directory.FullName, fileName);
            if (File.Exists(candidate))
            {
                return candidate;
            }

            directory = directory.Parent;
        }

        return null;
    }
}
