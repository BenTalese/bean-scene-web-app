using AutoMapper;
using BeanScene.Data;
using BeanScene.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Controllers
{
    public class HomeController : AdminAreaBase
    {
        public HomeController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        public async Task<IActionResult> Index()
        {
            //var today = DateTime.Now;

            //var services = await _context.Services
            //    .Include(s => s.Sitting)
            //    .Include(s => s.Bookings)
            //    .ThenInclude(b => b.Customer)
            //    .ToListAsync();

            //Service service = null;

            //foreach (var s in services)
            //{
            //    if (s.Date.ToShortDateString() == today.ToShortDateString())
            //    {
            //        service = s;
            //    }
            //}

            //Models.Home.Index model = null;

            //if (service != null)
            //{
            //    var servicesToday = await _context.Services
            //        .Include(s => s.Sitting)
            //        .Include(s => s.Bookings)
            //        .ThenInclude(b => b.Customer)
            //        .Where(s => s.Date == service.Date)
            //        .ToListAsync();

            //    var earliestStartTime = new DateTime();
            //    var latestEndTime = new DateTime();
            //    var times = new List<DateTime>();
            //    foreach (var s in services)
            //    {
            //        times.Add(s.Sitting.StartTime);
            //        times.Add(s.Sitting.EndTime);
            //    }
            //    times.Sort();
            //    earliestStartTime = times.ElementAt(0);
            //    latestEndTime = times.Last();

            //    var areas = await _context.Areas.Include(a => a.Tables).ThenInclude(t => t.Bookings).ToListAsync();

            //    model = new Models.Home.Index
            //    {
            //        Service = service,
            //        ServiceOnDate = true
            //    };
            //    return View(model);
            //}
            //model = new Models.Home.Index
            //{
            //    ServiceOnDate = false
            //};
            //return View(model);

            var today = DateTime.Now;

            var services = await _context.Services
                .Include(s => s.Sitting)
                .ToListAsync();

            for (int i = services.Count - 1; i >= 0; i--)
            {
                if (services[i].Date.ToShortDateString() != today.ToShortDateString() || !services[i].Sitting.IsActive)
                {
                    services.Remove(services[i]);
                }
            }

            Models.Home.Index model = null;

            if (services.Count > 0)
            {
                model = new Models.Home.Index
                {
                    Service = services.ElementAt(0),
                    ServiceOnDate = true
                };
                return View(model);
            }
            model = new Models.Home.Index
            {
                ServiceOnDate = false
            };
            return View(model);
        }
    }
}
