using AutoMapper;
using VotingApplication.Application.DTO;
using VotingApplication.Domain.Entity;

//Automapper configurations
namespace VotingApplication.Application.Config
{
    public class AutoMapperConfig : Profile
    {
        public AutoMapperConfig()
        {
            //Voter Mappings
            CreateMap<Voter, CreateVoterDto>().ReverseMap();
            CreateMap<Voter, VoterResponseDto>().ReverseMap();
            CreateMap<Voter, VoterUpdateDto>().ReverseMap();
            CreateMap<CreateVoterDto, VoterResponseDto>().ReverseMap();
            CreateMap<VoterUpdateDto, VoterResponseDto>().ReverseMap();

            //Candidate Mappings
            CreateMap<Candidate, CreateCandidateDto>().ReverseMap();
            CreateMap<Candidate, CandidateResponseDto>().ReverseMap();
            CreateMap<Candidate, CandidateUpdateDto>().ReverseMap();
            CreateMap<CreateCandidateDto, CandidateResponseDto>().ReverseMap();
            CreateMap<CandidateUpdateDto, CandidateResponseDto>().ReverseMap();

            //Admin Mappings
            CreateMap<Admin, CreateAdminDto>().ReverseMap();
            CreateMap<Admin, AdminResponseDto>().ReverseMap();

            //Party Mappings
            CreateMap<Party, CreatePartyDto>().ReverseMap();
            CreateMap<Party, PartyResponseDto>().ReverseMap();
            CreateMap<Party, UpdatePartyDto>().ReverseMap();
        }
    }
}