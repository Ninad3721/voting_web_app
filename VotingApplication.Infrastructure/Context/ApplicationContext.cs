using Microsoft.EntityFrameworkCore;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Infrastructure.Context
{
    public class ApplicationContext : DbContext
    {
        public ApplicationContext(DbContextOptions<ApplicationContext> options) : base(options)
        {
        }

        public DbSet<Candidate> Candidates { get; set; }
        public DbSet<Voter> Voters { get; set; }
    }
}