using System.ComponentModel.DataAnnotations;
using VotingApplication.Application.Validations;

namespace VotingApplication.Application.DTO
{
    //Request DTO for candiate while creating the candidate
    public class CreateCandidateDto
    {
        [Required(ErrorMessage = "Name is mandatory field")]
        public string Name { get; set; } = "";

        [Required(ErrorMessage = "DOB is mandatory field")]
        [CandidateAge] // Checks if the candidate's between 18 and 75
        public DateOnly DOB { get; set; }

        [Required(ErrorMessage = "Gender is mandatory field")]
        public string Gender { get; set; } = "";

        [Required(ErrorMessage = "Candidate Password is mandatory field")]
        public string Password { get; set; } = "";

        [MinLength(3, ErrorMessage = "Party name should contain aleast 3 characters")]
        [MaxLength(5, ErrorMessage = "Party name should not contain  more than 5 characters")]
        [Required(ErrorMessage = "Party name is mandatory field")]
        public string PartyName { get; set; } = "";
    }
}