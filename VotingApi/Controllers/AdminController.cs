using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Application.Response;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Api.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class AdminController : Controller
    {
        private readonly IAdminService _adminService;

        public AdminController(IAdminService adminService)
        {
            _adminService = adminService;
        }

        [HttpPost("AddAdmin")]
        public async Task<IActionResult> AddAdmin([FromBody] CreateAdminDto createAdminDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary>(
                    StatusCodes.Status400BadRequest,
                    new ModelStateDictionary(),
                    ModelState,
                    "One or more fields were faild validation"));
            }

            var res = await _adminService.AddAdmin(createAdminDto);

            return Ok(new ApiResponse<AdminResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Admin registered successfully"));
        }

        [Authorize(Roles = "Admin")]
        [HttpGet("GetAdminById")]
        public async Task<IActionResult> GetAdminId([FromQuery] long adminId)
        {
            //Checking if id is non negative
            if (adminId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }
            var res = await _adminService.GetAdminById(adminId);
            return Ok(new ApiResponse<AdminResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Admin recieved successfully"));
        }

        [Authorize(Roles = "Admin")]
        [HttpGet("GetAllAdmin/{pageNumber:int}/{pageSize:int}")]
        public async Task<IActionResult> GetAllAdmin(int pageNumber, int pageSize)
        {
            var res = await _adminService.GetAllAdmin(pageNumber, pageSize, false);
            return Ok(new ApiResponse<IEnumerable<Admin>?>
                (StatusCodes.Status200OK,
                res,
                null,
                "All Admin recieved succesfully"));
        }
    }
}