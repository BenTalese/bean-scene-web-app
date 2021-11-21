using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BeanScene.Data;
using Microsoft.AspNetCore.Identity;
using BeanScene.Services;
using AutoMapper;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AllocationController : AdminAreaBase
    {
        public AllocationController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        public async Task<IActionResult> Select()
        {
            var services = await _context.Services
                .Include(s => s.Sitting)
                .Include(s =>s.Bookings)
                .ThenInclude(b => b.Tables)
                .OrderBy(s => s.Sitting.StartTime)
                .ToListAsync();
            var availableServices = new List<Service>();
            var availableDates = new List<DateTime>();
            var monthsWithYears = new List<DateTime>();
            var areas = _context.Areas.Include(a => a.Tables);
            int totalTableCapacity = 0;
            var years = new List<int>();

            foreach (var area in areas)
            {
                totalTableCapacity += area.TableCapacity;
            }

            foreach (var service in services)
            {
                if (service.State == ServiceState.Open && service.Sitting.IsActive)
                {
                    availableServices.Add(service);
                    if (!availableDates.Contains(service.Date))
                    {
                        availableDates.Add(service.Date);
                    }
                    var monthYear = new DateTime(service.Date.Year, service.Date.Month, 1);
                    if (!monthsWithYears.Contains(monthYear))
                    {
                        monthsWithYears.Add(monthYear);
                    }
                    if (!years.Contains(service.Date.Year))
                    {
                        years.Add(service.Date.Year);
                    }
                }
            }

            availableDates.Sort();
            monthsWithYears.Sort();
            years.Sort();

            var model = new Models.Allocation.Select
            {
                Years = years,
                MonthsWithYears = monthsWithYears,
                Dates = availableDates,
                Services = availableServices,
                TotalTableCapacity = totalTableCapacity
            };
            return View(model);
        }

        public async Task<IActionResult> Manage(int id)
        {
            var service = await _context.Services
                .Include(s => s.Sitting)
                .Include(s => s.Bookings)
                .ThenInclude(b => b.Customer)
                .FirstOrDefaultAsync(s => s.Id == id);

            var services = await _context.Services
                .Include(s => s.Sitting)
                .Include(s => s.Bookings)
                .ThenInclude(b => b.Customer)
                .Where(s => s.Date == service.Date)
                .ToListAsync();

            var earliestStartTime = new DateTime();
            var latestEndTime = new DateTime();
            var times = new List<DateTime>();
            foreach(var s in services)
            {
                times.Add(s.Sitting.StartTime);
                times.Add(s.Sitting.EndTime);
            }
            times.Sort();
            earliestStartTime = times.ElementAt(0);
            latestEndTime = times.Last();

            var areas = await _context.Areas.Include(a => a.Tables).ThenInclude(t => t.Bookings).ToListAsync();

            var model = new Models.Allocation.Index
            {
                Service = service,
                Services = services,
                Bookings = service.Bookings,
                Areas = areas,
                EarliestStartTime = earliestStartTime,
                LatestEndTime = latestEndTime
            };
            return View(model);
        }
    }
}
