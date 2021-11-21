using AutoMapper;
using BeanScene.Data;
using BeanScene.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace BeanScene.Controllers.Api
{
    [Route("api/allocation")]
    [ApiController]
    public class AllocationController : ApiBaseController
    {
        public AllocationController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        public class TableReservation
        {
            public int BookingId { get; set; }
            public int TableId { get; set; }
        }

        [HttpPost, Route("assign-tables")]
        [ProducesResponseType(StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> AssignTableReservations([FromBody] List<TableReservation> tableReservationsDTO)
        {
            foreach(var tr in tableReservationsDTO)
            {
                var booking = await _context.Bookings.Include(b => b.Tables).FirstOrDefaultAsync(b => b.Id == tr.BookingId);
                var table = await _context.Tables.FirstOrDefaultAsync(t => t.Id == tr.TableId);
                if (booking == null || table == null)
                {
                    return BadRequest();
                }

                booking.Tables.Add(table);
                if (booking.Table == null || booking.Table == "")
                {
                    booking.Table += table.Name;
                }
                else
                {
                    booking.Table += table.Name + ", ";
                }
                table.Bookings.Add(booking);
                booking.Status = Status.Approved;
            }
            await _context.SaveChangesAsync();
            return Created(nameof(AssignTableReservations), tableReservationsDTO);
        }
        
        [HttpDelete, Route("unassign-tables")]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public async Task<IActionResult> UnassignTableReservations([FromBody] List<TableReservation> tableReservationsDTO)
        {
            foreach (var tr in tableReservationsDTO)
            {
                var booking = await _context.Bookings.Include(b => b.Tables).FirstOrDefaultAsync(b => b.Id == tr.BookingId);
                var table = await _context.Tables.FirstOrDefaultAsync(t => t.Id == tr.TableId);
                if (booking == null || table == null)
                {
                    return BadRequest();
                }

                booking.Tables.Remove(table);
                table.Bookings.Remove(booking);
                if (booking.Tables.Count == 0)
                {
                    booking.Status = Status.Pending;
                }
            }
            await _context.SaveChangesAsync();
            return NoContent();
        }
    }
}
