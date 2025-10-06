using System.Security.Cryptography;
using System.Text;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Domain.Context;
using VotingApplication.Domain.Entity;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Application.Services
{
    public class CandidateService : ICandidateService
    {
        private readonly IGenericRepository<Candidate> _candidateRepository;
        private readonly ApplicationContext _context;
        private readonly IMapper _mapper;

        //Avoiding  using primary constructor for better code readability
        public CandidateService(IGenericRepository<Candidate> repository, IMapper mapper, ApplicationContext context)
        {
            _mapper = mapper;
            _candidateRepository = repository;
            _context = context;
        }

        //Service to add candidate instance
        public async Task<CandidateResponseDto> AddCandidate(CreateCandidateDto createCandidateDto)
        {
            SHA256 sha256 = SHA256.Create();
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(createCandidateDto.Password));
            createCandidateDto.Password = Convert.ToBase64String(hashBytes);

            var mappedCandidate = _mapper.Map<Candidate>(createCandidateDto);
            await _candidateRepository.CreateAsync(mappedCandidate);
            await _candidateRepository.SaveAsync();
            return _mapper.Map<CandidateResponseDto>(mappedCandidate);
        }

        //Service to soft delete candidate
        public async Task<CandidateResponseDto> DeleteCandidate(long candidateId)
        {
            var candidate = await _candidateRepository.GetByIdAsync(candidateId);

            //Candidate is not found due to invalid candidate id provided
            if (candidate == null)
            {
                throw new KeyNotFoundException("No candidate found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (candidate.IsDeleted)
            {
                throw new KeyNotFoundException("Candidate with given id is deleted");
            }
            //Candidate is already voted once hence deletion is not possible
            if (candidate.TotalVotes == 0)
            {
                candidate.IsDeleted = true;
            }
            else
            {
                throw new InvalidOperationException("Candidate has already been voted once");
            }

            await _candidateRepository.SaveAsync();
            return _mapper.Map<CandidateResponseDto>(candidate);
        }

        //Service to get candidate by its Id
        public async Task<CandidateResponseDto> GetCandidate(long candidateId)
        {
            var candidate = await _candidateRepository.GetByIdAsync(candidateId);

            //Candidate is not found due to invalid candidate id provided
            if (candidate == null)
            {
                throw new KeyNotFoundException("No candiate found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (candidate.IsDeleted)
            {
                throw new KeyNotFoundException("Candidate with given id is deleted");
            }

            var res = _mapper.Map<CandidateResponseDto>(candidate);
            return res;
        }

        //Updating the candidate using its id
        public async Task<CandidateResponseDto> UpdateCandidate(CandidateUpdateDto candidateUpdateDto, long candidateId)
        {
            var candidate = await _candidateRepository.GetByIdAsync(candidateId);

            //Candidate is not found due to invalid candidate id provided
            if (candidate == null)
            {
                throw new KeyNotFoundException("No user found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (candidate.IsDeleted)
            {
                throw new KeyNotFoundException("Candidate with given id is deleted");
            }

            // Track if any changes were made
            bool hasChanges = false;

            //Comparing all the updatable properties to check if any change is made by the user or not
            if (candidate.Name != candidateUpdateDto.Name)
            {
                candidate.Name = candidateUpdateDto.Name;
                hasChanges = true;
            }

            if (candidate.DOB != candidateUpdateDto.DOB)
            {
                candidate.DOB = candidateUpdateDto.DOB;
                hasChanges = true;
            }

            if (candidate.Gender != candidateUpdateDto.Gender)
            {
                candidate.Gender = candidateUpdateDto.Gender;
                hasChanges = true;
            }
            if (candidate.PartyName != candidateUpdateDto.PartyName)
            {
                candidate.PartyName = candidateUpdateDto.PartyName;
                hasChanges = true;
            }

            //Saving the changes if there has been any change in the candidate instance
            if (hasChanges)
            {
                candidate.DateUpdated = DateTimeOffset.Now;
                _candidateRepository.Update(candidate);
                await _candidateRepository.SaveAsync();
                return _mapper.Map<CandidateResponseDto>(candidateUpdateDto);
            }

            throw new InvalidOperationException("No changes were done in the new instance");
        }

        //Service to get all candidates
        public async Task<IEnumerable<Candidate>> GetAllCandidate(int pageNumber, int pageSize, bool fetchAll)
        {
            return await _candidateRepository.GetAllAsync(pageNumber, pageSize, fetchAll);
        }

        //Service to get top three candidates based on votes
        public async Task<IEnumerable<Candidate>> GeetTopThreeCandidates()
        {
            var candidateList = await _candidateRepository.GetAllAsync(0, 0, true);
            if (candidateList == null)
            {
                return Enumerable.Empty<Candidate>();
            }
            else
            {
                var topThreeCandidateList = await _context.Candidates.FromSqlRaw("EXEC GetTopThreeCandidates").ToListAsync();
                return topThreeCandidateList;
            }
        }

        public async Task<IEnumerable<Candidate>> SearchByCandidateName(string candidateName)
        {
            if (candidateName == null)
            {
                throw new InvalidOperationException("Search cannot be null");
            }
            var query = $"EXEC SearchByCandidateName {candidateName}";
            return await _context.Candidates.FromSqlRaw(query).ToListAsync();
        }
    }
}