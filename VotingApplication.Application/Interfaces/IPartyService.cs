using VotingApplication.Application.DTO;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Application.Interfaces
{
    public interface IPartyService
    {
        public Task<PartyResponseDto> AddParty(CreatePartyDto createPartyDto);

        public Task<IEnumerable<Party>> GetAllParties(int pageNumber, int pageSize, bool fetchAll);

        public Task<PartyResponseDto> GetPartyById(long PartyId);

        public Task<PartyResponseDto> DeleteParty(long PartyId);

        public Task<PartyResponseDto> UpdateParty(UpdatePartyDto updatePartyDto, long PartyId);

        //Defination to search for voter by its name
        public Task<IEnumerable<Party>> SearchByPartyName(string partyName);
    }
}