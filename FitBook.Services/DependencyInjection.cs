using FitBook.Repository;
using FitBook.Services.Reference;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace FitBook.Services;

/// <summary>
/// The single registration entry point for the hosts (API and Worker). It owns
/// wiring the data layer, which keeps FitBook.Api free of any reference to
/// FitBook.Repository.
/// </summary>
public static class DependencyInjection
{
    public static IServiceCollection AddFitBookServices(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddFitBookPersistence(configuration);

        // Business services are registered here as they land, always Scoped
        // while they touch the DbContext.
        services.AddScoped<ICityService, CityService>();

        return services;
    }
}
