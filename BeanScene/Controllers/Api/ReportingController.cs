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
    [Route("api/reporting")]
    [ApiController]
    public class ReportingController : ApiBaseController
    {
        public ReportingController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        [HttpGet("stats")]
        public async Task<ActionResult> GetStats()
        {
            string[] dayName = new string[7];
            int[] lastWeek = new int[7];
            int[] complete = new int[7];
            int[] noShow = new int[7];

            int[] thisWeek = new int[7];
            int[] breakfast = new int[7];
            int[] lunch = new int[7];
            int[] dinner = new int[7];

            int[] approved = new int[7];
            int[] pending = new int[7];
            int[] nextWeek = new int[7];

            var date = DateTime.Now.Date;
            var day = DateTime.Now.DayOfWeek;
            
            if (day != System.DayOfWeek.Sunday)
            {
                date = DateTime.Now.Date.AddDays(-(int)day);
            }
            
            var startDate = date;
            date = date.AddDays(-7);

            var bookings = await _context.Bookings.Include(booking => booking.Service).ThenInclude(service => service.Sitting).ToListAsync();

            for (var i = 0; i < 14; i++)
            {
                var today = date.AddDays(i);
                if (today < startDate)
                {
                    dayName[i] = today.DayOfWeek.ToString();
                    lastWeek[i] = bookings.Where(b => b.Service.Date == today).Count();
                    complete[i] = bookings.Where(b => b.Service.Date == today && b.Status == Status.Complete).Count();
                    noShow[i] = bookings.Where(b => b.Service.Date == today && b.Status == Status.NoShow).Count();
                }
                else if (today > startDate.AddDays(6)){
                    nextWeek[i-14] = bookings.Where(b => b.Service.Date == today).Count();
                    approved[i-14] = bookings.Where(b => b.Service.Date == today && b.Status == Status.Approved).Count();
                    pending[i-14] = bookings.Where(b => b.Service.Date == today && b.Status == Status.Pending).Count();
                }
                else
                {
                    thisWeek[i-7] = bookings.Where(b => b.Service.Date == today).Count();
                    breakfast[i-7] = bookings.Where(b => b.Service.Date == today && b.Service.Sitting.MealType == MealType.Breakfast).Count();
                    lunch[i-7] = bookings.Where(b => b.Service.Date == today && b.Service.Sitting.MealType == MealType.Lunch).Count();
                    dinner[i-7] = bookings.Where(b => b.Service.Date == today && b.Service.Sitting.MealType == MealType.Dinner).Count();
                }
            }

            var allStats = new { DayNames = dayName, LastWeek = lastWeek, ThisWeek = thisWeek, NextWeek = nextWeek, Complete = complete,
                NoShow = noShow, Approved = approved, Pending = pending, Breakfast = breakfast, Lunch = lunch, Dinner = dinner, };

            return Ok(allStats);
        }

        [HttpGet("status/{status}")]
        public int[] GetCountStatus(string status)
        {
            int[] counts = new int[7]; 
            var date = DateTime.Now.Date;
            var day = DateTime.Now.DayOfWeek;
            var searchValue = Status.NoShow;

            if (day != System.DayOfWeek.Sunday)
            {
                date = DateTime.Now.Date.AddDays(-(int)day);
            }

            switch (status.ToLower())
            {
                case "pending":
                    searchValue = Status.Pending;
                    date = date.AddDays(-7);
                    break;
                case "cancelled":
                    searchValue = Status.Cancelled;
                    break;
                case "complete":
                    searchValue = Status.Complete;
                    break;
                case "approved":
                    searchValue = Status.Approved;
                    date = date.AddDays(-7);
                    break;
                case "noshow":
                    searchValue = Status.NoShow;
                    break;
                default:
                    searchValue = Status.NoShow;
                    break;
            }
            
            var bookings = _context.Bookings.Include(booking => booking.Service).Where(b => b.Status == searchValue).ToList();

            for (var i = 0; i < 7; i++)
            {
                var today = date.AddDays(i);
                counts[i] = bookings.Where(b => b.Service.Date == today).Count();
            }

            return counts;
        }

        [HttpGet("bookings/this")]
        public async Task<int[]> CountBookingsTW()
        {
            int[] counts = new int[7];
            var date = DateTime.Now.Date;
            var day = DateTime.Now.DayOfWeek;

            if (day != System.DayOfWeek.Sunday)
            {
                date = DateTime.Now.Date.AddDays(-(int)day);
            }

            var bookings = await _context.Bookings.Include(booking => booking.Service).ToListAsync();

            for (var i = 0; i < 7; i++)
            {
                var today = date.AddDays(i);
                counts[i] = bookings.Where(b => b.Service.Date == today).Count();
            }

            return counts;
        }

        [HttpGet("bookings/last")]
        public async Task<int[]> CountBookingsLW()
        {
            int[] counts = new int[7];
            var date = DateTime.Now.Date.AddDays(-7);
            var day = DateTime.Now.DayOfWeek;

            if (day != System.DayOfWeek.Sunday)
            {
                date = DateTime.Now.Date.AddDays(-((int)day+7));
            }

            var bookings = await _context.Bookings.Include(booking => booking.Service).ToListAsync();

            for (var i = 0; i < 7; i++)
            {
                var today = date.AddDays(i);
                counts[i] = bookings.Where(b => b.Service.Date == today).Count();
            }

            return counts;
        }

        [HttpGet("service/{service}")]
        public async Task<int[]> CountBookingsService(string service)
        {
            int[] counts = new int[7];
            var date = DateTime.Now.Date;
            var day = DateTime.Now.DayOfWeek;
            var searchValue = MealType.Dinner;

            if (day != System.DayOfWeek.Sunday)
            {
                date = DateTime.Now.Date.AddDays(-(int)day);
            }

            switch (service.ToLower())
            {
                case "breakfast":
                    searchValue = MealType.Breakfast;
                    break;
                case "lunch":
                    searchValue = MealType.Lunch;
                    break;
                case "dinner":
                    searchValue = MealType.Dinner;
                    break;
                default:
                    searchValue = MealType.Dinner;
                    break;
            }

            var bookings = await _context.Bookings.Include(booking => booking.Service).ThenInclude(service => service.Sitting).Where(b => b.Service.Sitting.MealType == searchValue).ToListAsync();

            for (var i = 0; i < 7; i++)
            {
                var today = date.AddDays(i);
                counts[i] = bookings.Where(b => b.Service.Date == today).Count();
            }

            return counts;
        }

    }
}
