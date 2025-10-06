using System.ComponentModel.DataAnnotations;

namespace VotingApplication.Application.DTO
{
    public class CreateAdminDto
    {
        [EmailAddress]
        [Required(ErrorMessage = "Email is mandatory field")]
        public string? Email { get; set; } = "";

        [Required(ErrorMessage = "Voter Password is mandatory field")]
        public string Password { get; set; } = "";
    }
}