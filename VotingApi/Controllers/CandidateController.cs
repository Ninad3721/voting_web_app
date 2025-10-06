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
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public class CandidateController : ControllerBase
    {
        private readonly ICandidateService _candidateService;

        //Not using primary constructor for better readibilty
        public CandidateController(ICandidateService service)
        {
            _candidateService = service;
        }

        //Endpoint to add candidate

        [Authorize(Roles = "Admin")]
        [HttpPost("AddCandidate")]
        public async Task<IActionResult> AddCandidate([FromBody] CreateCandidateDto createCandidateDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary?>(
                    StatusCodes.Status400BadRequest,
                    null,
                    ModelState,
                    "One or more fields do not pass validation"));
            }

            var res = await _candidateService.AddCandidate(createCandidateDto);
            return Ok(new ApiResponse<CandidateResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Candidate created successfully"));
        }

        //Endpoint to get the candidate by id
        [Authorize]
        [HttpGet("GetCandidateById/{candidateId:long}")]
        public async Task<IActionResult> GetCandidateById(long candidateId)
        {
            //Checking for non negative values in candiate id
            if (candidateId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }

            var res = await _candidateService.GetCandidate(candidateId);
            return Ok(new ApiResponse<CandidateResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Candidate fetched successfully"
                ));
        }

        //Endpoint to get all the candidates
        [Authorize]
        [HttpGet("GetAllCandidate/{pageNumber:int}/{pageSize:int}")]
        public async Task<IActionResult> GetAllCandidate(int pageNumber, int pageSize)
        {
            if (pageSize <= 0 || pageNumber <= 0)
            {
                return BadRequest(new ApiResponse<string>(

                     StatusCodes.Status400BadRequest,
                    "",
                    "Page number or page size not valid",
                    ""
                ));
            }
            var res = await _candidateService.GetAllCandidate(pageNumber, pageSize, false);
            return Ok(new ApiResponse<IEnumerable<Candidate>?>(
                StatusCodes.Status200OK,
                res,
                null,
                "All candidates fetched"));
        }

        //Endpoint update the candidate
        [Authorize(Roles = "Admin")]
        [HttpPut("UpdateCandidate/{candidateId:long}")]
        public async Task<IActionResult> UpdateCandidate([FromBody] CandidateUpdateDto candidateUpdateDto, long candidateId)
        {
            //Checking for non negative values in candiate id
            if (candidateId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary?>(
                    StatusCodes.Status400BadRequest,
                    null,
                    ModelState,
                    "One or more validation failed"));
            }

            var res = await _candidateService.UpdateCandidate(candidateUpdateDto, candidateId);
            return Ok(new ApiResponse<CandidateResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Candidate updated successfully"));
        }

        //Endpoint delete the candidate
        [Authorize(Roles = "Admin")]
        [HttpDelete("DeleteCandidate/{candidateId:long}")]
        public async Task<IActionResult> DeleteCandiate(long candidateId)
        {
            if (candidateId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }

            var res = await _candidateService.DeleteCandidate(candidateId);
            return Ok(new ApiResponse<CandidateResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Candidate deleted successfully"));
        }

        //Endpoint to get top three candidate
        [Authorize(Roles = "Admin,Voter")]
        [HttpGet("/getTopThreeCandidates")]
        public async Task<IActionResult> GetTopThreeCandidates()
        {
            var topThreeCandidateArray = await _candidateService.GeetTopThreeCandidates();
            return Ok(new ApiResponse<IEnumerable<Candidate>?>(
                StatusCodes.Status200OK,
                topThreeCandidateArray,
                null,
                "Top three Candidate fetched successfully"));
        }

        [HttpGet("SearchCandidate/{candidateName}")]
        [Authorize(Roles = "Admin,Voter")]
        public async Task<IActionResult> SearchByCandidateName(string candidateName)
        {
            var res = await _candidateService.SearchByCandidateName(candidateName);
            return Ok(new ApiResponse<IEnumerable<Candidate>?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Candidate fetched successfully"));
        }
    }
}