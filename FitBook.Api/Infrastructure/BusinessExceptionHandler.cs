using FitBook.Domain.Exceptions;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.Mvc;

namespace FitBook.Api.Infrastructure;

/// <summary>
/// Maps <see cref="BusinessException"/> to 400 as RFC 7807 ProblemDetails,
/// keeping the message: it explains what rule was broken and is written to be
/// read by the user.
/// </summary>
public sealed class BusinessExceptionHandler(IProblemDetailsService problemDetailsService)
    : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        if (exception is not BusinessException businessException)
        {
            return false;
        }

        httpContext.Response.StatusCode = StatusCodes.Status400BadRequest;

        return await problemDetailsService.TryWriteAsync(
            new ProblemDetailsContext
            {
                HttpContext = httpContext,
                Exception = businessException,
                ProblemDetails = new ProblemDetails
                {
                    Status = StatusCodes.Status400BadRequest,
                    Title = "Request could not be completed",
                    Detail = businessException.Message,
                },
            });
    }
}
