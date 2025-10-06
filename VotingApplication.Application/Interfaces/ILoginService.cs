using VotingApplication.Application.DTO;
using VotingApplication.Domain.Entity;

namespace VotingApplication.Application.Interfaces
{
    public interface ILoginService
    {
        public Task<LoginResponseDto> Login(LoginDto loginDto);

        public Task<LoginResponseDto> GenerateJwtFromRefreshToken(string refreshToken);
    }
}