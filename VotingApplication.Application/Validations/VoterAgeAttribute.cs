using System.ComponentModel.DataAnnotations;

namespace VotingApplication.Application.Validations
{
    public class VoterAgeAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value is DateOnly dateValue)
            {
                int age = DateOnly.FromDateTime(DateTime.Now).Year - dateValue.Year;
                if (dateValue > DateOnly.FromDateTime(DateTime.Now))
                {
                    return new ValidationResult("Date cannot be future date");
                }
                else if (age < 18 || age > 150)
                {
                    return new ValidationResult("Age should be above 18 ag and not more than 150 years ");
                }
                else
                {
                    return ValidationResult.Success;
                }
            }

            return new ValidationResult("Given input is not a date");
        }
    }
}