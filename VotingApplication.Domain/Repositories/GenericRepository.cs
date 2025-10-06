using Microsoft.EntityFrameworkCore;
using VotingApplication.Domain.Context;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Domain.Repositories
{
    public class GenericRepository<T>(ApplicationContext applicationContext) : IGenericRepository<T> where T : class
    {
        private readonly ApplicationContext _context = applicationContext;
        private readonly DbSet<T> _dbSet = applicationContext.Set<T>();

        //Generic function to get all the instance
        public async Task<IEnumerable<T>> GetAllAsync(int pageNumber, int pageSize, bool fetchAll)
        {
            if (fetchAll)
            {
                return await _dbSet.ToListAsync();
            }
            else
            {
                var query = _dbSet.AsQueryable();
                int totalRecords = await query.CountAsync();
                var items = await query
                .Skip((pageNumber - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();
                return items;
            }
        }

        //Generic function to get all instances based on their primary key
        public async Task<T?> GetByIdAsync(long id)
        {
            return await _dbSet.FindAsync(id) ?? null;
        }

        //Generic function to create an instance
        public async Task CreateAsync(T entity)
        {
            await _dbSet.AddAsync(entity);
        }

        //Generic function to update an instance
        public void Update(T entity)
        {
            _dbSet.Update(entity);
        }

        //Generic function to delete an instance
        public void Delete(T entity)
        {
            _dbSet.Remove(entity);
        }

        //Generic function to save changes in the database
        public async Task SaveAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}