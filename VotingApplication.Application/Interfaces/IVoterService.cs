using VotingApplication.Application.DTO;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Application.Interfaces
{
    //Interface for services of voter entity
    public interface IVoterService
    {
        // Adding a voter to voter list
        public Task<VoterResponseDto> AddVoter(CreateVoterDto createVoterDto);

        // Getting a voter from the voter list through his/her id
        public Task<VoterResponseDto> GetVoter(long voterId);

        // Updating a voter
        public Task<VoterResponseDto> UpdateVoter(VoterUpdateDto voterUpdateDto, long voterId);

        // Soft Deleting a voter from voter list
        public Task<VoterResponseDto> DeleteVoter(long voterId);

        // Voting to a candidate
        public Task<VoterResponseDto> VoteToCandidate(long candidateId, long voterId);

        // Get all voters from voter list
        public Task<IEnumerable<Voter>> GetAllVoters(int pageNumber, int pageSize, bool fetchAll);

        //Interface to search for voter by its name
        public Task<IEnumerable<Voter>> SearchVoterByName(string voterName);
    }
}