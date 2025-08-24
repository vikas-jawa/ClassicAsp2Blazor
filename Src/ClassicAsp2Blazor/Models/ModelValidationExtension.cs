using System.ComponentModel.DataAnnotations;

namespace ClassicAsp2Blazor.Models
{
    public static class ModelValidationExtension
    {
        /// <summary>
        /// Validates an object against its DataAnnotation attributes.
        /// </summary>
        /// <typeparam name="T">The type of the object being validated.</typeparam>
        /// <param name="obj">The object instance to validate.</param>
        /// <param name="validationResults">The validation errors, if any.</param>
        /// <returns>True if the object is valid, otherwise false.</returns>
        public static bool IsValid<T>(this T obj, out List<ValidationResult> validationResults)
        {
            var context = new ValidationContext(obj!, serviceProvider: null, items: null);
            validationResults = [];

            return Validator.TryValidateObject(
                obj!,
                context,
                validationResults,
                validateAllProperties: true);
        }
    }
}
