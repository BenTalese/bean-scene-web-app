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
using BeanScene.Areas.Member.Models.BookingModels;
using System.Globalization;

namespace BeanScene.Areas.Member.Controllers
{
    [Area("Member")]
    public class BookingController : MemberAreaBase
    {
        public BookingController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Member/Booking
        public async Task<IActionResult> Index()
        {
            var user = await _userManager.GetUserAsync(User);
            var customer = await _customerService.FindByUserLoginAsync(user.Id);

            var bookings = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .Where(booking => booking.Customer.Id == customer.Id)
                .ToListAsync();

            bookings = bookings.Where(b => b.StartTime > DateTime.Now).ToList(); 
            bookings = bookings.OrderBy(b => b.StartTime).ToList();

            return View(bookings);
        }

        // GET: Member/Booking/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var booking = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (booking == null)
            {
                return NotFound();
            }

            return View(booking);
        }

        // GET: Member/Booking/Create
        //public IActionResult Create()
        //{
        //    return View();
        //}

        //// POST: Member/Booking/Create
        //// To protect from overposting attacks, enable the specific properties you want to bind to.
        //// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> Create([Bind("Id,StartTime,Duration,Guests,Notes,Source,Status,Table")] Booking booking)
        //{
        //    if (ModelState.IsValid)
        //    {
        //        _context.Add(booking);
        //        await _context.SaveChangesAsync();
        //        return RedirectToAction(nameof(Index));
        //    }
        //    return View(booking);
        //}

        // GET: Member/Booking/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            var booking = await _context.Bookings.Include(b=>b.Service).ThenInclude(s=>s.Sitting).Where(b=>b.Id==id).FirstOrDefaultAsync();
            if (booking == null)
            {
                return NotFound();
            }

            DateTime start = booking.Service.Sitting.StartTime;
            DateTime finish = booking.Service.Sitting.EndTime;

            List<string> times = new List<string>();

            while (start < finish)
            {
                times.Add(start.ToShortTimeString());
                start = start.AddMinutes(15);
            }
            
            Edit input = new Edit
            {
                Time = booking.StartTime.ToShortDateString(),
                Guests = booking.Guests,
                AdditionalTimeRequested = booking.AdditionalTimeRequested,
                Notes = booking.Notes,
                Times = new SelectList(times),
            };

            return View(input);
        }

        // POST: Member/Booking/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Edit input)
        {
            if (ModelState.IsValid)
            {
                var booking = await _context.Bookings.Where(b => b.Id == id).FirstOrDefaultAsync();
                try
                {
                    booking.StartTime = DateTime.Parse(input.Time);
                    booking.Guests = input.Guests;
                    booking.AdditionalTimeRequested = input.AdditionalTimeRequested;
                    booking.Notes = input.Notes;
                    booking.Status = Status.Pending;
                    booking.Table = null;
                    _context.Update(booking);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!BookingExists(booking.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(input);
        }

        // GET: Member/Booking/Delete/5
        //public async Task<IActionResult> Delete(int? id)
        //{
        //    if (id == null)
        //    {
        //        return NotFound();
        //    }

        //    var booking = await _context.Bookings
        //        .FirstOrDefaultAsync(m => m.Id == id);
        //    if (booking == null)
        //    {
        //        return NotFound();
        //    }

        //    return View(booking);
        //}

        //// POST: Member/Booking/Delete/5
        //[HttpPost, ActionName("Delete")]
        //[ValidateAntiForgeryToken]
        //public async Task<IActionResult> DeleteConfirmed(int id)
        //{
        //    var booking = await _context.Bookings.FindAsync(id);
        //    _context.Bookings.Remove(booking);
        //    await _context.SaveChangesAsync();
        //    return RedirectToAction(nameof(Index));
        //}

        private bool BookingExists(int id)
        {
            return _context.Bookings.Any(e => e.Id == id);
        }

        // GET: Member/Booking/Cancel/5
        public async Task<IActionResult> Cancel(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var booking = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (booking == null)
            {
                return NotFound();
            }

            return View(booking);
        }

        // POST: Member/Booking/Cancel/5
        [HttpPost, ActionName("Cancel")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CancelConfirmed(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            booking.Status = Status.Cancelled;
            booking.Table = null;
            _context.Update(booking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
    }
}
