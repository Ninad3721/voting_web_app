namespace VotingApplication.Domain.Entity
{
    public class RefreshToken
    {
        public long TokenId { get; set; }
        public string Token { get; set; } = "";
        public DateTime TokenExp { get; set; }
        public long? VoterId { get; set; }
        public long? AdminId { get; set; }
        public Voter? Voter { get; set; }
        public Admin? Admin { get; set; }
    }
}