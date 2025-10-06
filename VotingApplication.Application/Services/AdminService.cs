using System.Data;
using System.Security.Cryptography;
using System.Text;
using AutoMapper;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Domain.Entity;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Application.Services
{
    public class AdminService : IAdminService
    {
        private readonly IGenericRepository<Admin> _adminRespository;
        private readonly IMapper _mapper;

        public AdminService(IGenericRepository<Admin> adminRespository, IMapper mapper)
        {
            _adminRespository = adminRespository;
            _mapper = mapper;
        }

        public async Task<AdminResponseDto> AddAdmin(CreateAdminDto createAdminDto)
        {
            //Finding if the same email exist in the database
            var adminList = await _adminRespository.GetAllAsync(0, 0, true);
            for (int i = 0; i < adminList.Count(); i++)
            {
                if (adminList.ElementAt(i).Email == createAdminDto.Email && !adminList.ElementAt(i).IsDeleted)
                {
                    throw new DuplicateNameException("Email already exist in the database");
                }
            }

            //Hashing the password before saving it
            SHA256 sha256 = SHA256.Create();
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(createAdminDto.Password));
            createAdminDto.Password = Convert.ToBase64String(hashBytes);
            var _mappedAdmin = _mapper.Map<Admin>(createAdminDto);

            await _adminRespository.CreateAsync(_mappedAdmin);
            await _adminRespository.SaveAsync();
            return _mapper.Map<AdminResponseDto>(_mappedAdmin);
        }

        public async Task<AdminResponseDto> GetAdminById(long adminId)
        {
            var admin = await _adminRespository.GetByIdAsync(adminId);
            //Admin is not found due to invalid candidate id provided
            if (admin == null)
            {
                throw new KeyNotFoundException("No Admin found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (admin.IsDeleted)
            {
                throw new KeyNotFoundException("Admin with given id is deleted");
            }
            return _mapper.Map<AdminResponseDto>(admin);
        }

        public async Task<IEnumerable<Admin>> GetAllAdmin(int pageNumber, int pageSize, bool fetchAll)
        {
            return await _adminRespository.GetAllAsync(pageNumber, pageSize, fetchAll);
        }
    }
}