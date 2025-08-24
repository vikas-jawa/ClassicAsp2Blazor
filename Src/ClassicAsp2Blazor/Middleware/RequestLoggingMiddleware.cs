namespace ClassicAsp2Blazor.Middleware
{
    public class RequestLoggingMiddleware(RequestDelegate next)
    {
        private readonly RequestDelegate _next = next;

        public async Task InvokeAsync(HttpContext context)
        {
            Console.WriteLine($"[RequestLoggingMiddleware] Handling {context.Request.Method} {context.Request.Path}");

            // logic here

            await _next(context);
            Console.WriteLine($"[RequestLoggingMiddleware] Finished handling request");
        }
    }
}
