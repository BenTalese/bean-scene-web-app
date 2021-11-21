using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using BeanScene.Data;
using Microsoft.AspNetCore.Identity;
using BeanScene.Services;
using AutoMapper;

namespace BeanScene.Controllers.Api
{
    [Route("api/service")]
    [ApiController]
    public class ServiceController : ApiBaseController
    {
        public ServiceController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: api/Service
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Service>>> GetServices()
        {
            //var services = await _context.Services.Include(s => s.Sitting).ToListAsync();

            var services = await _context.Services
                .Include(service => service.Sitting)
                .Where(service => service.Date >= DateTime.Now.Date && service.Sitting.IsActive)
                .Select(service => new
                {
                    service.Id,
                    service.Date,
                    service.MaxCapacity,
                    State = service.State.ToString(),
                    Sitting = new
                    {
                        service.Sitting.Id,
                        MealType = service.Sitting.MealType.ToString(),
                        DayOfWeek = service.Sitting.DayOfWeek.ToString(),
                        service.Sitting.StartTime,
                        service.Sitting.EndTime,
                        service.Sitting.IsActive,
                        service.Sitting.TablesInside,
                        service.Sitting.TablesOutside,
                        service.Sitting.TablesBalcony
                    }
                })
                .ToListAsync();

            return Ok(services);
        }

        // GET: api/Service/##/##/##
        [HttpGet, Route("{day}/{month}/{year}")] // Six digit date.
        public async Task<ActionResult<IEnumerable<Service>>> GetServicesByDate(string day, string month, string year)
        {
            var date = DateTime.Parse(day + " / " + month + "/" + year);
            var areas = await _context.Areas
                .Include(a => a.Tables)
                .Select(a => new {
                    a.Id,
                    a.Name,
                    Tables = a.Tables.Select(t => new { t.Id, t.Name }).ToList()
                }).ToListAsync();
            var services = await _context.Services
                .Include(s => s.Sitting)
                .Include(s => s.Bookings)
                .ThenInclude(b => b.Customer)
                .Include(s => s.Bookings)
                .ThenInclude(b => b.Tables)
                .Select(s => new
                {
                    s.Id,
                    s.Date,
                    s.MaxCapacity,
                    State = s.State.ToString(),
                    Sitting = new 
                    {
                        s.Sitting.Id,
                        MealType = s.Sitting.MealType.ToString(),
                        DayOfWeek = s.Sitting.DayOfWeek.ToString(),
                        s.Sitting.StartTime,
                        s.Sitting.EndTime,
                        s.Sitting.IsActive
                    },
                    Areas = areas,
                    Bookings = s.Bookings.Select(b => new
                        {
                            b.Id,
                            b.StartTime,
                            b.Duration,
                            b.EndTime,
                            b.Guests,
                            Status = b.Status.ToString(),
                            Customer = new
                            {
                                b.Customer.Id,
                                b.Customer.FirstName,
                                b.Customer.LastName
                            },
                            Tables = b.Tables.Select(t => t.Id).ToList()
                        }).ToList()
                })
                .Where(s => s.Date == date).ToListAsync();

            return Ok(services);
        }

        // GET: api/Service/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Service>> GetService(int id)
        {
            var service = await _context.Services.Include(s => s.Sitting).Where(s => s.Id == id).ToListAsync();
            
            if (service == null)
            {
                return NotFound();
            }

            return Ok(service);
        }

        //// PUT: api/Service/5
        //// To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        //[HttpPut("{id}")]
        //public async Task<IActionResult> PutService(int id, Service service)
        //{
        //    if (id != service.Id)
        //    {
        //        return BadRequest();
        //    }

        //    _context.Entry(service).State = EntityState.Modified;

        //    try
        //    {
        //        await _context.SaveChangesAsync();
        //    }
        //    catch (DbUpdateConcurrencyException)
        //    {
        //        if (!ServiceExists(id))
        //        {
        //            return NotFound();
        //        }
        //        else
        //        {
        //            throw;
        //        }
        //    }

        //    return NoContent();
        //}

        //// POST: api/Service
        //// To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        //[HttpPost]
        //public async Task<ActionResult<Service>> PostService(Service service)
        //{
        //    _context.Services.Add(service);
        //    await _context.SaveChangesAsync();

        //    return CreatedAtAction("GetService", new { id = service.Id }, service);
        //}

        //// DELETE: api/Service/5
        //[HttpDelete("{id}")]
        //public async Task<IActionResult> DeleteService(int id)
        //{
        //    var service = await _context.Services.FindAsync(id);
        //    if (service == null)
        //    {
        //        return NotFound();
        //    }

        //    _context.Services.Remove(service);
        //    await _context.SaveChangesAsync();

        //    return NoContent();
        //}

        //private bool ServiceExists(int id)
        //{
        //    return _context.Services.Any(e => e.Id == id);
        //}
    }
}
