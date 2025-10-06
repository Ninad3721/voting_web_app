using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Domain.Config
{
    public class RefreshTokenConfig : IEntityTypeConfiguration<RefreshToken>
    {
        public void Configure(EntityTypeBuilder<RefreshToken> builder)
        {
            builder.HasKey(x => x.TokenId);
            builder.Property(x => x.Token).HasMaxLength(200);
            builder.HasIndex(x => x.Token).IsUnique();
            builder.HasOne(x => x.Admin).WithMany().HasForeignKey(x => x.AdminId);
            builder.HasOne(x => x.Voter).WithMany().HasForeignKey(x => x.VoterId);
        }
    }
}