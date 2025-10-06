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
    public class PartyController : Controller
    {
        private readonly IPartyService _partyService;

        public PartyController(IPartyService partyService)
        {
            _partyService = partyService;
        }

        [HttpPost("AddParty")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> AddParty([FromBody] CreatePartyDto createPartyDto)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(new ApiResponse<ModelStateDictionary>(
                    StatusCodes.Status400BadRequest,
                    new ModelStateDictionary(),
                    ModelState,
                    "One or more fields were faild validation"));
            }

            var res = await _partyService.AddParty(createPartyDto);

            return Ok(new ApiResponse<PartyResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Party registered successfully"));
        }

        [Authorize(Roles = "Admin")]
        [HttpGet("GetPartyById")]
        public async Task<IActionResult> GetPartyById([FromQuery] long partyId)
        {
            //Checking if id is non negative
            if (partyId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }
            var res = await _partyService.GetPartyById(partyId);
            return Ok(new ApiResponse<PartyResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Party recieved successfully"));
        }

        [Authorize(Roles = "Admin")]
        [HttpGet("GetAllParties/{pageNumber:int}/{pageSize:int}/{fetchAll:bool}")]
        public async Task<IActionResult> GetAllParty(int pageNumber, int pageSize, bool fetchAll)
        {
            var res = await _partyService.GetAllParties(pageNumber, pageSize, fetchAll);
            return Ok(new ApiResponse<IEnumerable<Party>?>
                (StatusCodes.Status200OK,
                res,
                null,
                "All party recieved succesfully"));
        }

        [Authorize(Roles = "Admin")]
        [HttpDelete("DeleteParty")]
        public async Task<IActionResult> DeleteParty([FromQuery] long partyId)
        {
            //Checking if id is non negative
            if (partyId <= 0)
            {
                return BadRequest(new ApiResponse<string?>(
                    StatusCodes.Status400BadRequest,
                    "",
                    "",
                    "Invalid Id provided"));
            }
            var res = await _partyService.DeleteParty(partyId);
            return Ok(new ApiResponse<PartyResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Party deleted successfully"));
        }

        [Authorize(Roles = "Admin")]
        [HttpPut("UpdateParty/{partyId:long}")]
        public async Task<IActionResult> UpdateCandidate([FromBody] UpdatePartyDto updatePartyDto, long partyId)
        {
            //Checking for non negative values in candiate id
            if (partyId <= 0)
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

            var res = await _partyService.UpdateParty(updatePartyDto, partyId);
            return Ok(new ApiResponse<PartyResponseDto?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Party updated successfully"));
        }

        [HttpGet("SearchParty/{partyName}")]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> SearchByPartyName(string partyName)
        {
            var res = await _partyService.SearchByPartyName(partyName);
            return Ok(new ApiResponse<IEnumerable<Party>?>(
                StatusCodes.Status200OK,
                res,
                null,
                "Party fetched successfully"));
        }
    }
}