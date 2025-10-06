using VotingApplication.Domain.Common;

namespace VotingApplication.Domain.Entity
{
    //Inherits the common fields from base entity
    public class Voter : BaseEntity
    {
        //Auto generated voter Id
        public long VoterId { get; set; }

        //Name of the voter
        public string Name { get; set; } = "";

        //Flag for knowing if the voter has voted or not
        public bool HasVoted { get; set; } = false;

        //Date of birth of voter (only date not time)
        public DateOnly DOB { get; set; }

        //Gender of voter
        public string Gender { get; set; } = "";

        //Password of voter
        public string Password { get; set; } = "";

        //voter email
        public string Email { get; set; } = "";

        //Role
        public string Role { get; set; } = "Voter";
    }
}