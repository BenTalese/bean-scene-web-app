using AutoMapper;
using BeanScene.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Services
{
    public class CustomerService
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly IMapper _mapper;

        public CustomerService(ApplicationDbContext context, UserManager<IdentityUser> userManager, IMapper mapper)
        {
            _context = context;
            _userManager = userManager;
            _mapper = mapper;
        }

        public async Task<Customer> FindByEmailAsync(string email)
        {
            return await _context.Customers.FirstOrDefaultAsync(c => c.Email.Trim().ToLower() == email.Trim().ToLower());
        }

        public async Task<Customer> FindByUserLoginAsync(string userLogin)
        {
            return await _context.Customers.FirstOrDefaultAsync(c => c.UserLogin == userLogin);
        }

        public async Task<Customer> CreateAsync(Customer data)
        {
            var customer = new Customer
            {
                FirstName = data.FirstName,
                LastName = data.LastName,
                VisitCount = data.VisitCount,
                Email = data.Email.Trim().ToLower(),
                Phone = data.Phone
            };

            await _context.Customers.AddAsync(customer);
            await _context.SaveChangesAsync();

            return customer;
        }

        public async Task<Customer> UpsertAsync(Customer c)
        {
            var existing = await FindByEmailAsync(c.Email);
            if (existing == null)
            {
                await _context.Customers.AddAsync(c);
            }
            else
            {
                // TODO: Not sure if this actually works yet...
                _mapper.Map(c, existing);
            }
            await _context.SaveChangesAsync();
            return c;
        }
    }
}
