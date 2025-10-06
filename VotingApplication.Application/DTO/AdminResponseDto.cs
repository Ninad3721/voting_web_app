namespace VotingApplication.Application.DTO
{
    public class AdminResponseDto : BaseEntityDto
    {
        public string Role { get; set; } = "";
        public string Email { get; set; } = "";
    }
}