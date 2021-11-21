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
using BeanScene.Areas.Admin.Models.ServiceModels;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin"), Authorize(Roles = "Manager,Employee")]
    public class ServiceController : AdminAreaBase
    {
        public ServiceController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Admin/Service
        public async Task<IActionResult> Manage(string selectOption, string sortOrder)
        {
            ViewBag.DateSortParm = String.IsNullOrEmpty(sortOrder) ? "date_desc" : "";
            ViewBag.TypeSortParm = sortOrder == "Type" ? "type_desc" : "Type";
            ViewBag.VacancySortParm = sortOrder == "Vacancy" ? "vacancy_desc" : "Vacancy";
            ViewBag.PendingSortParm = sortOrder == "Pending" ? "pending_desc" : "Pending";

            var services = await _context.Services.Include(s => s.Sitting).Include(s => s.Bookings).ToListAsync();

            //switch (selectOption)
            //{
            //    case "Week":
            //        services = services.Where(s => s.Date < DateTime.Now.AddDays(7)).ToList();
            //        break;
            //    case "Next":
            //        services = services.Where(s => s.Date > DateTime.Now.AddDays(7) && s.Date < DateTime.Now.AddDays(14)).ToList();
            //        break;
            //    case "Month":
            //        services = services = services.Where(s => s.Date < DateTime.Now.AddDays(28)).ToList();
            //        break;
            //    default:
            //        break;
            //}

            services = services.Where(s => s.Date >= DateTime.Now.Date).ToList();
            services = services.OrderBy(s => s.Sitting.MealType).ToList();
            services = services.OrderBy(s => s.Date).ToList();

            switch (sortOrder)
            {
                case "date_desc":
                    services = services.OrderByDescending(s => s.Date).ToList();
                    break;
                case "Type":
                    services = services.OrderBy(s => s.Sitting.MealType).ToList();
                    break;
                case "type_desc":
                    services = services.OrderByDescending(s => s.Sitting.MealType).ToList();
                    break;
                case "Vacancy":
                    services = services.OrderBy(s => s.Vacancies).ToList();
                    break;
                case "vacancy_desc":
                    services = services.OrderByDescending(s => s.Vacancies).ToList();
                    break;
                case "Pending":
                    services = services.OrderBy(s => s.UnassignedPax).ToList();
                    break;
                case "pending_desc":
                    services = services.OrderByDescending(s => s.UnassignedPax).ToList();
                    break;
                default:
                    services = services.OrderBy(s => s.Date).ToList();
                    break;
            }

            return View(services);
        }

        // GET: Admin/Service/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var service = await _context.Services.Include(s => s.Sitting).Include(s => s.Bookings)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (service == null)
            {
                return NotFound();
            }

            return View(service);
        }

        // GET: Admin/Service/Create
        public async Task<IActionResult> Create()
        {
            var sittings = await _context.Sittings.Where(s =>s.IsActive == false).ToListAsync();

            Create input = new Create
            {
                Date = DateTime.Now.Date,
                //    Monday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Monday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
                //    Tuesday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Tuesday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
                //    Wednesday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Wednesday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
                //    Thursday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Thursday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
                //    Friday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Friday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
                //    Saturday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Saturday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
                //    Sunday = new SelectList(_context.Sittings.Where(s => s.IsActive == false && s.DayOfWeek == Data.DayOfWeek.Sunday).ToArray(), nameof(Sitting.Id), nameof(Sitting.MealType)),
            };

            return View(input);
        }

        // POST: Admin/Service/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Date,Sitting,MaxCapacity,State")] Create create)
        {
            if (ModelState.IsValid)
            {
                int sittingId = (create.Sitting);
                var sitting = await _context.Sittings.Where(s => s.Id == sittingId).FirstOrDefaultAsync();
                var service = new Service
                {
                    Date = create.Date,
                    Sitting = sitting,
                    MaxCapacity = sitting.TablesBalcony + sitting.TablesInside + sitting.TablesOutside,
                    State = create.State,
                };

                _context.Add(service);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Manage));
            }
            return View(create);
        }

        // GET: Admin/Service/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            var service = await _context.Services.Include(s => s.Sitting).Where(s => s.Id == id).FirstOrDefaultAsync();
            if (service == null)
            {
                return NotFound();
            }

            Edit input = new Edit
            {
                MaxCapacity = service.MaxCapacity,
                State = service.State,
                WordDate = service.WordDate,
                MealType = service.MealType,
            };

            return View(input);
        }

        // POST: Admin/Service/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to..
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Edit input )
        {
            if (ModelState.IsValid)
            {
                var service = await _context.Services.Include(s => s.Sitting).Where(s => s.Id == id).FirstOrDefaultAsync(); 
                try
                {
                    service.MaxCapacity = input.MaxCapacity;
                    service.State = input.State;
                    _context.Update(service);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ServiceExists(service.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Manage));
            }
            return View(input);
        }

        // GET: Admin/Service/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var service = await _context.Services.Include(s => s.Sitting).Include(s => s.Bookings)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (service == null)
            {
                return NotFound();
            }

            return View(service);
        }

        // POST: Admin/Service/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var service = await _context.Services.FindAsync(id);
            _context.Services.Remove(service);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Manage));
        }

        public IActionResult UpsertWeek()
        {
            return View();
        }

        public IActionResult UpsertOne()
        {
            return View();
        }

        public IActionResult UpsertThree()
        {
            return View();
        }

        [HttpPost, ActionName("Upsert")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpsertConfirmed(int value)
        {
            var sittings = await _context.Sittings.Where(s => s.IsActive == true).ToListAsync();
            var existingServices = await _context.Services.Include(s => s.Sitting).ToListAsync();

            for (var i = 1; i <= value; i++)
            {
                var today = DateTime.Now.AddDays(i);
                var sittingsToday = sittings.Where(s => s.DayOfWeek.ToString() == today.DayOfWeek.ToString());
                var existingToday = existingServices.Where(e => e.Date.ToShortDateString() == today.ToShortDateString());

                foreach (var s in sittingsToday)
                {
                    var exists = false;
                    if (existingToday != null)
                    {
                        foreach (var e in existingToday)
                        {
                            if (e.Sitting.Id == s.Id)
                            {
                                exists = true;
                            }
                        }
                    }
                    if (exists != true)
                    {
                        var service = new Service
                        {
                            Date = today.Date,
                            Sitting = s,
                            MaxCapacity = s.TablesInside + s.TablesOutside + s.TablesBalcony,
                            State = ServiceState.Open
                        };
                        _context.Services.Add(service);
                    }

                }
            }
            _context.SaveChanges();
            return RedirectToAction(nameof(Manage));
        }

        private bool ServiceExists(int id)
        {
            return _context.Services.Any(e => e.Id == id);
        }
    }
}
