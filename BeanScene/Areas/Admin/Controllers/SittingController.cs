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
    [Area("Admin"), Authorize(Roles = "Manager,Employee")]
    public class SittingController : AdminAreaBase
    {
        public SittingController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Admin/Sitting
        public async Task<IActionResult> Manage(string sortOrder)
        {
            ViewBag.DaySortParm = String.IsNullOrEmpty(sortOrder) ? "day_desc" : "";
            ViewBag.TypeSortParm = sortOrder == "Type" ? "type_desc" : "Type";
            ViewBag.StatusSortParm = sortOrder == "Status" ? "status_desc" : "Status";

            var sittings = await _context.Sittings.ToListAsync();
            sittings = sittings.OrderBy(s => s.MealType).ToList();

            switch (sortOrder)
            {
                case "day_desc":
                    sittings = sittings.OrderByDescending(s => s.DayOfWeek).ToList();
                    break;
                case "Type":
                    sittings = sittings.OrderBy(s => s.DayOfWeek).ToList(); 
                    sittings = sittings.OrderBy(s => s.MealType).ToList();
                    break;
                case "type_desc":
                    sittings = sittings.OrderBy(s => s.DayOfWeek).ToList();
                    sittings = sittings.OrderByDescending(s => s.MealType).ToList();
                    break;
                case "Status":
                    sittings = sittings.OrderBy(s => s.DayOfWeek).ToList();
                    sittings = sittings.OrderBy(s => s.IsActive).ToList();
                    break;
                case "status_desc":
                    sittings = sittings.OrderBy(s => s.DayOfWeek).ToList();
                    sittings = sittings.OrderByDescending(s => s.IsActive).ToList();
                    break;
                default:
                    sittings = sittings.OrderBy(s => s.DayOfWeek).ToList();
                    break;
            }

            return View(sittings);
        }

        // GET: Admin/Sitting/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sitting = await _context.Sittings
                .FirstOrDefaultAsync(m => m.Id == id);
            if (sitting == null)
            {
                return NotFound();
            }

            return View(sitting);
        }

        // GET: Admin/Sitting/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/Sitting/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,MealType,DayOfWeek,StartTime,EndTime,IsActive,TablesInside,TablesOutside,TablesBalcony")] Sitting sitting)
        {
            if (ModelState.IsValid)
            {
                _context.Add(sitting);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Manage));
            }
            return View(sitting);
        }

        // GET: Admin/Sitting/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sitting = await _context.Sittings.FindAsync(id);
            if (sitting == null)
            {
                return NotFound();
            }
            return View(sitting);
        }

        // POST: Admin/Sitting/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,MealType,DayOfWeek,StartTime,EndTime,IsActive,TablesInside,TablesOutside,TablesBalcony")] Sitting sitting)
        {
            if (id != sitting.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(sitting);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SittingExists(sitting.Id))
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
            return View(sitting);
        }

        // GET: Admin/Sitting/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sitting = await _context.Sittings
                .FirstOrDefaultAsync(m => m.Id == id);
            if (sitting == null)
            {
                return NotFound();
            }

            return View(sitting);
        }

        // POST: Admin/Sitting/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var sitting = await _context.Sittings.FindAsync(id);
            _context.Sittings.Remove(sitting);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Manage));
        }

        private bool SittingExists(int id)
        {
            return _context.Sittings.Any(e => e.Id == id);
        }
    }
}
