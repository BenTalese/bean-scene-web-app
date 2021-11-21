using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BeanScene.Data;
using Microsoft.AspNetCore.Authorization;
using BeanScene.Services;
using AutoMapper;
using Microsoft.AspNetCore.Identity;

namespace BeanScene.Areas.Admin.Controllers
{
    [Area("Admin"), Authorize(Roles = "Manager,Employee")]
    public class FeedbackController : AdminAreaBase
    {
        public FeedbackController(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper) : base(context, userManager, customerService, mapper)
        {
        }

        // GET: Admin/Feedback
        public async Task<IActionResult> Manage(string sortOrder)
        {
            ViewBag.RatingSortParm = String.IsNullOrEmpty(sortOrder) ? "rating_desc" : "";
            ViewBag.ReasonSortParm = sortOrder == "Reason" ? "reason_desc" : "Reason";
            ViewBag.RequestSortParm = sortOrder == "Request" ? "request_desc" : "Request";
            
            var feedback = await _context.Feedback.ToListAsync();

            feedback = feedback.OrderBy(s => s.Rating).ToList();

            switch (sortOrder)
            {
                case "rating_desc":
                    feedback = feedback.OrderByDescending(s => s.Rating).ToList();
                    break;
                case "Reason":
                    feedback = feedback.OrderBy(s => s.Reason.ToString()).ToList();
                    break;
                case "reason_desc":
                    feedback = feedback.OrderByDescending(s => s.Reason.ToString()).ToList();
                    break;
                case "Request":
                    feedback = feedback.OrderByDescending(s => s.FollowUpRequested).ToList();
                    break;
                case "request_desc":
                    feedback = feedback.OrderBy(s => s.FollowUpRequested).ToList();
                    break;
                default:
                    feedback = feedback.OrderBy(s => s.Rating).ToList();
                    break;
            }

            return View(feedback);
        }

        // GET: Admin/Feedback/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var feedback = await _context.Feedback
                .FirstOrDefaultAsync(m => m.Id == id);
            if (feedback == null)
            {
                return NotFound();
            }

            return View(feedback);
        }

        // GET: Admin/Feedback/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Admin/Feedback/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,Title,Reason,Comments,Rating")] Feedback feedback)
        {
            if (ModelState.IsValid)
            {
                _context.Add(feedback);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Manage));
            }
            return View(feedback);
        }

        // GET: Admin/Feedback/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var feedback = await _context.Feedback
                .FirstOrDefaultAsync(m => m.Id == id);
            if (feedback == null)
            {
                return NotFound();
            }

            return View(feedback);
        }

        // POST: Admin/Feedback/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var feedback = await _context.Feedback.FindAsync(id);
            _context.Feedback.Remove(feedback);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Manage));
        }

        private bool FeedbackExists(int id)
        {
            return _context.Feedback.Any(e => e.Id == id);
        }
    }
}
