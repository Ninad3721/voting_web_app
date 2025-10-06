using System.Security.Authentication;
using VotingApplication.Application.Response;

namespace VotingApplication.Api.Middleware
{
    public class GlobalExceptionHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<GlobalExceptionHandlingMiddleware> _logger;

        //Avoiding  using primary constructor for better code readability
        public GlobalExceptionHandlingMiddleware(RequestDelegate next, ILogger<GlobalExceptionHandlingMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task InvokeAsync(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (KeyNotFoundException ex)
            {
                //catching the keynotfound exception
                LogException(ex);
                context.Response.StatusCode = StatusCodes.Status404NotFound;
                await context.Response.WriteAsJsonAsync(new ApiResponse<string?>(StatusCodes.Status404NotFound, "", ex.Message, "Instance not found"));
            }
            catch (InvalidOperationException ex)
            {
                //catching the invalid data exception
                LogException(ex);
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
                await context.Response.WriteAsJsonAsync(new ApiResponse<string?>(StatusCodes.Status400BadRequest, "", ex.Message, "Operation is not valid"));
            }
            catch (InvalidCredentialException ex)
            {
                LogException(ex);
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
                await context.Response.WriteAsJsonAsync(new ApiResponse<string?>(StatusCodes.Status400BadRequest, "", ex.Message, "Password did not matched"));
            }
            catch (Exception ex)
            {
                //general exception
                LogException(ex);
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                await context.Response.WriteAsJsonAsync(new ApiResponse<string?>(StatusCodes.Status404NotFound, "", ex.Message, "Internal Server Error"));
            }
        }

        private void LogException(Exception ex)
        {
            // log file path
            var logFilePath = "Logs/exceptions.log";
            // log message
            var logMessage = $"{DateTime.Now:yyyy-MM-dd HH:mm:ss} - {ex.Message} - {ex.StackTrace}\n\n";

            //creating the directory
            Directory.CreateDirectory(Path.GetDirectoryName(logFilePath)!);

            // add exception to log file
            File.AppendAllText(logFilePath, logMessage);

            _logger.LogError(ex, "An error occurred");
        }
    }
}