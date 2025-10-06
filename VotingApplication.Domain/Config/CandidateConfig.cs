using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Domain.Config
{
    //Configurations for candidate entity
    public class CandidateConfig : IEntityTypeConfiguration<Candidate>
    {
        public void Configure(EntityTypeBuilder<Candidate> builder)
        {
            // Configure the CandidateId property
            //Primary Key for Candidate
            builder.HasKey(c => c.CandidateId);
            builder.Property(c => c.CandidateId)
                .UseIdentityColumn(increment: 1)
                .HasColumnType("bigint")
                .IsRequired();

            // Configure the Name property
            builder.Property(c => c.Name)
                .IsRequired()
                .HasMaxLength(500);

            // Configure the DOB property
            builder.Property(c => c.DOB)
                .HasColumnType("date")
                .IsRequired();

            // Configure the TotalVotes property
            builder.Property(c => c.TotalVotes)
                .HasColumnType("bigint")
                .HasDefaultValue(0);

            //Configure Gender properties
            builder.Property(v => v.Gender)
                .IsRequired().HasMaxLength(20);

            builder.Property(x => x.Role)
                .HasDefaultValue("Candidate");

            builder.Property(x => x.PartyName)
    .HasMaxLength(5)
    .IsRequired();
        }
    }
}