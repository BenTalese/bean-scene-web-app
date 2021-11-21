using BeanScene.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.BookingModels
{
    public class Create
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

        [Display(Name = "Request additional time")]
        public bool AdditionalTimeRequested { get; set; }   // check mark

        public bool TermsAgreed { get; set; }

        [Required(ErrorMessage = "First name is required")]
        [Display(Name = "First Name")]
        public string FirstName { get; set; }

        [Required(ErrorMessage = "Last name is required")]
        [Display(Name = "Last Name")]
        public string LastName { get; set; }

        [Required(ErrorMessage = "Email is required")]
        [EmailAddress]
        public string Email { get; set; }

        [Required(ErrorMessage = "Phone number is required")]
        [Phone]
        public string Phone { get; set; }

        [Display(Name = "Additional notes")]
        public string Notes { get; set; }

        public Customer Customer { get; set; }
    }
}
