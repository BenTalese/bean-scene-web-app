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
using BeanScene.Areas.Admin.Models.AreaModels;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AreaController : AdminAreaBase
    {
        public AreaController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Admin/Area
        public async Task<IActionResult> Manage()
        {
            var areas = await _context.Areas.Include(a => a.Tables).ToListAsync();

            return View(areas);
        }

        // GET: Admin/Area/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var area = await _context.Areas.Include(a => a.Tables).Where(a => a.Id == id).FirstOrDefaultAsync();
            if (area == null)
            {
                return NotFound();
            }

            return View(area);
        }

        // GET: Admin/Area/Create
        public IActionResult CreateArea()
        {
            var area = new AreaTable();
            return View(area);
        }

        // POST: Admin/Area/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateArea(AreaTable areaTable)
        {

            if (ModelState.IsValid)
            {
                var area = new Area
                {
                    Name = areaTable.Name
                };
                _context.Areas.Add(area);
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(CreateTable), "Area", new { areaName = areaTable.Name });
            }
            return View(areaTable);
        }

        //GET: Admin/Area/Create
        [HttpGet]
        public IActionResult CreateTable(string areaName)
        {

            var m = new AreaTable
            {
                Name = areaName,
                Prefix = areaName.Substring(0, 1).ToUpper()
            };

            return View(m);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateTable(AreaTable areaTable)
        {
            if (ModelState.IsValid)
            {
                var areaName = areaTable.Name;
                var area = await _context.Areas.FirstOrDefaultAsync(a => a.Name.Trim().ToLower() == areaTable.Name.Trim().ToLower());

                if (areaTable.Seats > 0)
                {
                    var table = new Table
                    {
                        Prefix = areaTable.Prefix,
                        Seats = areaTable.Seats
                    };

                    area.Tables.Add(table);
                    _context.Update(area);
                    await _context.SaveChangesAsync();
                }

                if (areaTable.TableCreationFinished)
                {
                    return RedirectToAction(nameof(Edit), "Area", new { id = area.Id });    // finish table creation
                }
                return RedirectToAction(nameof(CreateTable), "Area", new { areaName = areaTable.Name });   // continue table creation
            }
            return View(areaTable);     // there was an error
        }

        // GET: Admin/Area/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var area = await _context.Areas.Include(a => a.Tables).FirstOrDefaultAsync(a => a.Id == id);
            if (area == null)
            {
                return NotFound();
            }

            var m = new Models.AreaModels.Edit {
                Id = area.Id,
                Name = area.Name,
                Tables = area.Tables.Select(t=>new AreaEditTable { 
                    Id = t.Id,
                    Name = t.Name,
                    Seats = t.Seats
                }).ToList()
            };
            return View(m);
        }

        // POST: Admin/Area/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Models.AreaModels.Edit m)
        {
            if (id != m.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var area = _context.Areas.FirstOrDefault(a => a.Id == id);
                    area.Name = m.Name; 
                    _context.Update(area);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AreaExists(m.Id))
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
            return View(m);
        }

        // GET: Admin/Area/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var area = await _context.Areas.Include(a => a.Tables).Where(a => a.Id == id).FirstOrDefaultAsync();
            if (area == null)
            {
                return NotFound();
            }

            return View(area);
        }

        // POST: Admin/Area/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var area = await _context.Areas
                .Include(a => a.Tables)
                .ThenInclude(t => t.Bookings)
                .ThenInclude(b => b.Customer)
                .FirstOrDefaultAsync(a => a.Id == id);

            if (area == null)
            {
                return NotFound();
            }

            var futureBookingsInArea = new List<Booking>();
            foreach (var table in area.Tables)
            {
                foreach (var booking in table.Bookings)
                {
                    if (booking.StartTime >= DateTime.Now)
                    {
                        futureBookingsInArea.Add(booking);
                    }
                }
            }

            if (futureBookingsInArea.Count > 0)
            {
                ModelState.AddModelError(string.Empty, "Please relocate future bookings before deleting area:");
                foreach (var booking in futureBookingsInArea)
                {
                    ModelState.AddModelError(string.Empty,
                        $"{booking.Customer.FirstName} {booking.Customer.LastName}, booked at: " +
                        $"{booking.StartTime.ToShortDateString()} - {booking.StartTime.ToShortTimeString()}" +
                        $", for: {booking.Guests}"
                    );
                }
                return View(area);
            }

            foreach (var table in area.Tables)
            {
                _context.Tables.Remove(table);
            }
            _context.Areas.Remove(area);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Manage));
        }


        [HttpGet]
        public async Task<IActionResult> EditTable(int id, int areaId)
        {
            var table = await _context.Tables.FirstOrDefaultAsync(t => t.Id == id);

            var m = new EditTable
            {
                Id = table.Id,
                Name = table.Name,
                Seats = table.Seats,
                AreaId = areaId
            };

            return View(m);
        }

        [HttpPost]
        public async Task<IActionResult> EditTable(EditTable m)
        {
            if (ModelState.IsValid)
            {
                var table = await _context.Tables.FirstOrDefaultAsync(t => t.Id == m.Id);

                if (table == null)
                {
                    return NotFound();
                }

                table.Seats = m.Seats;
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Edit), "Area", new { id = m.AreaId });
            }


            return View(m);
        }

        [HttpGet]
        public async Task<IActionResult> DeleteTable(int id, int areaId)
        {
            var table = await _context.Tables.FirstOrDefaultAsync(t => t.Id == id);

            var m = new EditTable
            {
                Id = table.Id,
                Name = table.Name,
                Seats = table.Seats,
                AreaId = areaId
            };

            return View(m);
        }

        [HttpPost, ActionName("DeleteTable")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteTableConfirmed(EditTable m)
        {
            if (ModelState.IsValid)
            {
                var table = await _context.Tables.Include(t => t.Bookings).ThenInclude(b => b.Customer).FirstOrDefaultAsync(t => t.Id == m.Id);
                
                if (table == null)
                {
                    return NotFound();
                }

                var futureBookingsOnTable = table.Bookings.Where(b => b.StartTime >= DateTime.Now).ToList();
                if (futureBookingsOnTable.Count > 0)
                {
                    ModelState.AddModelError(string.Empty, "Please relocate future bookings before deleting table:");
                    foreach(var booking in futureBookingsOnTable)
                    {
                        ModelState.AddModelError(string.Empty,
                            $"{booking.Customer.FirstName} {booking.Customer.LastName}, booked at: " +
                            $"{booking.StartTime.ToShortDateString()} - {booking.StartTime.ToShortTimeString()}" +
                            $", for: {booking.Guests}"
                        );
                    }
                    m = new EditTable
                    {
                        Id = table.Id,
                        Name = table.Name,
                        Seats = table.Seats,
                        AreaId = m.AreaId
                    };
                    return View(m);
                }

                _context.Tables.Remove(table);
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Edit), "Area", new { id = m.AreaId });
            }


            return View(m);
        }

        private bool AreaExists(int id)
        {
            return _context.Areas.Any(e => e.Id == id);
        }
    }
}
