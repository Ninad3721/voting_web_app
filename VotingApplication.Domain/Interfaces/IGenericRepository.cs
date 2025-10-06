namespace VotingApplication.Domain.Interfaces
{
    //Generic repository for all the basic operations
    public interface IGenericRepository<T> where T : class
    {
        //Generic method for Creating instance
        Task CreateAsync(T entity);

        //Generic method for Reading row
        Task<T?> GetByIdAsync(long id);

        //Generic method for Reading All
        Task<IEnumerable<T>> GetAllAsync(int pageNumber, int pageSize, bool fetchAll);

        //Generic method for Updating
        void Update(T entity);

        //Generic method for  Deleting
        void Delete(T entity);

        //Generic for saving changes in the db
        Task SaveAsync();
    }
}