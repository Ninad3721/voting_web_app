using VotingApplication.Application.DTO;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Application.Interfaces
{
    //Interface for services of candidate entity
    public interface ICandidateService
    {
        // Adding a candidate to voter list
        public Task<CandidateResponseDto> AddCandidate(CreateCandidateDto createCandidateDto);

        // Getting a candidate from the candidate list through his/her id
        public Task<CandidateResponseDto> GetCandidate(long candidateId);

        // Updating a candiate
        public Task<CandidateResponseDto> UpdateCandidate(CandidateUpdateDto candidateUpdateDto, long candidateId);

        // Soft Deleting a candidate from voter list
        public Task<CandidateResponseDto> DeleteCandidate(long candidateId);

        // Getting all candidate from list
        public Task<IEnumerable<Candidate>> GetAllCandidate(int pageNumber, int pageSize, bool fetchAll);

        //Getting the top threecandidate
        public Task<IEnumerable<Candidate>> GeetTopThreeCandidates();

        //Interface to search for candidate by its name
        public Task<IEnumerable<Candidate>> SearchByCandidateName(string candidateName);
    }
}