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

var app = builder.Build();

// Names the file only — never a value from it.
app.Logger.LogInformation(
    "Configuration loaded from {EnvFile} ({Environment})",
    envFile ?? "process environment only",
    app.Environment.EnvironmentName);

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

// No UseHttpsRedirection: the API is plain HTTP by design. Self-signed
// certificates break the review, so HTTPS is deliberately absent.
app.MapControllers();

await app.RunAsync();
