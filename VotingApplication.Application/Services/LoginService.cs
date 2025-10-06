using System.Diagnostics.Metrics;
using System.IdentityModel.Tokens.Jwt;
using System.Linq.Expressions;
using System.Security.Authentication;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Identity.Client;
using Microsoft.IdentityModel.Tokens;
using VotingApplication.Application.DTO;
using VotingApplication.Application.Interfaces;
using VotingApplication.Domain.Context;
using VotingApplication.Domain.Entity;
using VotingApplication.Domain.Interfaces;
using VotingApplication.Domain.Migrations;

namespace VotingApplication.Application.Services
{
    public class LoginService : ILoginService
    {
        private readonly IConfiguration _configuration;
        private readonly IVoterService _voterService;
        private readonly IAdminService _adminService;
        private readonly IGenericRepository<RefreshToken> _refreshTokenRepository;
        private readonly ApplicationContext _context;
        private long Id;

        public LoginService(IConfiguration configuration, IVoterService voterService, IAdminService adminService, IGenericRepository<RefreshToken> refreshTokenRepository, ApplicationContext context)
        {
            _configuration = configuration;
            _adminService = adminService;
            _voterService = voterService;
            _context = context;
            _refreshTokenRepository = refreshTokenRepository;
        }

        public async Task<LoginResponseDto> Login(LoginDto loginDto)
        {
            if (loginDto.Role == "Voter")
            {
                var voterList = await _voterService.GetAllVoters(0, 0, true);
                var voter = new Voter();
                for (int i = 0; i < voterList.Count(); i++)
                {
                    if (voterList.ElementAt(i).Email == loginDto.Email && !voterList.ElementAt(i).IsDeleted)
                    {
                        voter = voterList.ElementAt(i);
                    }
                }

                if (voter.Email == "")
                {
                    throw new KeyNotFoundException("No Voter or Candidate with given Id exist");
                }
                else
                {
                    //Assigning admin Id to private property Id to set it as claim
                    Id = voter.VoterId;
                    if (_verifyPassword(loginDto.Password, voter.Password))
                    {
                        var refreshToken = await _generateRefreshToken("Voter", voter, null);
                        var jwtToken = _generateJwtToken(loginDto);
                        return new LoginResponseDto()
                        {
                            RefreshToken = refreshToken,
                            JwtToken = jwtToken,
                        };
                    }
                    else
                    {
                        throw new InvalidCredentialException("Password do not match");
                    }
                }
            }
            if (loginDto.Role == "Admin")
            {
                //var candidates = await _candidateService.GetCandidate(loginDto.Id);
                var admins = await _adminService.GetAllAdmin(0, 0, true);
                var admin = admins.FirstOrDefault((admin) => admin.Email == loginDto.Email);
                if (admin == null)
                {
                    throw new KeyNotFoundException("No Admin with given Id exist");
                }
                else
                {
                    //Assigning admin Id to private property Id to set it as claim
                    Id = admin.AdminId;
                    if (_verifyPassword(loginDto.Password, admin.Password))
                    {
                        var refreshToken = await _generateRefreshToken("Admin", null, admin);
                        var jwtToken = _generateJwtToken(loginDto);
                        return new LoginResponseDto()
                        {
                            RefreshToken = refreshToken,
                            JwtToken = jwtToken,
                        };
                    }
                    else
                    {
                        throw new InvalidCredentialException("Incorect Password");
                    }
                }
            }
            return new LoginResponseDto();
        }

        private string _generateJwtToken(LoginDto loginDto)
        {
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Key"]!));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha256);

            var claims = new[] {
                new Claim(ClaimTypes.Role, loginDto.Role),
                new Claim(ClaimTypes.Email, loginDto.Email),
                new Claim(ClaimTypes.NameIdentifier, Id.ToString()) };

            var token = new JwtSecurityToken(
                claims: claims,
              expires: DateTime.Now.AddMinutes(15),
              signingCredentials: credentials);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        private bool _verifyPassword(string password, string dbPassword)
        {
            SHA256 sha256 = SHA256.Create();
            byte[] inputHashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            var encryptedPassword = Convert.ToBase64String(inputHashBytes);

            if (encryptedPassword == dbPassword)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        private async Task<string> _generateRefreshToken(String role, Voter? voter, Admin? admin)
        {
            //Generating random seq of numbers
            var token = Convert.ToBase64String(RandomNumberGenerator.GetBytes(32));
            //Given role is voter
            if (role == "Voter")
            {
                var refreshTokenList = await _refreshTokenRepository.GetAllAsync(0, 0, true);
                var refreshToken = refreshTokenList.FirstOrDefault(x => x.Voter == voter);
                if (refreshToken == null)
                {
                    //Voter is logging in for first time generate refresh token and save that in DB
                    var _refreshToken = new RefreshToken()
                    {
                        Admin = null,
                        AdminId = null,
                        Token = token,
                        TokenExp = DateTime.Now.AddDays(7),
                        VoterId = voter?.VoterId,
                        Voter = voter
                    };
                    await _refreshTokenRepository.CreateAsync(_refreshToken);
                    await _refreshTokenRepository.SaveAsync();
                }
                else
                {
                    refreshToken.Token = token;
                    refreshToken.TokenExp = DateTime.Now.AddDays(7);
                    await _refreshTokenRepository.SaveAsync();
                }
            }
            if (role == "Admin")
            {
                var refreshTokenList = await _refreshTokenRepository.GetAllAsync(0, 0, true);
                var refreshToken = refreshTokenList.FirstOrDefault(x => x.Admin == admin);
                if (refreshToken == null)
                {
                    //Admin is logging in for first time generate refresh token and save that in DB
                    var _refreshToken = new RefreshToken()
                    {
                        Admin = admin,
                        AdminId = admin?.AdminId,
                        Token = token,
                        TokenExp = DateTime.Now.AddDays(1),
                        VoterId = null,
                        Voter = null
                    };
                    await _refreshTokenRepository.CreateAsync(_refreshToken);
                    await _refreshTokenRepository.SaveAsync();
                }
                else
                {
                    //Admin has already logged in once so updating the refresh token
                    refreshToken.Token = token;
                    refreshToken.TokenExp = DateTime.Now.AddDays(7);
                    await _refreshTokenRepository.SaveAsync();
                }
            }

            return token;
        }

        public async Task<LoginResponseDto> GenerateJwtFromRefreshToken(string refreshToken)
        {
            var refreshTokenList = await _refreshTokenRepository.GetAllAsync(0, 0, true);
            var dbrefreshToken = _context.RefreshTokens.Include(x => x.Voter).Include(x => x.Admin).FirstOrDefault(x => x.Token == refreshToken);

            var loginDto = new LoginDto();
            if (dbrefreshToken == null)
            {
                throw new NullReferenceException("No such refresh token exist");
            }
            else
            {
                if (dbrefreshToken.VoterId != null)
                {
                    //refresh token is by a

                    loginDto.Email = dbrefreshToken.Voter.Email;
                    loginDto.Password = dbrefreshToken.Voter.Password;
                    loginDto.Role = "Voter";
                }
                if (dbrefreshToken.AdminId != null)
                {
                    //refresh token is by a admin

                    loginDto.Email = dbrefreshToken.Admin.Email;
                    loginDto.Password = dbrefreshToken.Admin.Password;
                    loginDto.Role = "Admin";
                }
                if (dbrefreshToken.TokenExp < DateTime.Now)
                {
                    //refresh token has expired
                    throw new InvalidOperationException("Refresh token has expired");
                }
                else
                {
                    //refresh token is still
                    var jwt = _generateJwtToken(loginDto);
                    return new LoginResponseDto()
                    {
                        JwtToken = jwt,
                        RefreshToken = refreshToken,
                    };
                }
            }
        }
    }
}