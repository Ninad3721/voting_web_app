using System.Data;
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
    public class VoterService : IVoterService
    {
        private readonly IGenericRepository<Voter> _voterRepository;
        private readonly IGenericRepository<Candidate> _candidateRepository;
        private readonly IMapper _mapper;
        private readonly ApplicationContext _applicationContext;

        //Avoiding  using primary constructor for better code readability
        public VoterService(IGenericRepository<Voter> repository, IMapper mapper, IGenericRepository<Candidate> candidateRepository, ApplicationContext applicationContext)
        {
            _mapper = mapper;
            _voterRepository = repository;
            _candidateRepository = candidateRepository;
            _applicationContext = applicationContext;
        }

        //Service to add voter instance
        public async Task<VoterResponseDto> AddVoter(CreateVoterDto createVoterDto)
        {
            //Finding if the same email exist in the database and allwoing to add with same email if entity is deleted
            var voterList = await _voterRepository.GetAllAsync(0, 0, true);
            for (int i = 0; i < voterList.Count(); i++)
            {
                if (voterList.ElementAt(i).Email == createVoterDto.Email && !voterList.ElementAt(i).IsDeleted)
                {
                    throw new DuplicateNameException("Email already exist in the database");
                }
            }
            //var voter = voterList.FirstOrDefault((voter) => voter.Email == createVoterDto.Email);
            //if (voter != null)
            //{
            //    throw new DuplicateNameException("Email already exist in the database");
            //    //var deletedVoter = voter.Where((voter) => voter.IsDeleted == true);
            //    //if (deletedVoter == null)
            //    //{
            //    //    throw new DuplicateNameException("Email already exist in the database");
            //    //}
            //}
            //Hashing the password before saving it
            SHA256 sha256 = SHA256.Create();
            byte[] hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(createVoterDto.Password));
            createVoterDto.Password = Convert.ToBase64String(hashBytes);

            var mappedVoter = _mapper.Map<Voter>(createVoterDto);
            await _voterRepository.CreateAsync(mappedVoter);
            await _voterRepository.SaveAsync();
            return _mapper.Map<VoterResponseDto>(mappedVoter);
        }

        //Service to soft delete voter
        public async Task<VoterResponseDto> DeleteVoter(long voterId)
        {
            var voter = await _voterRepository.GetByIdAsync(voterId);

            //Voter is not found due to invalid candidate id provided
            if (voter == null)
            {
                throw new KeyNotFoundException("No voter found with given Id");
            }
            //Checking if the voter is deleted or not
            if (voter.IsDeleted)
            {
                throw new KeyNotFoundException("Voter with given id is deleted");
            }
            //Voter is already voted once hence deletion is not possible
            if (!voter.HasVoted)
            {
                voter.IsDeleted = true;
            }
            else
            {
                throw new InvalidOperationException("Voter has already been voted once");
            }

            await _voterRepository.SaveAsync();
            return _mapper.Map<VoterResponseDto>(voter);
        }

        //Service to get voter
        public async Task<VoterResponseDto> GetVoter(long voterId)
        {
            var voter = await _voterRepository.GetByIdAsync(voterId);

            //Voter is not found due to invalid voter id provided
            if (voter == null)
            {
                throw new KeyNotFoundException("No voter found with given Id");
            }

            //Checking if the voter is deleted or not
            if (voter.IsDeleted)
            {
                throw new KeyNotFoundException("Voter with given id is deleted");
            }

            var res = _mapper.Map<VoterResponseDto>(voter);
            return res;
        }

        //Update service for candidate
        public async Task<VoterResponseDto> UpdateVoter(VoterUpdateDto voterUpdateDto, long voterId)
        {
            var voter = await _voterRepository.GetByIdAsync(voterId);

            //Voter is not found due to invalid voter id provided
            if (voter == null)
            {
                throw new KeyNotFoundException("No voter found with given Id");
            }

            //Checking if the voter is deleted or not
            if (voter.IsDeleted)
            {
                throw new KeyNotFoundException("Voter with given id is deleted");
            }

            // Track if any changes were made
            bool hasChanges = false;

            if (voter.Name != voterUpdateDto.Name)
            {
                voter.Name = voterUpdateDto.Name;
                hasChanges = true;
            }
            if (voter.Email != voterUpdateDto.Email)
            {
                voter.Email = voterUpdateDto.Email;
                hasChanges = true;
            }

            if (voter.DOB != voterUpdateDto.DOB)
            {
                voter.DOB = voterUpdateDto.DOB;
                hasChanges = true;
            }

            if (voter.Gender != voterUpdateDto.Gender)
            {
                voter.Gender = voterUpdateDto.Gender;
                hasChanges = true;
            }

            //Saving the changes if there has been any change in the candidate instance
            if (hasChanges)
            {
                //checking if the that voter wants to update to already exist in the database or not

                var voterList = await _voterRepository.GetAllAsync(0, 0, true);
                for (int i = 0; i < voterList.Count(); i++)
                {
                    if (voterList.ElementAt(i).Email == voterUpdateDto.Email && !voterList.ElementAt(i).IsDeleted)
                    {
                        throw new DuplicateNameException("Updated Email already exist in the database");
                    }
                }

                voter.DateUpdated = DateTimeOffset.Now;
                _voterRepository.Update(voter);
                await _voterRepository.SaveAsync();
                return _mapper.Map<VoterResponseDto>(voterUpdateDto);
            }

            throw new InvalidOperationException("No changes were done in the new instance");
        }

        public async Task<VoterResponseDto> VoteToCandidate(long candidateId, long voterId)
        {
            var voter = await _voterRepository.GetByIdAsync(voterId);

            //Voter is not found due to invalid voter id provided
            if (voter == null)
            {
                throw new KeyNotFoundException("No voter found with given Id");
            }

            //Checking if the voter is deleted or not
            if (voter.IsDeleted)
            {
                throw new KeyNotFoundException("Voter with given id is deleted");
            }

            //Voter is already voted once hence deletion is not possible
            if (!voter.HasVoted)
            {
                voter.HasVoted = true;
            }
            else
            {
                throw new InvalidOperationException("Voter has already been voted once");
            }

            //------------- Candidate operations -------------
            var candidate = await _candidateRepository.GetByIdAsync(candidateId);

            //Candidate is not found due to invalid candidate id provided
            if (candidate == null)
            {
                throw new KeyNotFoundException("No candidate found with given Id");
            }
            //Candidate is not found as it is deleted
            if (candidate.IsDeleted)
            {
                throw new KeyNotFoundException("No candidate found with given Id");
            }
            candidate.TotalVotes += 1;
            await _voterRepository.SaveAsync();
            await _candidateRepository.SaveAsync();

            return _mapper.Map<VoterResponseDto>(voter);
        }

        //Services to get all the voters
        public async Task<IEnumerable<Voter>> GetAllVoters(int pageNumber, int pageSize, bool fetchAll)
        {
            return await _voterRepository.GetAllAsync(pageNumber, pageSize, fetchAll);
        }

        public Task<VoterResponseDto> SearchVoter(string voterName)
        {
            if (voterName == null)
            {
                throw new InvalidOperationException("Search keyword cannot be empty");
            }

            throw new NotImplementedException();
        }

        public async Task<IEnumerable<Voter>> SearchVoterByName(string voterName)
        {
            if (voterName == null)
            {
                throw new InvalidOperationException("Search cannot be null");
            }
            var query = $"EXEC SearchByVoterName {voterName}";
            return await _applicationContext.Voters.FromSqlRaw(query).ToListAsync();
        }
    }
}