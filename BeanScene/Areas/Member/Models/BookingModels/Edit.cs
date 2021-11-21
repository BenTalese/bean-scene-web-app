using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Member.Models.BookingModels
{
    public class Edit
    {
        [Required(ErrorMessage = "Please select a time")]
        [DataType(DataType.Time)]
        [Display(Name = "Start Time")]
        public string Time { get; set; }
        public int Guests { get; set; }

        [Display(Name = "Request additional time.")]
        public bool AdditionalTimeRequested { get; set; }
        public string Notes { get; set; }
        public SelectList Times { get; set; }
    }
}
