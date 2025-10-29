using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => Results.Ok(new { app = "orders-api", status = "ok" }));
app.MapGet("/health", () => Results.Ok("Healthy"));

app.Run();
