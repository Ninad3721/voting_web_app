using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Moq;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Application.Response;

namespace VotingApplication.Api.Controllers.Tests
{
    public class VoterControllerTests
    {
        private readonly Mock<IVoterService> _mockVoterService;
        private readonly VoterController _controller;

        public VoterControllerTests()
        {
            _mockVoterService = new Mock<IVoterService>();
            _controller = new VoterController(_mockVoterService.Object);
        }

        // Test for AddVoter with invalid model state
        [Fact]
        public async Task AddVoter_InvalidModelState_ReturnsBadRequest()
        {
            // Arrange
            var createVoterDto = new CreateVoterDto();
            _controller.ModelState.AddModelError("Name", "Required");

            // Act
            var result = await _controller.AddVoter(createVoterDto);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<ModelStateDictionary>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
        }

        // Test for AddVoter with valid data
        [Fact]
        public async Task AddVoter_ValidData_ReturnsOk()
        {
            // Arrange
            var createVoterDto = new CreateVoterDto { Name = "John Doe" };
            var voterResponse = new VoterResponseDto { VoterId = 1, Name = "John Doe" };
            _mockVoterService.Setup(x => x.AddVoter(createVoterDto)).ReturnsAsync(voterResponse);

            // Act
            var result = await _controller.AddVoter(createVoterDto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<VoterResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Voter registered successfully", apiResponse.Message);
        }

        // Test for GetVoterById with invalid ID
        [Fact]
        public async Task GetVoterById_InvalidId_ReturnsBadRequest()
        {
            // Act
            var result = await _controller.GetVoterById(-1);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for GetVoterById with valid ID
        [Fact]
        public async Task GetVoterById_ValidId_ReturnsOk()
        {
            // Arrange
            long voterId = 1;
            var voterResponse = new VoterResponseDto { VoterId = voterId, Name = "John Doe" };
            _mockVoterService.Setup(x => x.GetVoter(voterId)).ReturnsAsync(voterResponse);

            // Act
            var result = await _controller.GetVoterById(voterId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<VoterResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Voter recieved successfully", apiResponse.Message);
        }

        // Test for GetAllVoter

        // Test for UpdateVoter with invalid ID
        [Fact]
        public async Task UpdateVoter_InvalidId_ReturnsBadRequest()
        {
            // Arrange
            long voterId = -1;
            var voterUpdateDto = new VoterUpdateDto { Name = "Updated Name" };

            // Act
            var result = await _controller.UpdateVoter(voterUpdateDto, voterId);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
        }
    }
}