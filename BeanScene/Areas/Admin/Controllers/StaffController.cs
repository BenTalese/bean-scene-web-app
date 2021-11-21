using AutoMapper;
using BeanScene.Data;
using BeanScene.Services;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.AspNetCore.WebUtilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Controllers
{
    public class StaffController : AdminAreaBase
    {
        public StaffController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(Models.Staff.Create m)
        {
            if (ModelState.IsValid)
            {
                var user = new IdentityUser { UserName = m.UserName, Email = m.Email, PhoneNumber = m.Phone };
                var result = new IdentityResult();
                var existingUser = await _userManager.FindByEmailAsync(m.Email);


                if (existingUser != null)
                {
                    ModelState.AddModelError(string.Empty, "An account already exists with this email. Do you wish to login?");
                }
                else
                {
                    result = await _userManager.CreateAsync(user, m.Password);
                }

                if (result.Succeeded && existingUser == null)
                {
                    if (m.IsManager)
                    {
                        await _userManager.AddToRoleAsync(user, nameof(Role.Manager));
                    } else
                    {
                        await _userManager.AddToRoleAsync(user, nameof(Role.Employee));
                    }

                    // TODO: Took out the code for sending confirmation email, can implement it later

                    return RedirectToAction(nameof(Manage));
                }
                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError(string.Empty, error.Description);
                }
            }
            return View(m);
        }

        public async Task<IActionResult> Manage()
        {
            var managers = new List<IdentityUser>();
            var staff = new List<IdentityUser>();

            foreach (var user in _userManager.Users)
            {
                if (await _userManager.IsInRoleAsync(user, nameof(Role.Manager)))
                {
                    managers.Add(user);
                }
                if (await _userManager.IsInRoleAsync(user, nameof(Role.Employee)))
                {
                    staff.Add(user);
                }
            }

            var m = new Models.Staff.Manage
            {
                Managers = managers,
                Staff = staff
            };
            return View(m);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            bool isManager = await _userManager.IsInRoleAsync(user, nameof(Role.Manager));

            var m = new Models.Staff.Edit
            {
                Id = user.Id,
                UserName = user.UserName,
                Email = user.Email,
                Phone = user.PhoneNumber,
                IsManager = isManager
            };

            return View(m);
        }

        [HttpPost]
        public async Task<IActionResult> Edit(Models.Staff.Edit m)
        {
            if (ModelState.IsValid)
            {
                var user = await _userManager.FindByIdAsync(m.Id);

                if (user == null)
                {
                    ModelState.AddModelError(string.Empty, "Error: Could not find employee.");
                    return View(m);
                }
                else
                {
                    await _userManager.SetUserNameAsync(user, m.UserName);
                    await _userManager.SetEmailAsync(user, m.Email);
                    await _userManager.SetPhoneNumberAsync(user, m.Phone);
                    if (m.OldPassword != null && m.NewPassword != null)
                    {
                        await _userManager.ChangePasswordAsync(user, m.OldPassword, m.NewPassword);
                    } else if (m.NewPassword != null)
                    {
                        ModelState.AddModelError(string.Empty, "Error: Please enter existing password.");
                        return View(m);
                    }
                    
                    if (m.IsManager)
                    {
                        await _userManager.RemoveFromRoleAsync(user, nameof(Role.Employee));
                        await _userManager.AddToRoleAsync(user, nameof(Role.Manager));
                    }
                    else
                    {
                        await _userManager.RemoveFromRoleAsync(user, nameof(Role.Manager));
                        await _userManager.AddToRoleAsync(user, nameof(Role.Employee));
                    }
                }

                return RedirectToAction(nameof(Manage));
            }

            return View(m);
        }

        [HttpGet]
        public async Task<IActionResult> Delete(string id)
        {

            if (id == null)
            {
                return NotFound();
            }

            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            var m = new Models.Staff.Delete
            {
                Id = user.Id,
                UserName = user.UserName,
                Email = user.Email,
                Phone = user.PhoneNumber
            };

            return View(m);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var user = await _userManager.FindByIdAsync(id);
            if (user != null)
            {
                await _userManager.DeleteAsync(user);
                return RedirectToAction(nameof(Manage));
            }

            return BadRequest();
        }
    }
}
