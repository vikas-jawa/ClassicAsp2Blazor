using ClassicAsp2Blazor.Components;
using ClassicAsp2Blazor.Middleware;
using ClassicAsp2Blazor.Services.Implementation;
using ClassicAsp2Blazor.Services.Interface;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents();

// Logger: Serilog
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .CreateLogger();
builder.Services.AddSerilog();  //Registers ILogger bindings for Serilog manually

// DI: Service
builder.Services.AddScoped<IBaseService, BaseService>();
builder.Services.AddScoped<ICustomerService, CustomerService>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
}

app.UseMiddleware<RequestLoggingMiddleware>();
app.UseStaticFiles();
app.UseAntiforgery();

// MapRazorComponents automatically handles routing
app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode();

app.Run();