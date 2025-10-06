using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Application.Response;

namespace VotingApplication.Api.Controllers
{
    public class LoginController : Controller
    {
        private readonly ILoginService _loginService;

        public LoginController(ILoginService loginService)
        {
            _loginService = loginService;
        }

        [AllowAnonymous]
        [HttpPost("/login")]
        public async Task<IActionResult> login([FromBody] LoginDto loginDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary>(
                    StatusCodes.Status400BadRequest,
                    new ModelStateDictionary(),
                    ModelState,
                    "One or more fields were faild validation"));
            }

            var loginResponse = await _loginService.Login(loginDto);
            return Ok(new ApiResponse<LoginResponseDto?>(
                StatusCodes.Status200OK,
                    loginResponse,
                    null,
                    "User logged in successfully"
                ));
        }

        [HttpPost("/generateJwtFromRefreshToken")]
        public async Task<IActionResult> generateJwtFromRefreshToken([FromBody] RefreshTokenDto refreshTokenDto)
        {
            var res = await _loginService.GenerateJwtFromRefreshToken(refreshTokenDto.RefreshToken);
            return Ok(new ApiResponse<LoginResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
               "User logged in successfully"
               ));
        }
    }
}