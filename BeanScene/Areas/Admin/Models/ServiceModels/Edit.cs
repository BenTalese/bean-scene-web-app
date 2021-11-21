using BeanScene.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.ServiceModels
{
    public class Edit
    {
        [Required(ErrorMessage = "Please enter Number of Tables.")]
        [Display(Name = "Max Tables")]
        public int MaxCapacity { get; set; }

        [Required(ErrorMessage = "Please select a Service State.")]
        [Display(Name = "Service State")]
        public ServiceState State { get; set; }

        public string WordDate { get; set; }
        public string MealType { get; set; }
    }
}
