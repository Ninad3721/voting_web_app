using System.Data;
using AutoMapper;
using Moq;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Services;
using VotingApplication.Domain.Entity;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Application.Tests.ServiceTests
{
    public class AdminServiceTests
    {
        private readonly Mock<IGenericRepository<Admin>> _mockAdminRepository;
        private readonly Mock<IMapper> _mockMapper;
        private readonly AdminService _adminService;

        public AdminServiceTests()
        {
            _mockAdminRepository = new Mock<IGenericRepository<Admin>>();
            _mockMapper = new Mock<IMapper>();
            _adminService = new AdminService(_mockAdminRepository.Object, _mockMapper.Object);
        }

        // Test for AddAdmin when email already exists
        [Fact]
        public async Task AddAdmin_EmailExists_ThrowsDuplicateNameException()
        {
            // Arrange
            var createAdminDto = new CreateAdminDto { Email = "existing@email.com", Password = "password123" };
            var existingAdmin = new Admin { Email = "existing@email.com", IsDeleted = false };
            var adminList = new List<Admin> { existingAdmin };
            _mockAdminRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(adminList);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<DuplicateNameException>(() => _adminService.AddAdmin(createAdminDto));
            Assert.Equal("Email already exist in the database", exception.Message);
        }

        // Test for AddAdmin with new email
        [Fact]
        public async Task AddAdmin_NewEmail_ReturnsAdminResponseDto()
        {
            // Arrange
            var createAdminDto = new CreateAdminDto { Email = "new@email.com", Password = "password123" };
            var adminList = new List<Admin>();
            _mockAdminRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(adminList);

            var mappedAdmin = new Admin { Email = "new@email.com", Password = "hashedPassword" };
            var adminResponseDto = new AdminResponseDto { Email = "new@email.com" };

            _mockMapper.Setup(x => x.Map<Admin>(createAdminDto)).Returns(mappedAdmin);
            _mockMapper.Setup(x => x.Map<AdminResponseDto>(mappedAdmin)).Returns(adminResponseDto);
            _mockAdminRepository.Setup(x => x.CreateAsync(mappedAdmin)).Returns(Task.CompletedTask);
            _mockAdminRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _adminService.AddAdmin(createAdminDto);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("new@email.com", result.Email);
            _mockAdminRepository.Verify(x => x.CreateAsync(It.IsAny<Admin>()), Times.Once());
            _mockAdminRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for GetAdminById when admin not found
        [Fact]
        public async Task GetAdminById_InvalidId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long adminId = 1;
            _mockAdminRepository.Setup(x => x.GetByIdAsync(adminId)).ReturnsAsync((Admin)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _adminService.GetAdminById(adminId));
            Assert.Equal("No Admin found with given Id", exception.Message);
        }

        // Test for GetAdminById when admin is deleted
        [Fact]
        public async Task GetAdminById_DeletedAdmin_ThrowsKeyNotFoundException()
        {
            // Arrange
            long adminId = 1;
            var deletedAdmin = new Admin { IsDeleted = true };
            _mockAdminRepository.Setup(x => x.GetByIdAsync(adminId)).ReturnsAsync(deletedAdmin);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _adminService.GetAdminById(adminId));
            Assert.Equal("Admin with given id is deleted", exception.Message);
        }

        // Test for GetAdminById with valid admin
        [Fact]
        public async Task GetAdminById_ValidId_ReturnsAdminResponseDto()
        {
            // Arrange
            long adminId = 1;
            var admin = new Admin { AdminId = adminId, Email = "test@email.com", IsDeleted = false };
            var adminResponseDto = new AdminResponseDto { Email = "test@email.com" };

            _mockAdminRepository.Setup(x => x.GetByIdAsync(adminId)).ReturnsAsync(admin);
            _mockMapper.Setup(x => x.Map<AdminResponseDto>(admin)).Returns(adminResponseDto);

            // Act
            var result = await _adminService.GetAdminById(adminId);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("test@email.com", result.Email);
        }

        // Test for GetAllAdmin
        [Fact]
        public async Task GetAllAdmin_ValidParams_ReturnsAdminList()
        {
            // Arrange
            int pageNumber = 1, pageSize = 10;
            var admins = new List<Admin> { new Admin { AdminId = 1, Email = "test1@email.com" }, new Admin { AdminId = 2, Email = "test2@email.com" } };
            _mockAdminRepository.Setup(x => x.GetAllAsync(pageNumber, pageSize, false)).ReturnsAsync(admins);

            // Act
            var result = await _adminService.GetAllAdmin(pageNumber, pageSize, false);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(2, result.Count());
            Assert.Contains(result, a => a.Email == "test1@email.com");
            Assert.Contains(result, a => a.Email == "test2@email.com");
        }
    }
}