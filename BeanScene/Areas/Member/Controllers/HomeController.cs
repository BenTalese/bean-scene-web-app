using AutoMapper;
using BeanScene.Areas.Member.Controllers;
using BeanScene.Data;
using BeanScene.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Member.Controllers
{
    public class HomeController : MemberAreaBase
    {
        public HomeController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        public IActionResult Index()
        {
            return View();
        }
    }
}
