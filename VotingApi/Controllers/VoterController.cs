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
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public class VoterController : ControllerBase
    {
        private readonly IVoterService _voterService;

        //Not using primary constructor for better readibilty
        public VoterController(IVoterService voterService)
        {
            _voterService = voterService;
        }

        // Endpoint to add voter to the voter list
        [Authorize(Roles = "Admin")]
        [HttpPost("AddVoter")]
        public async Task<IActionResult> AddVoter([FromBody] CreateVoterDto createVoterDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary>(
                    StatusCodes.Status400BadRequest,
                    new ModelStateDictionary(),
                    ModelState,
                    "One or more fields were faild validation"));
            }

            var res = await _voterService.AddVoter(createVoterDto);

            return Ok(new ApiResponse<VoterResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Voter registered successfully"));
        }

        // Endpoint to get voter to the voter list
        [Authorize(Roles = "Admin,Voter")]
        [HttpPost("GetVoterById")]
        public async Task<IActionResult> GetVoterById([FromQuery] long voterId)
        {
            //Checking if id is non negative
            if (voterId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }
            var res = await _voterService.GetVoter(voterId);

            return Ok(new ApiResponse<VoterResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Voter recieved successfully"));
        }

        // Endpoint to get all the voters
        [Authorize(Roles = "Admin")]
        [HttpGet("GetAllVoter/{pageNumber:int}/{pageSize:int}")]
        public async Task<IActionResult> GetAllVoter(int pageNumber, int pageSize)
        {
            var res = await _voterService.GetAllVoters(pageNumber, pageSize, false);
            return Ok(new ApiResponse<IEnumerable<Voter>?>
                (StatusCodes.Status200OK,
                res,
                null,
                "All voters recieved succesfully"));
        }

        //Controller to update the voter
        [Authorize(Roles = "Admin")]
        [HttpPut("UpdateVoter/{voterId:long}")]
        public async Task<IActionResult> UpdateVoter([FromBody] VoterUpdateDto voterUpdateDto, long voterId)
        {
            //Checking if id is non negative
            if (voterId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }

            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary>(
                    StatusCodes.Status400BadRequest,
                    new ModelStateDictionary(),
                    ModelState,
                    "One or more fields failed validation"));
            }

            var res = await _voterService.UpdateVoter(voterUpdateDto, voterId);
            return Ok(new ApiResponse<VoterResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Voter updated successfully"));
        }

        //Controller to delete voter
        [Authorize(Roles = "Admin")]
        [HttpDelete("DeleteVoter/{voterId:long}")]
        public async Task<IActionResult> DeleteVoter(long voterId)
        {
            //Checking if id is non negative
            if (voterId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }

            var res = await _voterService.DeleteVoter(voterId);
            return Ok(new ApiResponse<VoterResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Voter deleted successfully"));
        }

        //Controller to vote to a candidate
        [HttpPost("VoteToCandidate")]
        [Authorize(Roles = "Voter")]
        public async Task<IActionResult> VoteToCandidate(long candidateId, long voterId)
        {
            if (candidateId <= 0 || voterId <= 0)
            {
                return Ok(new ApiResponse<string?>(
                     StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }

            var res = await _voterService.VoteToCandidate(candidateId, voterId);
            return Ok(new ApiResponse<VoterResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Voting successful"));
        }

        [HttpGet("SearchVoter/{voterName}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> SearchByVoterName(string voterName)
        {
            var res = await _voterService.SearchVoterByName(voterName);
            return Ok(new ApiResponse<IEnumerable<Voter>?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Voter fetched successfully"));
        }
    }
}