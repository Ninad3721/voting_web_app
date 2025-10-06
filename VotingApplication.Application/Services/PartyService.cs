using System.Data;
using AutoMapper;
using Microsoft.EntityFrameworkCore;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Domain.Context;
using VotingApplication.Domain.Entity;
using VotingApplication.Domain.Interfaces;

namespace VotingApplication.Application.Services
{
    public class PartyService : IPartyService
    {
        private readonly IGenericRepository<Party> _partyRepository;
        private readonly IGenericRepository<Candidate> _candidateRepository;
        private readonly ApplicationContext _context;
        private readonly IMapper _mapper;

        public PartyService(IGenericRepository<Party> partyRepository, IMapper mapper, IGenericRepository<Candidate> candidateRepository, ApplicationContext context)
        {
            _partyRepository = partyRepository;
            _mapper = mapper;
            _candidateRepository = candidateRepository;
            _context = context;
        }

        public async Task<PartyResponseDto> AddParty(CreatePartyDto createPartyDto)
        {
            //Finding if the same party name exist in the database
            var partyList = await _partyRepository.GetAllAsync(0, 0, true);
            for (int i = 0; i < partyList.Count(); i++)
            {
                if (partyList.ElementAt(i).PartyName == createPartyDto.PartyName && !partyList.ElementAt(i).IsDeleted)
                {
                    throw new DuplicateNameException("Party name already exist");
                }
            }

            var _mappedParty = _mapper.Map<Party>(createPartyDto);
            _mappedParty.PartyName = _mappedParty.PartyName.ToUpper();
            await _partyRepository.CreateAsync(_mappedParty);
            await _partyRepository.SaveAsync();
            return _mapper.Map<PartyResponseDto>(_mappedParty);
        }

        public async Task<PartyResponseDto> DeleteParty(long PartyId)
        {
            var candidateList = await _candidateRepository.GetAllAsync(0, 0, true);
            var party = await _partyRepository.GetByIdAsync(PartyId);
            //party is not found due to invalid candidate id provided
            if (party == null)
            {
                throw new KeyNotFoundException("No party found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (party.IsDeleted)
            {
                throw new KeyNotFoundException("Party with given id is deleted");
            }
            //Checking if the any candidate is associated to the party that is getting deleted
            foreach (var candidate in candidateList)
            {
                if (candidate.PartyName == party.PartyName)
                {
                    throw new InvalidOperationException("Cannot delete party as it is associated to a candidate");
                }
            }

            party.IsDeleted = true;
            await _partyRepository.SaveAsync();
            return _mapper.Map<PartyResponseDto>(party);
        }

        public Task<IEnumerable<Party>> GetAllParties(int pageNumber, int pageSize, bool fetchAll)
        {
            return _partyRepository.GetAllAsync(pageNumber, pageSize, fetchAll);
        }

        public async Task<PartyResponseDto> GetPartyById(long PartyId)
        {
            var party = await _partyRepository.GetByIdAsync(PartyId);
            //Party is not found due to invalid candidate id provided
            if (party == null)
            {
                throw new KeyNotFoundException("No party found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (party.IsDeleted)
            {
                throw new KeyNotFoundException("Party with given id is deleted");
            }
            return _mapper.Map<PartyResponseDto>(party);
        }

        public async Task<IEnumerable<Party>> SearchByPartyName(string partyName)
        {
            if (partyName == null)
            {
                throw new InvalidOperationException("Search cannot be null");
            }
            var query = $"EXEC SearchByPartyName {partyName} ";
            return await _context.Parties.FromSqlRaw(query).ToListAsync();
        }

        public async Task<PartyResponseDto> UpdateParty(UpdatePartyDto updatePartyDto, long PartyId)
        {
            var candidateList = await _candidateRepository.GetAllAsync(0, 0, true);
            var party = await _partyRepository.GetByIdAsync(PartyId);

            //Party is not found due to invalid candidate id provided
            if (party == null)
            {
                throw new KeyNotFoundException("No party found with given Id");
            }
            //Checking if the candidate is deleted or not
            if (party.IsDeleted)
            {
                throw new KeyNotFoundException("Party with given id is deleted");
            }
            foreach (var candidate in candidateList)
            {
                if (candidate.PartyName == party.PartyName)
                {
                    throw new InvalidOperationException("Cannot update party as it is associated to a candidate");
                }
            }

            // Track if any changes were made
            bool hasChanges = false;

            //Comparing all the updatable properties to check if any change is made by the user or not
            if (party.PartyName != updatePartyDto.PartyName)
            {
                party.PartyName = updatePartyDto.PartyName;
                party.PartyName.ToUpper();
                hasChanges = true;
            }

            //Saving the changes if there has been any change in the candidate instance
            if (hasChanges)
            {
                party.DateUpdated = DateTimeOffset.Now;
                _partyRepository.Update(party);
                await _partyRepository.SaveAsync();
                return _mapper.Map<PartyResponseDto>(party);
            }

            throw new InvalidOperationException("No changes were done in the new instance");
        }
    }
}