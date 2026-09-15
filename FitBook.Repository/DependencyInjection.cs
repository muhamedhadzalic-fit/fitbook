using FitBook.Repository.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace FitBook.Repository;

/// <summary>
/// Registers the data layer. Called by FitBook.Services rather than by the API
/// directly, so the API never references this project or names
/// <see cref="FitBookDbContext"/>.
/// </summary>
public static class DependencyInjection
{
    public static IServiceCollection AddFitBookPersistence(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        var connectionString = configuration.GetConnectionString("Default");

        // Fail fast and loudly: a silently missing connection string would
        // otherwise surface as an obscure error on the first query.
        if (string.IsNullOrWhiteSpace(connectionString))
        {
            throw new InvalidOperationException(
                "Connection string 'ConnectionStrings__Default' was not found. "
                    + "Copy .env.example to .env.dev and set it before starting the app.");
        }

        // AddDbContext registers the context as Scoped, which is what any
        // service touching it must be — never Transient.
        services.AddDbContext<FitBookDbContext>(options => options.UseSqlServer(connectionString));

        // Repositories share the context's lifetime, so they are Scoped too.
        services.AddScoped<ICityRepository, CityRepository>();

        return services;
    }
}
