using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Moq;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Application.Response;

namespace VotingApplication.Api.Controllers.Tests
{
    public class LoginControllerTests
    {
        private readonly Mock<ILoginService> _mockLoginService;
        private readonly LoginController _controller;

        public LoginControllerTests()
        {
            _mockLoginService = new Mock<ILoginService>();
            _controller = new LoginController(_mockLoginService.Object);
        }

        // Test for login with invalid model state
        [Fact]
        public async Task Login_InvalidModelState_ReturnsBadRequest()
        {
            // Arrange
            var loginDto = new LoginDto();
            _controller.ModelState.AddModelError("Email", "Required");

            // Act
            var result = await _controller.login(loginDto);

            // Assert
            var badRequestResult = Assert.IsType<BadRequestObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<ModelStateDictionary>>(badRequestResult.Value);
            Assert.Equal(StatusCodes.Status400BadRequest, apiResponse.StatusCode);
            Assert.Equal("One or more fields were faild validation", apiResponse.Message);
        }

        // Test for login with valid model state
        [Fact]
        public async Task Login_ValidModelState_ReturnsOkWithToken()
        {
            // Arrange
            var loginDto = new LoginDto { Email = "user@example.com", Password = "password123", Role = "Admin" };
            var loginResponseDto = new LoginResponseDto { JwtToken = "asdf", RefreshToken = "abcd" };
            var token = "asdf";
            _mockLoginService.Setup(x => x.Login(loginDto)).ReturnsAsync(loginResponseDto);

            // Act
            var result = await _controller.login(loginDto);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var apiResponse = Assert.IsType<ApiResponse<LoginResponseDto>>(okResult.Value);
            Assert.Equal(StatusCodes.Status200OK, apiResponse.StatusCode);
            Assert.Equal(token, loginResponseDto.JwtToken);
        }
    }
}