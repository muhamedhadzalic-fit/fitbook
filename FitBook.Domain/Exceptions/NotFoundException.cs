namespace FitBook.Domain.Exceptions;

/// <summary>
/// The requested record does not exist. The API maps this to 404.
/// </summary>
public class NotFoundException : Exception
{
    /// <summary>
    /// Names the entity and the key that was looked up, producing a message like
    /// <c>City '99' was not found.</c>
    /// </summary>
    public NotFoundException(string entityName, object key)
        : base($"{entityName} '{key}' was not found.")
    {
        EntityName = entityName;
        Key = key;
    }

    public NotFoundException(string message)
        : base(message) { }

    public string? EntityName { get; }

    public object? Key { get; }
}
