using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Domain.Config
{
    public class PartyConfig : IEntityTypeConfiguration<Party>
    {
        public void Configure(EntityTypeBuilder<Party> builder)
        {
            builder.HasKey(v => v.PartyId);
            builder.Property(v => v.PartyId)
                .UseIdentityColumn(increment: 1)
                .HasColumnType("bigint")
                .IsRequired();

            builder.Property(x => x.PartyName)
                .HasMaxLength(5)
                .IsRequired();
        }
    }
}