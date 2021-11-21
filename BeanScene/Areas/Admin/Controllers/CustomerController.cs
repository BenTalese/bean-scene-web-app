using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BeanScene.Data;
using AutoMapper;
using BeanScene.Services;
using Microsoft.AspNetCore.Identity;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class CustomerController : AdminAreaBase
    {
        public CustomerController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Admin/Customer
        public async Task<IActionResult> Manage(string sortOrder, string searchString)
        {
            ViewBag.LastSortParm = String.IsNullOrEmpty(sortOrder) ? "last_desc" : "";
            ViewBag.FirstSortParm = sortOrder == "First" ? "first_desc" : "First";

            var customers = await _context.Customers.Include(c => c.ApplicationUser).ToListAsync();

            customers = customers.OrderBy(c => c.FirstName).ToList();
            customers = customers.OrderBy(c => c.LastName).ToList();

            if (!String.IsNullOrEmpty(searchString))
            {
                customers = customers.Where(c => c.LastName.Contains(searchString)
                    || c.Phone.Contains(searchString)).ToList();
            }

            switch (sortOrder)
            {
                case "last_desc":
                    customers = customers.OrderByDescending(c => c.LastName).ToList();
                    break;
                case "First":
                    customers = customers.OrderBy(c => c.FirstName).ToList();
                    break;
                case "first_desc":
                    customers = customers.OrderByDescending(c => c.FirstName).ToList();
                    break;
                default:
                    customers = customers.OrderBy(c => c.LastName).ToList();
                    break;
            }

            return View(customers);
        }

        public async Task<IActionResult> ManageStaff()
        {
            var customers = await _context.Customers.Include(c => c.ApplicationUser).ToListAsync();

            return View(customers);
        }

        // GET: Admin/Customer/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var customer = await _context.Customers
                .Include(c => c.ApplicationUser)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (customer == null)
            {
                return NotFound();
            }

            return View(customer);
        }

        // GET: Admin/Customer/Create
        public IActionResult Create()
        {
            ViewData["UserLogin"] = new SelectList(_context.Set<ApplicationUser>(), "Id", "Id");
            return View();
        }



        // POST: Admin/Customer/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,FirstName,LastName,Email,Phone,VisitCount,Tier,DateOfBirth,UserLogin")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                _context.Add(customer);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Manage));
            }
            ViewData["UserLogin"] = new SelectList(_context.Set<ApplicationUser>(), "Id", "Id", customer.UserLogin);
            return View(customer);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreateStaff([Bind("Id,FirstName,LastName,Email,Phone,VisitCount,Tier,DateOfBirth,UserLogin")] Customer customer)
        {
            if (ModelState.IsValid)
            {
                _context.Add(customer);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Manage));
            }
            ViewData["UserLogin"] = new SelectList(_context.Set<ApplicationUser>(), "Id", "Id", customer.UserLogin);
            return View(customer);
        }

        [HttpGet]
        public async Task<IActionResult> EditMe()
        {
            var customer = new Customer();

            if (User.Identity.IsAuthenticated)
            {
                var user = await _userManager.GetUserAsync(User);
                customer = await _customerService.FindByUserLoginAsync(user.Id);
                if (customer == null)
                {
                    return NotFound();
                }
            }

            ViewData["UserLogin"] = new SelectList(_context.Set<ApplicationUser>(), "Id", "Id", customer.UserLogin);
            return View(customer);

        }
        
        // GET: Admin/Customer/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var customer = await _context.Customers.FindAsync(id);
            if (customer == null)
            {
                return NotFound();
            }
            ViewData["UserLogin"] = new SelectList(_context.Set<ApplicationUser>(), "Id", "Id", customer.UserLogin);
            return View(customer);
        }

        // POST: Admin/Customer/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,FirstName,LastName,Email,Phone,VisitCount,Tier,DateOfBirth,UserLogin")] Customer customer)
        {
            if (id != customer.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(customer);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!CustomerExists(customer.Id))
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
            ViewData["UserLogin"] = new SelectList(_context.Set<ApplicationUser>(), "Id", "Id", customer.UserLogin);
            return View(customer);
        }

        // GET: Admin/Customer/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var customer = await _context.Customers
                .Include(c => c.ApplicationUser)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (customer == null)
            {
                return NotFound();
            }

            return View(customer);
        }

        // POST: Admin/Customer/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var customer = await _context.Customers.FindAsync(id);
            _context.Customers.Remove(customer);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CustomerExists(int id)
        {
            return _context.Customers.Any(e => e.Id == id);
        }
    }
}
