namespace VotingApplication.Application.DTO
{
    //Base entity DTO that will be inherited by voter DTOs and candidate DTOs
    public class BaseEntityDto
    {
        public DateTimeOffset DateCreated { get; set; } = DateTimeOffset.Now;
        public DateTimeOffset? DateUpdated { get; set; }
    }
}