using Microsoft.AspNetCore.Http;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;

using Moq;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Application.Response;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Api.Controllers.Tests
{
    public class CandidateControllerTests
    {
        private readonly Mock<ICandidateService> _mockCandidateService;
        private readonly CandidateController _controller;

        public CandidateControllerTests()
        {
            _mockCandidateService = new Mock<ICandidateService>();
            _controller = new CandidateController(_mockCandidateService.Object);
        }

        // Test for AddCandidate with invalid model state
        [Fact]
        public async Task AddCandidate_InvalidModelState_ReturnsBadRequest()
        {
            // Arrange
            var createCandidateDto = new CreateCandidateDto();
            _controller.ModelState.AddModelError("Name", "Required");

            // Act
            var result = await _controller.AddCandidate(createCandidateDto);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<ModelStateDictionary?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("One or more fields do not pass validation", apiResponse.Message);
        }

        // Test for AddCandidate with valid data
        [Fact]
        public async Task AddCandidate_ValidData_ReturnsOk()
        {
            // Arrange
            var createCandidateDto = new CreateCandidateDto { Name = "Test Candidate" };
            var candidateResponse = new CandidateResponseDto { CandidateId = 1, Name = "Test Candidate" };
            _mockCandidateService.Setup(x => x.AddCandidate(createCandidateDto)).ReturnsAsync(candidateResponse);

            // Act
            var result = await _controller.AddCandidate(createCandidateDto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<CandidateResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Candidate created successfully", apiResponse.Message);
        }

        // Test for GetCandidateById with invalid CandidateId
        [Fact]
        public async Task GetCandidateById_InvalidCandidateId_ReturnsBadRequest()
        {
            // Act
            var result = await _controller.GetCandidateById(-1);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for GetCandidateById with valid CandidateId
        [Fact]
        public async Task GetCandidateById_ValidCandidateId_ReturnsOk()
        {
            // Arrange
            long candidateId = 1;
            var candidateResponse = new CandidateResponseDto { CandidateId = candidateId, Name = "Test Candidate" };
            _mockCandidateService.Setup(x => x.GetCandidate(candidateId)).ReturnsAsync(candidateResponse);

            // Act
            var result = await _controller.GetCandidateById(candidateId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<CandidateResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Candidate fetched successfully", apiResponse.Message);
        }

        // Test for GetAllCandidate with invalid page parameters
        [Fact]
        public async Task GetAllCandidate_InvalidPageParams_ReturnsBadRequest()
        {
            // Act
            var result = await _controller.GetAllCandidate(-1, -1);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Page number or page size not valid", apiResponse.Error);
        }

        // Test for GetAllCandidate with valid page parameters
        [Fact]
        public async Task GetAllCandidate_ValidPageParams_ReturnsOk()
        {
            // Arrange
            int pageNumber = 1, pageSize = 10;
            var candidates = new List<Candidate> { new Candidate { CandidateId = 1, Name = "Test Candidate" } };
            _mockCandidateService.Setup(x => x.GetAllCandidate(pageNumber, pageSize, false)).ReturnsAsync(candidates);

            // Act
            var result = await _controller.GetAllCandidate(pageNumber, pageSize);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<IEnumerable<Candidate>?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("All candidates fetched", apiResponse.Message);
        }

        // Test for UpdateCandidate with invalid CandidateId
        [Fact]
        public async Task UpdateCandidate_InvalidCandidateId_ReturnsBadRequest()
        {
            // Arrange
            long candidateId = -1;
            var candidateUpdateDto = new CandidateUpdateDto { Name = "Updated Candidate" };

            // Act
            var result = await _controller.UpdateCandidate(candidateUpdateDto, candidateId);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for DeleteCandidate with invalid CandidateId
        [Fact]
        public async Task DeleteCandidate_InvalidCandidateId_ReturnsBadRequest()
        {
            // Act
            var result = await _controller.DeleteCandiate(-1);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for GetTopThreeCandidates
        [Fact]
        public async Task GetTopThreeCandidates_ValidRequest_ReturnsOk()
        {
            // Arrange
            var topCandidates = new List<Candidate>
            {
                new Candidate { CandidateId = 1, Name = "Candidate 1" },
                new Candidate { CandidateId = 2, Name = "Candidate 2" }
            };
            _mockCandidateService.Setup(x => x.GeetTopThreeCandidates()).ReturnsAsync(topCandidates);

            // Act
            var result = await _controller.GetTopThreeCandidates();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<IEnumerable<Candidate>?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Top three Candidate fetched successfully", apiResponse.Message);
        }

        // Test for SearchByCandidateName
        [Fact]
        public async Task SearchByCandidateName_ValidName_ReturnsOk()
        {
            // Arrange
            string candidateName = "Test";
            var candidates = new List<Candidate> { new Candidate { CandidateId = 1, Name = "Test Candidate" } };
            _mockCandidateService.Setup(x => x.SearchByCandidateName(candidateName)).ReturnsAsync(candidates);

            // Act
            var result = await _controller.SearchByCandidateName(candidateName);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<IEnumerable<Candidate>?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Candidate fetched successfully", apiResponse.Message);
        }
    }
}