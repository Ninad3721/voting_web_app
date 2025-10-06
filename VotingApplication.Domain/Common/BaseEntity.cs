namespace VotingApplication.Domain.Common
{
    //Base entity that has common entities that will be applied to all the tables
    public class BaseEntity
    {
        // Creation timestamp of data
        public DateTimeOffset DateCreated { get; set; } = DateTimeOffset.Now;

        // Update timestamp of data
        public DateTimeOffset? DateUpdated { get; set; }

        // Flag for deletion of field (Soft deletion)
        public bool IsDeleted { get; set; } = false;
    }
}