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
using BeanScene.Areas.Admin.Models.BookingModels;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class BookingController : AdminAreaBase
    {
        public BookingController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Admin/Booking
        public async Task<IActionResult> Manage(string sortOrder, string searchString)
        {
            ViewBag.DateSortParm = String.IsNullOrEmpty(sortOrder) ? "date_desc" : "";
            ViewBag.TypeSortParm = sortOrder == "Type" ? "type_desc" : "Type";
            ViewBag.StatusSortParm = sortOrder == "Status" ? "status_desc" : "Status";

            var bookings = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .ToListAsync();

            bookings = bookings.Where(b => b.StartTime >= DateTime.Now.Date).ToList();
            bookings = bookings.OrderBy(b => b.StartTime).ToList();

            if (!String.IsNullOrEmpty(searchString))
            {
                bookings = bookings.Where(b => b.Customer.LastName.Contains(searchString)
                    || b.Customer.Phone.Contains(searchString)).ToList();
            }

            switch (sortOrder)
            {
                case "date_desc":
                    bookings = bookings.OrderByDescending(s => s.StartTime).ToList();
                    break;
                case "Type":
                    bookings = bookings.OrderBy(s => s.Service.Sitting.MealType).ToList();
                    break;
                case "type_desc":
                    bookings = bookings.OrderByDescending(s => s.Service.Sitting.MealType).ToList();
                    break;
                case "Status":
                    bookings = bookings.OrderBy(s => s.Status).ToList();
                    break;
                case "status_desc":
                    bookings = bookings.OrderByDescending(s => s.Status).ToList();
                    break;
                default:
                    bookings = bookings.OrderBy(s => s.StartTime).ToList();
                    break;
            }

            return View(bookings);
        }

        public async Task<IActionResult> ManagePending(string sortOrder)
        {
            ViewBag.DateSortParm = String.IsNullOrEmpty(sortOrder) ? "date_desc" : "";
            ViewBag.TypeSortParm = sortOrder == "Type" ? "type_desc" : "Type";
            ViewBag.StatusSortParm = sortOrder == "Status" ? "status_desc" : "Status";

            var bookings = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .Where(booking => booking.Status == Status.Pending)
                .ToListAsync();

            bookings = bookings.Where(b => b.StartTime >= DateTime.Now.Date).ToList(); 
            bookings = bookings.OrderBy(b => b.StartTime).ToList();

            switch (sortOrder)
            {
                case "date_desc":
                    bookings = bookings.OrderByDescending(s => s.StartTime).ToList();
                    break;
                case "Type":
                    bookings = bookings.OrderBy(s => s.Service.Sitting.MealType).ToList();
                    break;
                case "type_desc":
                    bookings = bookings.OrderByDescending(s => s.Service.Sitting.MealType).ToList();
                    break;
                case "Status":
                    bookings = bookings.OrderBy(s => s.Status).ToList();
                    break;
                case "status_desc":
                    bookings = bookings.OrderByDescending(s => s.Status).ToList();
                    break;
                default:
                    bookings = bookings.OrderBy(s => s.StartTime).ToList();
                    break;
            }

            return View(bookings);
        }

        public async Task<IActionResult> ManageToday(string sortOrder, string searchString)
        {
            ViewBag.DateSortParm = String.IsNullOrEmpty(sortOrder) ? "date_desc" : "";
            ViewBag.TypeSortParm = sortOrder == "Type" ? "type_desc" : "Type";
            ViewBag.StatusSortParm = sortOrder == "Status" ? "status_desc" : "Status";
            
            var now = DateTime.Now.Date;
            var bookings = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .Where(booking => booking.StartTime.Date == now)
                .ToListAsync();

            bookings = bookings.Where(b => b.StartTime >= DateTime.Now.Date).ToList(); 
            bookings = bookings.OrderBy(b => b.StartTime).ToList();

            if (!String.IsNullOrEmpty(searchString))
            {
                bookings = bookings.Where(b => b.Customer.LastName.Contains(searchString)
                    || b.Customer.Phone.Contains(searchString)).ToList();
            }

            switch (sortOrder)
            {
                case "date_desc":
                    bookings = bookings.OrderByDescending(s => s.StartTime).ToList();
                    break;
                case "Type":
                    bookings = bookings.OrderBy(s => s.Service.Sitting.MealType).ToList();
                    break;
                case "type_desc":
                    bookings = bookings.OrderByDescending(s => s.Service.Sitting.MealType).ToList();
                    break;
                case "Status":
                    bookings = bookings.OrderBy(s => s.Status).ToList();
                    break;
                case "status_desc":
                    bookings = bookings.OrderByDescending(s => s.Status).ToList();
                    break;
                default:
                    bookings = bookings.OrderBy(s => s.StartTime).ToList();
                    break;
            }

            return View(bookings);
        }

        // GET: Admin/Booking/Details/5
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

        // GET: Admin/Booking/Create
        public IActionResult Create()
        {

            var input = new Create
            {
                Guests = 1,
                Date = DateTime.Now
            };

            return View(input);
        }

        // GET: Admin/Booking/Create
        public async Task<IActionResult> CreateExisting(int id)
        {
            var customer = await _context.Customers.FirstOrDefaultAsync(c => c.Id == id);
            var input = new Create
            {
                Guests = 1,
                Date = DateTime.Now,
                Customer = customer,
                FirstName = customer.FirstName,
                LastName = customer.LastName,
                Email = customer.Email,
                Phone = customer.Phone,                
            };

            return View(input);
        }

        // POST: Admin/Booking/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,StartTime,MealType,Duration,Guests,Notes,Source,Status,Table,FirstName,LastName,Email,Phone,Date")] Create model)
        {
            if (ModelState.IsValid)
            {
                var customer = await _customerService.FindByEmailAsync(model.Email);

                if (customer == null)
                {
                    customer = _mapper.Map<Customer>(model);
                    await _customerService.UpsertAsync(customer);
                }

                var booking = _mapper.Map<Booking>(model);
                booking.StartTime = model.Date.Add(model.StartTime.TimeOfDay);
                booking.Customer = customer;
                booking.Source = Source.InPerson;
                booking.Status = Status.Pending;
                var services = await _context.Services.Include(s => s.Sitting).ToListAsync();
                foreach (var s in services)
                {
                    var serviceDate = s.Date;
                    var modelDate = model.Date;
                    if (s.Date == model.Date)
                    {
                        if(s.Sitting.MealType == model.MealType)
                        {
                            Console.WriteLine("");
                        }
                    }
                }

                booking.Service = await _context.Services.FirstOrDefaultAsync
                    (
                        s => s.Date == model.Date &&
                        s.Sitting.MealType == model.MealType
                    );

                var result = _context.Bookings.AddAsync(booking);
                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Manage));
            }
            return View(model);
        }

        // GET: Admin/Booking/Edit/5
        public async Task<IActionResult> Edit(int? id)
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

        // POST: Admin/Booking/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,StartTime,Duration,Guests,Notes,Source,Status,Table")] Booking booking)
        {
            if (id != booking.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
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
                return RedirectToAction(nameof(Manage));
            }
            return View(booking);
        }

        // GET: Admin/Booking/Approve/5
        public async Task<IActionResult> Approve(int? id)
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

        // GET: Admin/Booking/Cancel/5
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

            ViewBag.returnUrl = Request.Headers["Referer"].ToString();

            return View(booking);
        }

        // GET: Admin/Booking/Approve/5
        public async Task<IActionResult> Seated(int? id)
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

        // GET: Admin/Booking/Cancel/5
        public async Task<IActionResult> Complete(int? id)
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

        // GET: Admin/Booking/Approve/5
        public async Task<IActionResult> NoShow(int? id)
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

        // POST: Admin/Booking/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            _context.Bookings.Remove(booking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Manage));
        }

        [HttpPost, ActionName("Approve")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> ApproveConfirmed(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            booking.Status = Status.Approved;
            _context.Update(booking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ManagePending));
        }

        [HttpPost, ActionName("Cancel")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CancelConfirmed(int id, string returnUrl)
        {
            var booking = await _context.Bookings.FindAsync(id);
            booking.Status = Status.Cancelled;
            _context.Update(booking);
            await _context.SaveChangesAsync();
            return Redirect(returnUrl);
        }

        [HttpPost, ActionName("Seated")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> SeatedConfirmed(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            booking.Status = Status.Seated;
            _context.Update(booking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ManageToday));
        }

        [HttpPost, ActionName("Complete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CompleteConfirmed(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            booking.Status = Status.Complete;
            _context.Update(booking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ManageToday));
        }

        [HttpPost, ActionName("NoShow")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> NoShowConfirmed(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            booking.Status = Status.NoShow;
            _context.Update(booking);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(ManageToday));
        }

        private bool BookingExists(int id)
        {
            return _context.Bookings.Any(e => e.Id == id);
        }
    }
}
