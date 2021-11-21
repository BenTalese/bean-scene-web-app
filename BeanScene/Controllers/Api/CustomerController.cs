using AutoMapper;
using BeanScene.Data;
using BeanScene.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Controllers.Api
{
    [Route("api/customer")]
    [ApiController]
    public class CustomerController : ApiBaseController
    {
        public CustomerController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        //[HttpGet]
        //public async Task<IActionResult> GetCustomers()
        //{
        //    var users = await _context.Customers.ToListAsync();
        //    return Ok(users);
        //}

        [HttpGet("email/{email}")] // /{password}
        public async Task<int> GetCustomer(string email) // , string password
        {
            int id = -1;
            var customers = await _context.Customers.ToListAsync();
            foreach (var c in customers)
            {
                if (c.Email.ToLower() == email) //  && c.ApplicationUser.PasswordHash == password.ToHashSet().ToString()
                {
                    id = c.Id;
                }
            }
            return id;
        }

        [HttpGet("id/{id}")] // /{password}
        public async Task<Customer> GetCustomer(int id) // , string password
        {
            Customer user = null;
            var customers = await _context.Customers.ToListAsync();
            foreach (var c in customers)
            {
                if (c.Id == id) //  && c.ApplicationUser.PasswordHash == password.ToHashSet().ToString()
                {
                    user = c;
                }
            }
            return user;
        }

        [HttpPost("register")]
        public async Task<IActionResult> PostCustomer([FromBody] Customer customer) // Register model
        {
            _context.Customers.Add(customer);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetService", new { id = customer.Id }, customer);
        }
    }

    public class Register
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }

        [DataType(DataType.Date)]
        public DateTime DateOfBirth { get; set; }

        [Phone]
        public string Phone { get; set; }

        [EmailAddress]
        public string Email { get; set; }

        [StringLength(100, ErrorMessage = "The {0} must be at least {2} and at max {1} characters long.", MinimumLength = 6)]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }
}
