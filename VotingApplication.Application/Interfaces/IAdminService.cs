using VotingApplication.Application.DTO;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Application.Interfaces
{
    public interface IAdminService
    {
        public Task<AdminResponseDto> AddAdmin(CreateAdminDto createAdminDto);

        public Task<IEnumerable<Admin>> GetAllAdmin(int pageNumber, int pageSize, bool fetchAll);

        public Task<AdminResponseDto> GetAdminById(long AdminId);
    }
}