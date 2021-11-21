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

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace BeanScene.Controllers.Api
{
    [Route("api/sitting")]
    [ApiController]
    public class SittingController : ApiBaseController
    {
        public SittingController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: api/sitting
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Sitting>>> GetSittings()
        {
            var sittings = await _context.Sittings.ToListAsync();
            return Ok(sittings);
        }

        // GET: api/sitting/disabled
        [HttpGet, Route("disabled")]
        public async Task<ActionResult<IEnumerable<Sitting>>> GetDisabled()
        {
            var disabled = await _context.Sittings.Where(s=>s.IsActive == false).ToListAsync();

            return Ok(disabled);
        }

        // GET: api/sitting/day/5
        [HttpGet, Route("day/{day}")]
        public async Task<ActionResult<IEnumerable<Sitting>>> GetDisabledDay(int day)
        {
            var disabled = await _context.Sittings.Where(s => (int)s.DayOfWeek == day)
                .Select(sitting => new { sitting.Id, MealType = sitting.MealType.ToString(), }).ToListAsync();

            return Ok(disabled);
        }

        // GET: api/sitting/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Sitting>> Get(int id)
        {
            var sitting = await _context.Sittings.Where(s => s.Id == id).ToListAsync();
            return Ok(sitting);
        }

    }
}
