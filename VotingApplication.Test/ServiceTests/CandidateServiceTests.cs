using Moq;
using Xunit;
using AutoMapper;
using VotingApplication.Application.Services;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Domain.Entity;
using VotingApplication.Domain.Context;
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Linq;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Application.Tests.ServiceTests
{
    public class CandidateServiceTests
    {
        private readonly Mock<IGenericRepository<Candidate>> _mockCandidateRepository;
        private readonly Mock<IMapper> _mockMapper;
        private readonly Mock<ApplicationContext> _mockContext;
        private readonly CandidateService _candidateService;

        public CandidateServiceTests()
        {
            _mockCandidateRepository = new Mock<IGenericRepository<Candidate>>();
            _mockMapper = new Mock<IMapper>();
            _mockContext = new Mock<ApplicationContext>(new DbContextOptions<ApplicationContext>());

            _candidateService = new CandidateService(
                _mockCandidateRepository.Object,
                _mockMapper.Object,
                _mockContext.Object);
        }

        // Test for AddCandidate
        [Fact]
        public async Task AddCandidate_ValidData_ReturnsCandidateResponseDto()
        {
            // Arrange
            var createCandidateDto = new CreateCandidateDto { Name = "Test Candidate", Password = "password123" };
            var mappedCandidate = new Candidate { Name = "Test Candidate", Password = "hashedPassword", IsDeleted = false, TotalVotes = 0 };
            var candidateResponseDto = new CandidateResponseDto { Name = "Test Candidate" };

            _mockMapper.Setup(x => x.Map<Candidate>(createCandidateDto)).Returns(mappedCandidate);
            _mockMapper.Setup(x => x.Map<CandidateResponseDto>(mappedCandidate)).Returns(candidateResponseDto);
            _mockCandidateRepository.Setup(x => x.CreateAsync(mappedCandidate)).Returns(Task.CompletedTask);
            _mockCandidateRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _candidateService.AddCandidate(createCandidateDto);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Test Candidate", result.Name);
            _mockCandidateRepository.Verify(x => x.CreateAsync(It.IsAny<Candidate>()), Times.Once());
            _mockCandidateRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for DeleteCandidate when candidate not found
        [Fact]
        public async Task DeleteCandidate_InvalidCandidateId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long candidateId = 1;
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync((Candidate)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _candidateService.DeleteCandidate(candidateId));
            Assert.Equal("No candidate found with given Id", exception.Message);
        }

        // Test for DeleteCandidate when candidate is already deleted
        [Fact]
        public async Task DeleteCandidate_DeletedCandidate_ThrowsKeyNotFoundException()
        {
            // Arrange
            long candidateId = 1;
            var deletedCandidate = new Candidate { IsDeleted = true };
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(deletedCandidate);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _candidateService.DeleteCandidate(candidateId));
            Assert.Equal("Candidate with given id is deleted", exception.Message);
        }

        // Test for DeleteCandidate when candidate has votes
        [Fact]
        public async Task DeleteCandidate_CandidateHasVotes_ThrowsInvalidOperationException()
        {
            // Arrange
            long candidateId = 1;
            var candidate = new Candidate { IsDeleted = false, TotalVotes = 1 };
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(candidate);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _candidateService.DeleteCandidate(candidateId));
            Assert.Equal("Candidate has already been voted once", exception.Message);
        }

        // Test for DeleteCandidate with valid candidate
        [Fact]
        public async Task DeleteCandidate_ValidCandidate_ReturnsCandidateResponseDto()
        {
            // Arrange
            long candidateId = 1;
            var candidate = new Candidate { CandidateId = candidateId, IsDeleted = false, TotalVotes = 0 };
            var candidateResponseDto = new CandidateResponseDto { CandidateId = candidateId };

            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(candidate);
            _mockMapper.Setup(x => x.Map<CandidateResponseDto>(candidate)).Returns(candidateResponseDto);
            _mockCandidateRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _candidateService.DeleteCandidate(candidateId);

            // Assert
            Assert.NotNull(result);
            Assert.True(candidate.IsDeleted); // Ensure candidate is marked as deleted
            _mockCandidateRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for GetCandidate when candidate not found
        [Fact]
        public async Task GetCandidate_InvalidCandidateId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long candidateId = 1;
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync((Candidate)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _candidateService.GetCandidate(candidateId));
            Assert.Equal("No candiate found with given Id", exception.Message);
        }

        // Test for GetCandidate when candidate is deleted
        [Fact]
        public async Task GetCandidate_DeletedCandidate_ThrowsKeyNotFoundException()
        {
            // Arrange
            long candidateId = 1;
            var deletedCandidate = new Candidate { IsDeleted = true };
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(deletedCandidate);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _candidateService.GetCandidate(candidateId));
            Assert.Equal("Candidate with given id is deleted", exception.Message);
        }

        // Test for GetCandidate with valid candidate
        [Fact]
        public async Task GetCandidate_ValidCandidateId_ReturnsCandidateResponseDto()
        {
            // Arrange
            long candidateId = 1;
            var candidate = new Candidate { CandidateId = candidateId, Name = "Test Candidate", IsDeleted = false };
            var candidateResponseDto = new CandidateResponseDto { CandidateId = candidateId, Name = "Test Candidate" };

            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(candidate);
            _mockMapper.Setup(x => x.Map<CandidateResponseDto>(candidate)).Returns(candidateResponseDto);

            // Act
            var result = await _candidateService.GetCandidate(candidateId);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("Test Candidate", result.Name);
        }

        // Test for UpdateCandidate when candidate not found
        [Fact]
        public async Task UpdateCandidate_InvalidCandidateId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long candidateId = -1;
            var candidateUpdateDto = new CandidateUpdateDto { Name = "Updated Candidate" };

            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync((Candidate)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _candidateService.UpdateCandidate(candidateUpdateDto, candidateId));
            Assert.Equal("No user found with given Id", exception.Message);
        }

        // Test for UpdateCandidate when candidate is deleted
        [Fact]
        public async Task UpdateCandidate_DeletedCandidate_ThrowsKeyNotFoundException()
        {
            // Arrange
            long candidateId = 1;
            var deletedCandidate = new Candidate { IsDeleted = true };
            var candidateUpdateDto = new CandidateUpdateDto { Name = "Updated Candidate" };

            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(deletedCandidate);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _candidateService.UpdateCandidate(candidateUpdateDto, candidateId));
            Assert.Equal("Candidate with given id is deleted", exception.Message);
        }

        // Test for UpdateCandidate with no changes
        [Fact]
        public async Task UpdateCandidate_NoChanges_ThrowsInvalidOperationException()
        {
            // Arrange
            long candidateId = 1;
            var candidate = new Candidate { CandidateId = candidateId, Name = "Test", DOB = DateOnly.FromDateTime(DateTime.Now), Gender = "M", PartyName = "Party", IsDeleted = false };
            var candidateUpdateDto = new CandidateUpdateDto { Name = "Test", DOB = DateOnly.FromDateTime(DateTime.Now), Gender = "M", PartyName = "Party" };

            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(candidate);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _candidateService.UpdateCandidate(candidateUpdateDto, candidateId));
            Assert.Equal("No changes were done in the new instance", exception.Message);
        }

        // Test for UpdateCandidate with valid changes
        [Fact]
        public async Task UpdateCandidate_ValidChanges_ReturnsCandidateResponseDto()
        {
            // Arrange
            long candidateId = 1;
            var candidate = new Candidate { CandidateId = candidateId, Name = "Old Name", DOB = DateOnly.FromDateTime(DateTime.Now), Gender = "M", PartyName = "Old Party", IsDeleted = false };
            var candidateUpdateDto = new CandidateUpdateDto { Name = "New Name", DOB = DateOnly.FromDateTime(DateTime.Now).AddYears(1), Gender = "F", PartyName = "New Party" };
            var updatedCandidate = new Candidate { CandidateId = candidateId, Name = "New Name", DOB = DateOnly.FromDateTime(DateTime.Now).AddYears(1), Gender = "F", PartyName = "New Party", DateUpdated = DateTimeOffset.Now };
            var candidateResponseDto = new CandidateResponseDto { CandidateId = candidateId, Name = "New Name" };

            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(candidate);
            _mockMapper.Setup(x => x.Map<CandidateResponseDto>(candidateUpdateDto)).Returns(candidateResponseDto);
            _mockCandidateRepository.Setup(x => x.Update(candidate)).Verifiable();
            _mockCandidateRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _candidateService.UpdateCandidate(candidateUpdateDto, candidateId);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("New Name", result.Name);
            _mockCandidateRepository.Verify(x => x.Update(It.IsAny<Candidate>()), Times.Once());
            _mockCandidateRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for GetAllCandidate
        [Fact]
        public async Task GetAllCandidate_ValidParams_ReturnsCandidateList()
        {
            // Arrange
            int pageNumber = 1, pageSize = 10;
            bool fetchAll = false;
            var candidates = new List<Candidate> { new Candidate { CandidateId = 1, Name = "Test Candidate" } };
            _mockCandidateRepository.Setup(x => x.GetAllAsync(pageNumber, pageSize, fetchAll)).ReturnsAsync(candidates);

            // Act
            var result = await _candidateService.GetAllCandidate(pageNumber, pageSize, fetchAll);

            // Assert
            Assert.NotNull(result);
            Assert.Single(result);
            Assert.Equal("Test Candidate", result.First().Name);
        }

        // Test for SearchByCandidateName with null input
        [Fact]
        public async Task SearchByCandidateName_NullInput_ThrowsInvalidOperationException()
        {
            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _candidateService.SearchByCandidateName(null));
            Assert.Equal("Search cannot be null", exception.Message);
        }
    }
}