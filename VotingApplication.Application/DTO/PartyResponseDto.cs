namespace VotingApplication.Application.DTO
{
    public class PartyResponseDto : BaseEntityDto
    {
        public string PartyName { get; set; } = "";
        public long PartyId { get; set; }
    }
}