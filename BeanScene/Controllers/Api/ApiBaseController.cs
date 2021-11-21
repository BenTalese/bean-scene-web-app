using AutoMapper;
using BeanScene.Data;
using BeanScene.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Controllers.Api
{
    [Route("api")]
    [ApiController]
    public class ApiBaseController : ControllerBase
    {
        protected readonly ApplicationDbContext _context;
        protected readonly UserManager<IdentityUser> _userManager;
        protected readonly CustomerService _customerService;
        protected readonly IMapper _mapper;

        public ApiBaseController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper)
        {
            _context = context;
            _userManager = userManager;
            _customerService = customerService;
            _mapper = mapper;
        }
    }
}
