using Microsoft.EntityFrameworkCore;
using VotingApplication.Domain.Config;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Domain.Context
{
    public class ApplicationContext(DbContextOptions<ApplicationContext> options) : DbContext(options)
    {
        //Registering entites using DbSet<>
        public DbSet<Candidate> Candidates { get; set; }

        public DbSet<Voter> Voters { get; set; }
        public DbSet<Admin> Admins { get; set; }
        public DbSet<RefreshToken> RefreshTokens { get; set; }
        public DbSet<Party> Parties { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            //Applying configurations to the entity
            modelBuilder.ApplyConfiguration(new VoterConfig());
            modelBuilder.ApplyConfiguration(new CandidateConfig());
            modelBuilder.ApplyConfiguration(new AdminConfig());
            modelBuilder.ApplyConfiguration(new PartyConfig());
            modelBuilder.ApplyConfiguration(new RefreshTokenConfig());

            base.OnModelCreating(modelBuilder);
        }
    }
}