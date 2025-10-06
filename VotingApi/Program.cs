using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using VotingApplication.Api.Middleware;
using VotingApplication.Application.Config;
using VotingApplication.Application.Interfaces;
using VotingApplication.Application.Services;
using VotingApplication.Domain.Context;
using VotingApplication.Domain.Interfaces;
using VotingApplication.Domain.Repositories;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

//Adding sql service to the project
builder.Services.AddDbContext<ApplicationContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("VotingApplicationDB")));

//Adding allow all cors
builder.Services.AddCors((options) =>
{
    options.AddPolicy("AllowAllPolicy",
                   policy =>
                   {
                       policy.AllowAnyHeader();
                       policy.AllowAnyOrigin();
                       policy.AllowAnyMethod();
                   });
});

//Adding JWT services
var key = Encoding.ASCII.GetBytes(builder.Configuration["JWT:Key"]!);
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}
).AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.SaveToken = true;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});

//Adding auto mapper to the service
builder.Services.AddAutoMapper(typeof(AutoMapperConfig));

//Adding custom scopped services
builder.Services.AddScoped<IVoterService, VoterService>();
builder.Services.AddScoped<ICandidateService, CandidateService>();
builder.Services.AddScoped<ILoginService, LoginService>();
builder.Services.AddScoped<IAdminService, AdminService>();
builder.Services.AddScoped<IPartyService, PartyService>();
builder.Services.AddScoped(typeof(IGenericRepository<>), typeof(GenericRepository<>));

//Adding swagger service
builder.Services.AddSwaggerGen(opt =>
{
    opt.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please enter token",
        Name = "Authorization",
        Type = SecuritySchemeType.Http,
        BearerFormat = "JWT",
        Scheme = "bearer"
    });
    opt.AddSecurityRequirement(new OpenApiSecurityRequirement
{
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type=ReferenceType.SecurityScheme,
                    Id="Bearer"
                }
            },
            new string[]{}
        }
});
}

     );

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseCors("AllowAllPolicy");

app.UseAuthentication();
app.UseAuthorization();

//Global middleware to log exception to the database
app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

app.MapControllers();

var localIpAddress = "10.0.2.20";  // Replace with your local IP address
var port = 5031;  // Replace with the desired port
app.Run($"http://{localIpAddress}:{port}");