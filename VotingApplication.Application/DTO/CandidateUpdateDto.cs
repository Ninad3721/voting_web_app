using System.ComponentModel.DataAnnotations;
using VotingApplication.Application.Validations;

namespace VotingApplication.Application.DTO
{
    //Update DTO for candiate containing fields that are editable
    public class CandidateUpdateDto
    {
        [Required(ErrorMessage = "Name is mandatory field")]
        public string Name { get; set; } = "";

        [Required(ErrorMessage = "DOB is mandatory field")]
        [CandidateAge]
        public DateOnly DOB { get; set; }

        [Required(ErrorMessage = "Gender is mandatory field")]
        public string Gender { get; set; } = "";

        [MinLength(3, ErrorMessage = "Party name should contain aleast 3 characters")]
        [MaxLength(5, ErrorMessage = "Party name should not contain  more than 5 characters")]
        [Required(ErrorMessage = "Party name is mandatory field")]
        public string PartyName { get; set; } = "";
    }
}