using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using BeanScene.Data;
using System.ComponentModel.DataAnnotations;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using BeanScene.Services;

namespace BeanScene.Pages
{
    public class FeedbackModel : PageModel
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly CustomerService _customerService;
        private readonly IMapper _mapper;

        public FeedbackModel(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper)
        {
            _context = context;
            _userManager = userManager;
            _customerService = customerService;
            _mapper = mapper;
        }

        [BindProperty]
        public InputModel Input { get; set; }

        public class InputModel
        {
            public string Title { get; set; }

            [Required(ErrorMessage = "Please provide a reason for your feedback")]
            public Reason Reason { get; set; }

            public string Comments { get; set; }

            public int Rating { get; set; }     // 0 stars = no rating


            // Optional contact information if the customer would like a reply
            public bool FollowUpRequested { get; set; }
            public string Name { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
        }

        public async Task<IActionResult> OnGetAsync()
        {
            if (User.Identity.IsAuthenticated)      // prefill customer information if logged in
            {
                var user = await _userManager.GetUserAsync(User);
                var customer = await _customerService.FindByUserLoginAsync(user.Id);

                Input = new InputModel
                {
                    Name = $"{customer.FirstName} {customer.LastName}",
                    Email = customer.Email,
                    Phone = customer.Phone,
                };

            }

            return Page();
        }

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }
            if (Input.Title == null && Input.Comments == null && Input.Rating == 0)
            {
                ModelState.AddModelError(string.Empty, "Please fill out at least one other field with your reason");
                return Page();
            }
            if (Input.FollowUpRequested && (Input.Name == null || (Input.Name != null && Input.Email == null && Input.Phone == null)))
            {
                ModelState.AddModelError(string.Empty, "Please provide your name with a contact method so we can get back to you, or unselect the contact option");
                return Page();
            }

            var feedback = _mapper.Map<Feedback>(Input);
            await _context.Feedback.AddAsync(feedback);
            await _context.SaveChangesAsync();

            return RedirectToPage("./ThankYou");
        }
    }
}
