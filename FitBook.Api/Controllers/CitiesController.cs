using FitBook.Domain.Dtos;
using FitBook.Domain.Dtos.Reference;
using FitBook.Services.Reference;
using Microsoft.AspNetCore.Mvc;

namespace FitBook.Api.Controllers;

/// <summary>
/// Cities, the reference table both apps populate their dropdowns from.
/// </summary>
/// <remarks>
/// The pilot for the conventions every later controller follows: paged and
/// searchable list, DTOs out, no business logic, and errors raised as exceptions
/// for the ProblemDetails handlers rather than assembled here.
/// <para>
/// No <c>[Authorize]</c> yet, only because authentication does not exist until
/// the next phase. Adding it is part of that phase's definition of done — an
/// endpoint left open is a defect, not a feature.
/// </para>
/// </remarks>
[ApiController]
[Route("api/[controller]")]
public sealed class CitiesController(ICityService cityService) : ControllerBase
{
    /// <summary>One page of cities, newest filter applied at the database.</summary>
    [HttpGet]
    public Task<PagedResult<CityDto>> Search(
        [FromQuery] PagedRequest request,
        CancellationToken cancellationToken) =>
        cityService.SearchAsync(request, cancellationToken);

    /// <summary>A single city. Responds 404 when the id does not exist.</summary>
    [HttpGet("{id:int}")]
    public Task<CityDto> Get(int id, CancellationToken cancellationToken) =>
        cityService.GetAsync(id, cancellationToken);
}
