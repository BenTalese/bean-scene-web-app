using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public enum MealType { Breakfast,Lunch,Dinner,Dessert,Drinks,Other }
    public enum DayOfWeek { Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday }
    public class Sitting
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please select sitting type.")]
        [Display(Name = "Type of Sitting")]
        public MealType MealType { get; set; }

        [Required(ErrorMessage = "Please select day of the week.")]
        [Display(Name = "Day of Sitting")]
        public DayOfWeek DayOfWeek { get; set; }

        [Required(ErrorMessage = "Please select a time.")]
        [DataType(DataType.Time)]
        [Display(Name = "Sitting Start Time")] 
        public DateTime StartTime { get; set; }

        [Required(ErrorMessage = "Please select a time.")]
        [DataType(DataType.Time)]
        [Display(Name = "Sitting End Time")] 
        public DateTime EndTime { get; set; }

        [Display(Name = "Sitting Status")]
        public bool IsActive { get; set; }

        //TODO: remove once service/area/table is figured out
        [Display(Name = "Inside Tables")] 
        public int TablesInside { get; set; }   // temp
        [Display(Name = "Outside Tables")] 
        public int TablesOutside { get; set; }  // temp
        [Display(Name = "Balcony Tables")] 
        public int TablesBalcony { get; set; }  // temp

        public string ShortStart { get => StartTime.ToLongTimeString(); }
        public string ShortEnd { get => EndTime.ToLongTimeString(); }
    }
}
