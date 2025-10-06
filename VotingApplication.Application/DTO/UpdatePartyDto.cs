using System.ComponentModel.DataAnnotations;

namespace VotingApplication.Application.DTO
{
    public class UpdatePartyDto
    {
        [MinLength(3, ErrorMessage = "Party name should contain aleast 3 characters")]
        [MaxLength(5, ErrorMessage = "Party name should not contain  more than 5 characters")]
        [Required(ErrorMessage = "Party name is mandatory field")]
        public string PartyName { get; set; } = "";
    }
}