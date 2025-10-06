using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Domain.Config
{
    public class VoterConfig : IEntityTypeConfiguration<Voter>
    {
        //Configuration of Voter Entity
        public void Configure(EntityTypeBuilder<Voter> builder)
        {
            // Configure the VoterId property
            builder.HasKey(v => v.VoterId);
            builder.Property(v => v.VoterId)
                .UseIdentityColumn(increment: 1)
                .HasColumnType("bigint")
                .IsRequired();

            // Configure the Name property
            builder.Property(v => v.Name)
                .IsRequired().HasMaxLength(500);

            // Configure the HasVoted property
            builder.Property(v => v.HasVoted)
                .HasDefaultValue(false);

            // Configure the DOB property
            builder.Property(v => v.DOB)
                .HasColumnType("date")
                .IsRequired();

            // Configure the Gender property
            builder.Property(v => v.Gender)
                .IsRequired()
                .HasMaxLength(20);

            builder.Property(x => x.Role)
                .HasDefaultValue("Voter");

            builder.Property(x => x.Email)
                .IsRequired()
                .HasMaxLength(254);
        }
    }
}