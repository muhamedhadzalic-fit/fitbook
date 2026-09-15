using FitBook.Api.Infrastructure;
using FitBook.Services;
using FitBook.Services.Configuration;

// Before CreateBuilder, so the environment-variable configuration provider sees
// the values this puts in the process environment.
var envFile = EnvFile.Load();

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddOpenApi();
builder.Services.AddHttpContextAccessor();
builder.Services.AddFitBookServices(builder.Configuration);

// Errors reach both apps in one shape: RFC 7807 ProblemDetails. Handlers run in
// registration order and the first to claim an exception wins, so the catch-all
// is registered last.
builder.Services.AddProblemDetails();
builder.Services.AddExceptionHandler<NotFoundExceptionHandler>();
builder.Services.AddExceptionHandler<BusinessExceptionHandler>();
builder.Services.AddExceptionHandler<UnhandledExceptionHandler>();

var app = builder.Build();

// Names the file only — never a value from it.
app.Logger.LogInformation(
    "Configuration loaded from {EnvFile} ({Environment})",
    envFile ?? "process environment only",
    app.Environment.EnvironmentName);

// First in the pipeline, so nothing downstream can throw past it.
app.UseExceptionHandler();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();

    // AddOpenApi produces the document but ships no UI, so Swashbuckle supplies
    // only the UI and points at that same document. Registering full Swashbuckle
    // as well would mean two OpenAPI generators in one application.
    app.UseSwaggerUI(options => options.SwaggerEndpoint("/openapi/v1.json", "FitBook API v1"));
}

// No UseHttpsRedirection: the API is plain HTTP by design. Self-signed
// certificates break the review, so HTTPS is deliberately absent.
app.MapControllers();

await app.RunAsync();
