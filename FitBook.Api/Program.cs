var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

// No UseHttpsRedirection: the API is plain HTTP by design. Self-signed
// certificates break the review, so HTTPS is deliberately absent.
app.MapControllers();

await app.RunAsync();
