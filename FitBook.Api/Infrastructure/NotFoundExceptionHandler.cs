using FitBook.Domain.Exceptions;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace FitBook.Api.Infrastructure;

/// <summary>
/// Maps <see cref="NotFoundException"/> to 404 as RFC 7807 ProblemDetails.
/// </summary>
public sealed class NotFoundExceptionHandler(IProblemDetailsService problemDetailsService)
    : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        // Returning false passes the exception to the next handler.
        if (exception is not NotFoundException notFound)
        {
            return false;
        }

        httpContext.Response.StatusCode = StatusCodes.Status404NotFound;

        return await problemDetailsService.TryWriteAsync(
            new ProblemDetailsContext
            {
                HttpContext = httpContext,
                Exception = notFound,
                ProblemDetails = new ProblemDetails
                {
                    Status = StatusCodes.Status404NotFound,
                    Title = "Resource not found",
                    Detail = notFound.Message,
                },
            });
    }
}
