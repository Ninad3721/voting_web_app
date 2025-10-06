using System.ComponentModel.DataAnnotations;

namespace VotingApplication.Application.DTO
{
    public class LoginDto
    {
        [EmailAddress]
        [Required(ErrorMessage = "Email is mandatory field")]
        public string Email { get; set; } = "";

        [Required(ErrorMessage = "Password is mandatory field")]
        public string Password { get; set; } = "";

        [Required(ErrorMessage = "Role is mandatory field")]
        public string Role { get; set; } = "";
    }
}