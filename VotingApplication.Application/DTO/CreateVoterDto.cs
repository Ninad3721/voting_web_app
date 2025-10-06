using System.ComponentModel.DataAnnotations;
using VotingApplication.Application.Validations;

namespace VotingApplication.Application.DTO
{
    //Request DTO for voter while creating the voter
    public class CreateVoterDto
    {
        [Required(ErrorMessage = "Name is mandatory field")]
        public string Name { get; set; } = "";

        [Required(ErrorMessage = "DOB is mandatory field")]
        [VoterAge] // Checks if the voter's above 18
        public DateOnly DOB { get; set; }

        [Required(ErrorMessage = "Gender is mandatory field")]
        public string? Gender { get; set; } = "";

        [EmailAddress]
        [Required(ErrorMessage = "Email is mandatory field")]
        public string? Email { get; set; } = "";

        [Required(ErrorMessage = "Voter Password is mandatory field")]
        public string Password { get; set; } = "";
    }
}