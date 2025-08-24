namespace ClassicAsp2Blazor.Exceptions
{
    // When a custom exception is necessary, name it appropriately and derive it from the Exception class
    // https://learn.microsoft.com/en-us/dotnet/standard/exceptions/best-practices-for-exceptions
    public class ServiceException : Exception
    {
        public string ErrorId { get; }

        public ServiceException(string message, string errorId)
            : base(message)
        {
            ErrorId = errorId;
        }

        public ServiceException(string message, string errorId, Exception inner)
            : base(message, inner)
        {
            ErrorId = errorId;
        }
    }

}
