using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Domain.Config
{
    public class AdminConfig : IEntityTypeConfiguration<Admin>
    {
        public void Configure(EntityTypeBuilder<Admin> builder)
        {
            builder.HasKey(v => v.AdminId);
            builder.Property(v => v.AdminId)
                .UseIdentityColumn(increment: 1)
                .HasColumnType("bigint")
                .IsRequired();

            builder.Property(x => x.Role)
                .HasDefaultValue("Admin");

            builder.Property(x => x.Email)
                .IsRequired()
                .HasMaxLength(254);
        }
    }
}