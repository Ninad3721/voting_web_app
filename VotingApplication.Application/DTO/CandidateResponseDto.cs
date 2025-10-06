namespace VotingApplication.Application.DTO
{
    //Response DTO for candidate showing fields that are in public domain
    public class CandidateResponseDto : BaseEntityDto
    {
        public long CandidateId { get; set; }
        public string Name { get; set; } = "";
        public string Gender { get; set; } = "";
        public DateOnly DOB { get; set; }
        public long TotalVotes { get; set; } = 0;
        public string Password { get; set; } = "";
        public string Email { get; set; } = "";

        public string PartyName { get; set; } = "";
    }
}