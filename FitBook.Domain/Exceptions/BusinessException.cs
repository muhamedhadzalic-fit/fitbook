namespace FitBook.Domain.Exceptions;

/// <summary>
/// A business rule refused the operation — an invalid booking transition, an
/// expired membership, a duplicate payment.
/// </summary>
/// <remarks>
/// The API maps this to 400 with the message intact, because the message is
/// meant for the user: error text has to say what is actually wrong, not
/// "Bad request". Throw this from the service layer; never catch it there.
/// </remarks>
public class BusinessException : Exception
{
    public BusinessException(string message)
        : base(message) { }

    public BusinessException(string message, Exception innerException)
        : base(message, innerException) { }
}
