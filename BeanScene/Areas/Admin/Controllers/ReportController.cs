using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BeanScene.Data;
using Microsoft.AspNetCore.Authorization;
using BeanScene.Services;
using AutoMapper;
using Microsoft.AspNetCore.Identity;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin"), Authorize(Roles = "Manager")]
    public class ReportController : AdminAreaBase
    {
        public ReportController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        public IActionResult Current()
        {
            return View();
        }

        public IActionResult Archive()
        {
            return View();
        }
    }
}
