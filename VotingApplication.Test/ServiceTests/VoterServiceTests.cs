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
using System.Data;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Application.Tests.ServiceTests
{
    public class VoterServiceTests
    {
        private readonly Mock<IGenericRepository<Voter>> _mockVoterRepository;
        private readonly Mock<IGenericRepository<Candidate>> _mockCandidateRepository;
        private readonly Mock<IMapper> _mockMapper;
        private readonly Mock<ApplicationContext> _mockContext;
        private readonly VoterService _voterService;

        public VoterServiceTests()
        {
            _mockVoterRepository = new Mock<IGenericRepository<Voter>>();
            _mockCandidateRepository = new Mock<IGenericRepository<Candidate>>();
            _mockMapper = new Mock<IMapper>();
            _mockContext = new Mock<ApplicationContext>(new DbContextOptions<ApplicationContext>());

            _voterService = new VoterService(
                _mockVoterRepository.Object,
                _mockMapper.Object,
                _mockCandidateRepository.Object,
                _mockContext.Object);
        }

        // Test for AddVoter when email already exists
        [Fact]
        public async Task AddVoter_EmailExists_ThrowsDuplicateNameException()
        {
            // Arrange
            var createVoterDto = new CreateVoterDto { Email = "existing@email.com", Password = "password123" };
            var existingVoter = new Voter { Email = "existing@email.com", IsDeleted = false };
            var voterList = new List<Voter> { existingVoter };
            _mockVoterRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(voterList);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<DuplicateNameException>(() => _voterService.AddVoter(createVoterDto));
            Assert.Equal("Email already exist in the database", exception.Message);
        }

        // Test for AddVoter with new email
        [Fact]
        public async Task AddVoter_NewEmail_ReturnsVoterResponseDto()
        {
            // Arrange
            var createVoterDto = new CreateVoterDto { Email = "new@email.com", Password = "password123" };
            var voterList = new List<Voter>();
            _mockVoterRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(voterList);

            var mappedVoter = new Voter { Email = "new@email.com", Password = "hashedPassword", IsDeleted = false };
            var voterResponseDto = new VoterResponseDto { Email = "new@email.com" };

            _mockMapper.Setup(x => x.Map<Voter>(createVoterDto)).Returns(mappedVoter);
            _mockMapper.Setup(x => x.Map<VoterResponseDto>(mappedVoter)).Returns(voterResponseDto);
            _mockVoterRepository.Setup(x => x.CreateAsync(mappedVoter)).Returns(Task.CompletedTask);
            _mockVoterRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _voterService.AddVoter(createVoterDto);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("new@email.com", result.Email);
            _mockVoterRepository.Verify(x => x.CreateAsync(It.IsAny<Voter>()), Times.Once());
            _mockVoterRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for DeleteVoter when voter not found
        [Fact]
        public async Task DeleteVoter_InvalidVoterId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1;
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync((Voter)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.DeleteVoter(voterId));
            Assert.Equal("No voter found with given Id", exception.Message);
        }

        // Test for DeleteVoter when voter is already deleted
        [Fact]
        public async Task DeleteVoter_DeletedVoter_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1;
            var deletedVoter = new Voter { IsDeleted = true };
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(deletedVoter);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.DeleteVoter(voterId));
            Assert.Equal("Voter with given id is deleted", exception.Message);
        }

        // Test for DeleteVoter when voter has already voted
        [Fact]
        public async Task DeleteVoter_VoterAlreadyVoted_ThrowsInvalidOperationException()
        {
            // Arrange
            long voterId = 1;
            var voter = new Voter { IsDeleted = false, HasVoted = true };
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _voterService.DeleteVoter(voterId));
            Assert.Equal("Voter has already been voted once", exception.Message);
        }

        // Test for DeleteVoter with valid voter
        [Fact]
        public async Task DeleteVoter_ValidVoter_ReturnsVoterResponseDto()
        {
            // Arrange
            long voterId = 1;
            var voter = new Voter { VoterId = voterId, IsDeleted = false, HasVoted = false };
            var voterResponseDto = new VoterResponseDto { VoterId = voterId };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockMapper.Setup(x => x.Map<VoterResponseDto>(voter)).Returns(voterResponseDto);
            _mockVoterRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _voterService.DeleteVoter(voterId);

            // Assert
            Assert.NotNull(result);
            Assert.True(voter.IsDeleted); // Ensure voter is marked as deleted
            _mockVoterRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for GetVoter when voter not found
        [Fact]
        public async Task GetVoter_InvalidVoterId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1;
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync((Voter)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.GetVoter(voterId));
            Assert.Equal("No voter found with given Id", exception.Message);
        }

        // Test for GetVoter when voter is deleted
        [Fact]
        public async Task GetVoter_DeletedVoter_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1;
            var deletedVoter = new Voter { IsDeleted = true };
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(deletedVoter);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.GetVoter(voterId));
            Assert.Equal("Voter with given id is deleted", exception.Message);
        }

        // Test for GetVoter with valid voter
        [Fact]
        public async Task GetVoter_ValidVoterId_ReturnsVoterResponseDto()
        {
            // Arrange
            long voterId = 1;
            var voter = new Voter { VoterId = voterId, Email = "test@email.com", IsDeleted = false };
            var voterResponseDto = new VoterResponseDto { VoterId = voterId, Email = "test@email.com" };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockMapper.Setup(x => x.Map<VoterResponseDto>(voter)).Returns(voterResponseDto);

            // Act
            var result = await _voterService.GetVoter(voterId);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("test@email.com", result.Email);
        }

        // Test for UpdateVoter when voter not found
        [Fact]
        public async Task UpdateVoter_InvalidVoterId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = -1;
            var voterUpdateDto = new VoterUpdateDto { Email = "updated@email.com" };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync((Voter)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.UpdateVoter(voterUpdateDto, voterId));
            Assert.Equal("No voter found with given Id", exception.Message);
        }

        // Test for UpdateVoter when voter is deleted
        [Fact]
        public async Task UpdateVoter_DeletedVoter_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1;
            var deletedVoter = new Voter { IsDeleted = true };
            var voterUpdateDto = new VoterUpdateDto { Email = "updated@email.com" };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(deletedVoter);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.UpdateVoter(voterUpdateDto, voterId));
            Assert.Equal("Voter with given id is deleted", exception.Message);
        }

        // Test for UpdateVoter with no changes
        [Fact]
        public async Task UpdateVoter_NoChanges_ThrowsInvalidOperationException()
        {
            // Arrange
            long voterId = 1;
            var voter = new Voter { VoterId = voterId, Email = "test@email.com", Name = "Test", DOB = DateOnly.FromDateTime(DateTime.Now), Gender = "M", IsDeleted = false };
            var voterUpdateDto = new VoterUpdateDto { Email = "test@email.com", Name = "Test", DOB = DateOnly.FromDateTime(DateTime.Now), Gender = "M" };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockVoterRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(new List<Voter>());

            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _voterService.UpdateVoter(voterUpdateDto, voterId));
            Assert.Equal("No changes were done in the new instance", exception.Message);
        }

        // Test for UpdateVoter with valid changes and existing email
        [Fact]
        public async Task UpdateVoter_ExistingEmail_ThrowsDuplicateNameException()
        {
            // Arrange
            long voterId = 1;
            var voter = new Voter { VoterId = voterId, Email = "old@email.com", IsDeleted = false };
            var voterUpdateDto = new VoterUpdateDto { Email = "existing@email.com" };
            var existingVoter = new Voter { Email = "existing@email.com", IsDeleted = false };
            var voterList = new List<Voter> { existingVoter };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockVoterRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(voterList);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<DuplicateNameException>(() => _voterService.UpdateVoter(voterUpdateDto, voterId));
            Assert.Equal("Updated Email already exist in the database", exception.Message);
        }

        // Test for UpdateVoter with valid changes
        [Fact]
        public async Task UpdateVoter_ValidChanges_ReturnsVoterResponseDto()
        {
            // Arrange
            long voterId = 1;
            var voter = new Voter { VoterId = voterId, Email = "old@email.com", Name = "Old Name", IsDeleted = false };
            var voterUpdateDto = new VoterUpdateDto { Email = "new@email.com", Name = "New Name" };
            var updatedVoter = new Voter { VoterId = voterId, Email = "new@email.com", Name = "New Name", DateUpdated = DateTimeOffset.Now };
            var voterResponseDto = new VoterResponseDto { VoterId = voterId, Email = "new@email.com", Name = "New Name" };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockVoterRepository.Setup(x => x.GetAllAsync(0, 0, true)).ReturnsAsync(new List<Voter>());
            _mockMapper.Setup(x => x.Map<VoterResponseDto>(voterUpdateDto)).Returns(voterResponseDto);
            _mockVoterRepository.Setup(x => x.Update(voter)).Verifiable();
            _mockVoterRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _voterService.UpdateVoter(voterUpdateDto, voterId);

            // Assert
            Assert.NotNull(result);
            Assert.Equal("new@email.com", result.Email);
            Assert.Equal("New Name", result.Name); // Adjust based on your DTO mapping
            _mockVoterRepository.Verify(x => x.Update(It.IsAny<Voter>()), Times.Once());
            _mockVoterRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for VoteToCandidate when voter not found
        [Fact]
        public async Task VoteToCandidate_InvalidVoterId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = -1, candidateId = 1;
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync((Voter)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.VoteToCandidate(candidateId, voterId));
            Assert.Equal("No voter found with given Id", exception.Message);
        }

        // Test for VoteToCandidate when voter is deleted
        [Fact]
        public async Task VoteToCandidate_DeletedVoter_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1, candidateId = 1;
            var deletedVoter = new Voter { IsDeleted = true };
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(deletedVoter);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.VoteToCandidate(candidateId, voterId));
            Assert.Equal("Voter with given id is deleted", exception.Message);
        }

        // Test for VoteToCandidate when voter already voted
        [Fact]
        public async Task VoteToCandidate_VoterAlreadyVoted_ThrowsInvalidOperationException()
        {
            // Arrange
            long voterId = 1, candidateId = 1;
            var voter = new Voter { HasVoted = true, IsDeleted = false };
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _voterService.VoteToCandidate(candidateId, voterId));
            Assert.Equal("Voter has already been voted once", exception.Message);
        }

        // Test for VoteToCandidate when candidate not found
        [Fact]
        public async Task VoteToCandidate_InvalidCandidateId_ThrowsKeyNotFoundException()
        {
            // Arrange
            long voterId = 1, candidateId = -1;
            var voter = new Voter { HasVoted = false, IsDeleted = false };
            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync((Candidate)null);

            // Act & Assert
            var exception = await Assert.ThrowsAsync<KeyNotFoundException>(() => _voterService.VoteToCandidate(candidateId, voterId));
            Assert.Equal("No candidate found with given Id", exception.Message);
        }

        // Test for VoteToCandidate with valid data
        [Fact]
        public async Task VoteToCandidate_ValidData_ReturnsVoterResponseDto()
        {
            // Arrange
            long voterId = 1, candidateId = 1;
            var voter = new Voter { VoterId = voterId, HasVoted = false, IsDeleted = false };
            var candidate = new Candidate { CandidateId = candidateId, TotalVotes = 0, IsDeleted = false };
            var voterResponseDto = new VoterResponseDto { VoterId = voterId };

            _mockVoterRepository.Setup(x => x.GetByIdAsync(voterId)).ReturnsAsync(voter);
            _mockCandidateRepository.Setup(x => x.GetByIdAsync(candidateId)).ReturnsAsync(candidate);
            _mockMapper.Setup(x => x.Map<VoterResponseDto>(voter)).Returns(voterResponseDto);
            _mockVoterRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);
            _mockCandidateRepository.Setup(x => x.SaveAsync()).Returns(Task.CompletedTask);

            // Act
            var result = await _voterService.VoteToCandidate(candidateId, voterId);

            // Assert
            Assert.NotNull(result);
            Assert.True(voter.HasVoted); // Ensure voter is marked as voted
            Assert.Equal(1, candidate.TotalVotes); // Ensure candidate vote count increased
            _mockVoterRepository.Verify(x => x.SaveAsync(), Times.Once());
            _mockCandidateRepository.Verify(x => x.SaveAsync(), Times.Once());
        }

        // Test for GetAllVoters
        [Fact]
        public async Task GetAllVoters_ValidParams_ReturnsVoterList()
        {
            // Arrange
            int pageNumber = 1, pageSize = 10;
            bool fetchAll = false;
            var voters = new List<Voter> { new Voter { VoterId = 1, Email = "test1@email.com" } };
            _mockVoterRepository.Setup(x => x.GetAllAsync(pageNumber, pageSize, fetchAll)).ReturnsAsync(voters);

            // Act
            var result = await _voterService.GetAllVoters(pageNumber, pageSize, fetchAll);

            // Assert
            Assert.NotNull(result);
            Assert.Single(result);
            Assert.Equal("test1@email.com", result.First().Email);
        }

        // Test for SearchVoterByName with null input
        [Fact]
        public async Task SearchVoterByName_NullInput_ThrowsInvalidOperationException()
        {
            // Act & Assert
            var exception = await Assert.ThrowsAsync<InvalidOperationException>(() => _voterService.SearchVoterByName(null));
            Assert.Equal("Search cannot be null", exception.Message);
        }

        //Test for SearchVoterByName with valid input(assuming SQL query works)
    }
}