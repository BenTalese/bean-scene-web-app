using BeanScene.Data;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.ServiceModels
{
    public class Create
    {
        //public int Id { get; set; }

        [Required(ErrorMessage = "Please select a Date.")]
        [DataType(DataType.Date)]
        [Display(Name = "Service Date")]
        public DateTime Date { get; set; }

        [Required(ErrorMessage = "Please select a Sitting.")]
        [Display(Name = "Service Sitting")]
        public int Sitting { get; set; }

        //[Required(ErrorMessage = "Please enter Number of Tables.")]  // TODO: Should this be calculated?
        //[Display(Name = "Max Tables")]
        //public int MaxCapacity { get; set; }    // number of guests the restaurant is allowing for for this service/sitting, different to the number of seats in the restaurant

        [Required(ErrorMessage = "Please select a Service State.")]
        [Display(Name = "Service State")]
        public ServiceState State { get; set; }

        //public SelectList Monday { get; set; }
        //public SelectList Tuesday { get; set; }
        //public SelectList Wednesday { get; set; }
        //public SelectList Thursday { get; set; }
        //public SelectList Friday { get; set; }
        //public SelectList Saturday { get; set; }
        //public SelectList Sunday { get; set; }

        //[Display(Name = "Max Pax")]
        //public int MaxPax { get => MaxCapacity * 4; }
        //[Display(Name = "Current Pax")]
        //public int CurrentPax { get => Bookings.Where(b => b.Status != Status.Pending && b.Status != Status.Cancelled).Sum(b => b.Guests); } // TODO: This should only count the confirmed bookings right? (turn this into percentage) (not if this is just a report to the managers?)
        //public int UnassignedPax { get => Bookings.Where(b => b.Status == Status.Pending).Sum(b => b.Guests); }
        //public int Vacancies { get => MaxPax - CurrentPax; }
        //public int Unassigned { get => Bookings.Count(b => b.Status == Status.Pending); }
        //public int Assigned { get => Bookings.Count(b => b.Status != Status.Pending && b.Status != Status.Cancelled); }
        //public int Cancelled { get => Bookings.Count(b => b.Status == Status.Cancelled); }

        //public string WordDate { get => Date.ToLongDateString(); }
        //public string MealType { get => Sitting.MealType.ToString(); }

        //public List<Booking> Bookings { get; set; } = new List<Booking>();
        //public List<Area> Areas { get; set; } = new List<Area>();
    }
}
