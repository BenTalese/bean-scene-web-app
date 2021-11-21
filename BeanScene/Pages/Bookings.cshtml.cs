using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using BeanScene.Data;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Identity;
using BeanScene.Services;
using Microsoft.EntityFrameworkCore;
using AutoMapper;

namespace BeanScene.Pages
{
    public class BookingModel : PageModel
    {
        private readonly ApplicationDbContext _context;
        private readonly UserManager<IdentityUser> _userManager;
        private readonly CustomerService _customerService;
        private readonly IMapper _mapper;

        public BookingModel(ApplicationDbContext context, UserManager<IdentityUser> userManager, CustomerService customerService, IMapper mapper)
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
            [Required(ErrorMessage = "Please select a date")]
            [DataType(DataType.Date)]
            [Display(Name = "Select a date")]
            public DateTime Date { get; set; }

            [Required(ErrorMessage = "Please select a sitting")]
            [Display(Name = "Select a sitting")]
            public MealType MealType { get; set; }

            [Required(ErrorMessage = "Please select a time")]
            [DataType(DataType.Time)]
            [Display(Name = "Select a time")]
            public DateTime StartTime { get; set; }

            public int Guests { get; set; }

            [Display(Name = "Request additional time.")]
            public bool AdditionalTimeRequested { get; set; }   // check mark

            public bool TermsAgreed { get; set; }

            [Required(ErrorMessage = "First name is required")]
            [Display(Name = "First name")]
            public string FirstName { get; set; }

            [Required(ErrorMessage = "Last name is required")]
            [Display(Name = "Last name")]
            public string LastName { get; set; }

            [Required(ErrorMessage = "Email is required")]
            [EmailAddress]
            public string Email { get; set; }

            [Required(ErrorMessage = "Phone number is required")]
            [Phone]
            public string Phone { get; set; }

            [Display(Name = "Additional notes")]
            public string Notes { get; set; }
        }
        public async Task<IActionResult> OnGetAsync()
        {
            Input = new InputModel
            {
                Guests = 1,
                Date = DateTime.Now
            };

            if (User.Identity.IsAuthenticated)      // prefill customer information if logged in
            {
                var user = await _userManager.GetUserAsync(User);
                var customer = await _customerService.FindByUserLoginAsync(user.Id);
                _mapper.Map(customer, Input);
            }

            return Page();
        }

        // To protect from overposting attacks, see https://aka.ms/RazorPagesCRUD
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                Input = new InputModel
                {
                    Date = Input.Date,
                    MealType = Input.MealType,
                    StartTime = Input.StartTime,
                    Guests = Input.Guests,
                    Notes = Input.Notes,
                    FirstName = Input.FirstName,
                    LastName = Input.LastName,
                    Email = Input.Email,
                    Phone = Input.Phone
                };
                return Page();
            }
            else if (!Input.TermsAgreed)
            {
                Input = new InputModel
                {
                    Date = Input.Date,
                    Guests = Input.Guests,
                    Notes = Input.Notes,
                    FirstName = Input.FirstName,
                    LastName = Input.LastName,
                    Email = Input.Email,
                    Phone = Input.Phone
                };
                ModelState.AddModelError(string.Empty, "Please read and agree to the terms of service");
                return Page();
            }

            var customer = await _customerService.FindByEmailAsync(Input.Email);

            if (customer != null && customer.UserLogin != null && !User.Identity.IsAuthenticated)
            {
                // TODO: Decide whether or not this is necessary, technically it won't affect the booking process whether or not they login as it's linked to the customer, not the user.
                // ask them if they'd like to login?
            }

            if (customer == null)
            {
                customer = _mapper.Map<Customer>(Input);
                await _customerService.UpsertAsync(customer);
            }

            var booking = _mapper.Map<Booking>(Input);
            booking.StartTime = Input.Date.Add(Input.StartTime.TimeOfDay);
            booking.Customer = customer;
            booking.Source = Source.Website;
            booking.Status = Status.Pending;
            booking.Service = await _context.Services.FirstOrDefaultAsync
                (
                    s => s.Date == Input.Date &&
                    s.Sitting.MealType == Input.MealType &&
                    s.State == ServiceState.Open &&
                    s.Sitting.IsActive
                );

            if (booking.Service == null)
            {
                Input = new InputModel
                {
                    Guests = Input.Guests,
                    Notes = Input.Notes,
                    FirstName = Input.FirstName,
                    LastName = Input.LastName,
                    Email = Input.Email,
                    Phone = Input.Phone
                };
                ModelState.AddModelError(string.Empty, "Sorry, the selected time slot is no longer taking bookings.");
                return Page();
            }

            var result = _context.Bookings.AddAsync(booking);
            if (!result.IsCompletedSuccessfully)
            {
                Input = new InputModel
                {
                    Guests = Input.Guests,
                    Notes = Input.Notes,
                    FirstName = Input.FirstName,
                    LastName = Input.LastName,
                    Email = Input.Email,
                    Phone = Input.Phone
                };
                ModelState.AddModelError(string.Empty, "Sorry, something went wrong on our end. Please try again.");
                return Page();
            }

            await _context.SaveChangesAsync();

            // TODO: Send email confirmation
            // TODO: Link subscribe button to email service and subscriber list
            return RedirectToPage("./Confirmation", new { booking.Id } );
        }
    }
}
