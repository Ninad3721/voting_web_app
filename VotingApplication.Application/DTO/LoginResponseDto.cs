﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VotingApplication.Application.DTO
{
    public class LoginResponseDto
    {
        public string JwtToken { get; set; } = "";
        public string RefreshToken { get; set; } = "";
    }
}