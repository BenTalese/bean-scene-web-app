using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    // TODO: If a VIP or VVIP is coming, alert the staff and manager
    public enum Tier { Guest, Member, Patron, VIP, VVIP }

    public class Customer
    {
        // [GUEST]
        // Guest properties (always needed)
        public int Id { get; set; }
        [Required(ErrorMessage = "Please enter your first name.")]
        [Display(Name = "First Name")] 
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Please enter your last name.")]
        [Display(Name = "Last Name")] 
        public string LastName { get; set; }
        [Required(ErrorMessage = "Please enter your email address.")]
        [Display(Name = "Email Address")] 
        public string Email { get; set; }
        [Required(ErrorMessage = "Please enter your phone number.")]
        [Display(Name = "Mobile Phone")] 
        public string Phone { get; set; }
        [Display(Name = "Visit Count")]
        public int VisitCount { get; set; }
        [Display(Name = "VIP Status")]
        public Tier Tier { get; set; }


        // [MEMBER]
        // Additional member properties
        //[Required(ErrorMessage = "Please enter your date of birth.")]
        [DataType(DataType.Date)]
        //[DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{dd/MMMM/yyyy}")]
        [Display(Name = "Date Of Birth")] 
        public DateTime DateOfBirth { get; set; }
        public string UserLogin { get; set; }


        public List<Booking> Bookings { get; set; } = new List<Booking>();
        public ApplicationUser ApplicationUser { get; set; }

        public string LongDate { get => DateOfBirth.ToShortDateString(); }
    }
}
