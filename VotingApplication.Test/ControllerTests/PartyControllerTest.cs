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
    public class PartyControllerTests
    {
        private readonly Mock<IPartyService> _mockPartyService;
        private readonly PartyController _controller;

        public PartyControllerTests()
        {
            _mockPartyService = new Mock<IPartyService>();
            _controller = new PartyController(_mockPartyService.Object);
        }

        // Test for AddParty with invalid model state
        [Fact]
        public async Task AddParty_InvalidModelState_ReturnsBadRequest()
        {
            // Arrange
            var createPartyDto = new CreatePartyDto();
            _controller.ModelState.AddModelError("PartyName", "Required");

            // Act
            var result = await _controller.AddParty(createPartyDto);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<ModelStateDictionary>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("One or more fields were faild validation", apiResponse.Message);
        }

        // Test for AddParty with valid data
        [Fact]
        public async Task AddParty_ValidData_ReturnsOk()
        {
            // Arrange
            var createPartyDto = new CreatePartyDto { PartyName = "Test Party" };
            var partyResponse = new PartyResponseDto { PartyId = 1, PartyName = "Test Party" };
            _mockPartyService.Setup(x => x.AddParty(createPartyDto)).ReturnsAsync(partyResponse);

            // Act
            var result = await _controller.AddParty(createPartyDto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<PartyResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Party registered successfully", apiResponse.Message);
        }

        // Test for GetPartyById with invalid partyId
        [Fact]
        public async Task GetPartyById_InvalidPartyId_ReturnsBadRequest()
        {
            // Act
            var result = await _controller.GetPartyById(-1);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for GetPartyById with valid partyId
        [Fact]
        public async Task GetPartyById_ValidPartyId_ReturnsOk()
        {
            // Arrange
            long partyId = 1;
            var partyResponse = new PartyResponseDto { PartyId = partyId, PartyName = "Test Party" };
            _mockPartyService.Setup(x => x.GetPartyById(partyId)).ReturnsAsync(partyResponse);

            // Act
            var result = await _controller.GetPartyById(partyId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<PartyResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Party recieved successfully", apiResponse.Message);
        }

        // Test for GetAllParties
        [Fact]
        public async Task GetAllParties_ValidParams_ReturnsOk()
        {
            // Arrange
            int pageNumber = 1, pageSize = 10;
            bool fetchAll = false;
            var parties = new List<Party> { new Party { PartyId = 1, PartyName = "Party 1" } };
            _mockPartyService.Setup(x => x.GetAllParties(pageNumber, pageSize, fetchAll)).ReturnsAsync(parties);

            // Act
            var result = await _controller.GetAllParty(pageNumber, pageSize, fetchAll);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<IEnumerable<Party>?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("All party recieved succesfully", apiResponse.Message);
        }

        // Test for DeleteParty with invalid partyId
        [Fact]
        public async Task DeleteParty_InvalidPartyId_ReturnsBadRequest()
        {
            // Act
            var result = await _controller.DeleteParty(-1);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for DeleteParty with valid partyId
        [Fact]
        public async Task DeleteParty_ValidPartyId_ReturnsOk()
        {
            // Arrange
            long partyId = 1;
            var partyResponse = new PartyResponseDto { PartyId = partyId, PartyName = "Test Party" };
            _mockPartyService.Setup(x => x.DeleteParty(partyId)).ReturnsAsync(partyResponse);

            // Act
            var result = await _controller.DeleteParty(partyId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<PartyResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Party deleted successfully", apiResponse.Message);
        }

        // Test for UpdateParty with invalid partyId
        [Fact]
        public async Task UpdateParty_InvalidPartyId_ReturnsBadRequest()
        {
            // Arrange
            long partyId = -1;
            var updatePartyDto = new UpdatePartyDto { PartyName = "Updated Party" };

            // Act
            var result = await _controller.UpdateCandidate(updatePartyDto, partyId);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<string?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("Invalid Id provided", apiResponse.Message);
        }

        // Test for UpdateParty with invalid model state
        [Fact]
        public async Task UpdateParty_InvalidModelState_ReturnsBadRequest()
        {
            // Arrange
            long partyId = 1;
            var updatePartyDto = new UpdatePartyDto();
            _controller.ModelState.AddModelError("PartyName", "Required");

            // Act
            var result = await _controller.UpdateCandidate(updatePartyDto, partyId);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<ModelStateDictionary?>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("One or more validation failed", apiResponse.Message);
        }

        // Test for UpdateParty with valid data
        [Fact]
        public async Task UpdateParty_ValidData_ReturnsOk()
        {
            // Arrange
            long partyId = 1;
            var updatePartyDto = new UpdatePartyDto { PartyName = "Updated Party" };
            var partyResponse = new PartyResponseDto { PartyId = partyId, PartyName = "Updated Party" };
            _mockPartyService.Setup(x => x.UpdateParty(updatePartyDto, partyId)).ReturnsAsync(partyResponse);

            // Act
            var result = await _controller.UpdateCandidate(updatePartyDto, partyId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<PartyResponseDto?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Party updated successfully", apiResponse.Message);
        }

        // Test for SearchByPartyName
        [Fact]
        public async Task SearchByPartyName_ValidName_ReturnsOk()
        {
            // Arrange
            string partyName = "Test";
            var parties = new List<Party> { new Party { PartyId = 1, PartyName = "Test Party" } };
            _mockPartyService.Setup(x => x.SearchByPartyName(partyName)).ReturnsAsync(parties);

            // Act
            var result = await _controller.SearchByPartyName(partyName);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<IEnumerable<Party>?>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal("Party fetched successfully", apiResponse.Message);
        }
    }
}