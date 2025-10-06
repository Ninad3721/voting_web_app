using VotingApplication.Domain.Common;

namespace VotingApplication.Domain.Entity
{
    public class Party : BaseEntity
    {
        public long PartyId { get; set; }
        public string PartyName { get; set; } = "";
    }
}