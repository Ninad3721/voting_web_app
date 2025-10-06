namespace VotingApplication.Application.DTO
{
    //Response DTO for candidate showing fields that are in public domain
    public class VoterResponseDto : BaseEntityDto
    {
        public long VoterId { get; set; }

        public string Name { get; set; } = "";

        public bool HasVoted { get; set; }

        public DateOnly DOB { get; set; }
        public string Gender { get; set; } = "";
        public string Email { get; set; } = "";
        public string? Password { get; set; } = "";
    }
}