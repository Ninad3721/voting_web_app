using VotingApplication.Domain.Common;

namespace VotingApplication.Domain.Entity
{
    public class Admin : BaseEntity
    {
        public long AdminId { get; set; }
        public string Role { get; set; } = "Admin";
        public string Email { get; set; } = "";
        public string Password { get; set; } = "";
    }
}