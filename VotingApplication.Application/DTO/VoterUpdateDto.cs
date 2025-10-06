using System.ComponentModel.DataAnnotations;
using VotingApplication.Application.Validations;

namespace VotingApplication.Application.DTO
{
    //Update DTO for voter containing fields that are editable
    public class VoterUpdateDto
    {
        [Required(ErrorMessage = "Name is mandatory field")]
        public string Name { get; set; } = "";

        [Required(ErrorMessage = "DOB is mandatory field")]
        [VoterAge]
        public DateOnly DOB { get; set; }

        [Required(ErrorMessage = "Name is mandatory field")]
        public string Gender { get; set; } = "";

        [EmailAddress]
        [Required(ErrorMessage = "Email is mandatory field")]
        public string Email { get; set; } = "";
    }
}