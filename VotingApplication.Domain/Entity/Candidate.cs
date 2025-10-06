using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using VotingApplication.Domain.Common;

namespace VotingApplication.Domain.Entity
{
    public class Candidate : BaseEntity
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public long CandidateId { get; set; }

        //Name of the candidate
        public string Name { get; set; } = "";

        //Gender of candidate
        public string Gender { get; set; } = "";

        //Date of birth of candidate (only date not time)
        public DateOnly DOB { get; set; }

        //Total votes gained by candidates
        public long TotalVotes { get; set; } = 0;

        //Pasword of candidate
        public string Password { get; set; } = "";

        //Role
        public string Role { get; set; } = "Candidate";

        // Foreign key for Party

        public string PartyName { get; set; } = "";
    }
}