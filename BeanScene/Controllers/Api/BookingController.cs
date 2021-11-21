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

namespace BeanScene.Controllers.Api
{
    [Route("api/booking")]
    [ApiController]
    public class BookingController : ApiBaseController
    {
        public BookingController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        [HttpGet]
        public async Task<IActionResult> GetAllBookings() // All Bookings
        {
            var bookings = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .Include(booking => booking.Tables)
                .Select(booking => new
                {
                    booking.Id,
                    booking.StartTime,
                    booking.Duration,
                    booking.Guests,
                    Status = booking.Status.ToString(),
                    Customer = new
                    {
                        booking.Customer.Id,
                        booking.Customer.FirstName,
                        booking.Customer.LastName
                    },
                    booking.Tables,
                    Service = new
                    {
                        booking.Service.Id,
                        //booking.Service.Date,
                        //booking.Service.MaxCapacity,
                        State = booking.Service.State.ToString(),
                        Sitting = new
                        {
                            booking.Service.Sitting.Id,
                            //MealType = booking.Service.Sitting.MealType.ToString(),
                            //DayOfWeek = booking.Service.Sitting.DayOfWeek.ToString(),
                            //booking.Service.Sitting.StartTime,
                            //booking.Service.Sitting.EndTime,
                            //booking.Service.Sitting.IsActive,
                            //booking.Service.Sitting.TablesInside,
                            //booking.Service.Sitting.TablesOutside,
                            //booking.Service.Sitting.TablesBalcony
                        }
                    }
                })
                .ToListAsync();

            return Ok(bookings);
        }

        // This is being achieved in the service API controller
        // GET: api/booking/##/##/##
        /*[HttpGet, Route("{day}/{month}/{year}")] // Six digit date.
        public async Task<ActionResult<IEnumerable<Booking>>> GetBookingsByDate(string day, string month, string year)
        {
            var date = DateTime.Parse(day + " / " + month + "/" + year);
            var bookings = await _context.Bookings
                .Include(b => b.Customer)
                .Select(b => new
                {
                    b.Id,
                    b.StartTime,
                    b.Duration,
                    b.Guests,
                    Status = b.Status.ToString(),
                    Customer = new
                    {
                        b.Customer.Id,
                        b.Customer.FirstName,
                        b.Customer.LastName
                    },
                    Tables = b.Tables.Select(t => new { t.Id, t.Prefix, t.Seats }).ToList()
                })
                .ToListAsync();

            bookings = bookings.Where(b => b.StartTime.Date == date).ToList();

            return Ok(bookings);
        }*/

        [HttpGet("{id}")] // Booking Id
        public async Task<IActionResult> GetSingleBooking(int id) // Single Booking By Id
        {
            var booking = await _context.Bookings
            .Include(booking => booking.Customer)
            .Include(booking => booking.Service)
            .ThenInclude(service => service.Sitting)
            .Where(booking => booking.Id == id)
            .Select(booking => new
            {
                booking.Id,
                booking.StartTime,
                booking.Guests,
                booking.Status,
                Customer = new
                {
                    booking.Customer.Id,
                },
                Service = new
                {
                    booking.Service.Id,
                    booking.Service.Date,
                        //booking.Service.MaxCapacity,
                        State = booking.Service.State.ToString(),
                    Sitting = new
                    {
                        booking.Service.Sitting.Id,
                        MealType = booking.Service.Sitting.MealType.ToString(),
                        DayOfWeek = booking.Service.Sitting.DayOfWeek.ToString(),
                            //booking.Service.Sitting.StartTime,
                            //booking.Service.Sitting.EndTime,
                            //booking.Service.Sitting.IsActive,
                            //booking.Service.Sitting.TablesInside,
                            //booking.Service.Sitting.TablesOutside,
                            //booking.Service.Sitting.TablesBalcony
                        }
                }
            })
            .FirstOrDefaultAsync();

            return Ok(booking);
        }

        [HttpGet("user/{id}")] // User Id
        public async Task<IActionResult> GetUserBookings(int id) // All Bookings By User Id
        {
            var bookings = await _context.Bookings
                .Include(booking => booking.Customer)
                .Include(booking => booking.Service)
                .ThenInclude(service => service.Sitting)
                .Where(booking => booking.Customer.Id == id)
                .Select(booking => new
                {
                    booking.Id,
                    booking.StartTime,
                    booking.Guests,
                    Status = booking.Status.ToString(),
                    Service = new
                    {
                        booking.Service.Id,
                        booking.Service.Date,
                        //booking.Service.MaxCapacity,
                        State = booking.Service.State.ToString(),
                        Sitting = new
                        {
                            booking.Service.Sitting.Id,
                            MealType = booking.Service.Sitting.MealType.ToString(),
                            DayOfWeek = booking.Service.Sitting.DayOfWeek.ToString(),
                            //booking.Service.Sitting.StartTime,
                            //booking.Service.Sitting.EndTime,
                            //booking.Service.Sitting.IsActive,
                            //booking.Service.Sitting.TablesInside,
                            //booking.Service.Sitting.TablesOutside,
                            //booking.Service.Sitting.TablesBalcony
                        }
                    }
                })
                .ToListAsync();

            bookings = bookings.Where(b => b.StartTime >= DateTime.Now.Date).ToList();
            bookings = bookings.OrderBy(b => b.StartTime).ToList();

            return Ok(bookings);
        }

        [HttpPost]
        public async Task<ActionResult<Service>> PostBooking(Booking booking)
        {
            _context.Bookings.Add(booking);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetBooking", new { id = booking.Id }, booking);
        }

        // PUT api/<BookingController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<BookingController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
