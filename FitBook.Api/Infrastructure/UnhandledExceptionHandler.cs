using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace FitBook.Api.Infrastructure;

/// <summary>
/// The catch-all. Anything the typed handlers did not claim becomes a 500.
/// </summary>
/// <remarks>
/// Registered last, because handlers run in registration order and the first one
/// to return true wins. The exception is always logged in full through
/// <see cref="ILogger{T}"/>; it is only ever echoed to the caller in
/// Development, so no internal detail leaves a deployed environment.
/// </remarks>
public sealed class UnhandledExceptionHandler(
    IProblemDetailsService problemDetailsService,
    IHostEnvironment environment,
    ILogger<UnhandledExceptionHandler> logger) : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        logger.LogError(
            exception,
            "Unhandled exception handling {Method} {Path}",
            httpContext.Request.Method,
            httpContext.Request.Path);

        httpContext.Response.StatusCode = StatusCodes.Status500InternalServerError;

        return await problemDetailsService.TryWriteAsync(
            new ProblemDetailsContext
            {
                HttpContext = httpContext,
                Exception = exception,
                ProblemDetails = new ProblemDetails
                {
                    Status = StatusCodes.Status500InternalServerError,
                    Title = "An unexpected error occurred",
                    Detail = environment.IsDevelopment()
                        ? exception.ToString()
                        : "The request could not be processed. If it keeps happening, contact an administrator.",
                },
            });
    }
}
