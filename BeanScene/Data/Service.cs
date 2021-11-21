using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public enum ServiceState { Open,Closed }
    public class Service
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please select a Date.")]
        [DataType(DataType.Date)]
        [Display(Name = "Service Date")] 
        public DateTime Date { get; set; }

        [Required(ErrorMessage = "Please select a Sitting.")]
        [Display(Name = "Service Sitting")] 
        public Sitting Sitting { get; set; }

        [Required(ErrorMessage = "Please enter Number of Tables.")]  // TODO: Should this be calculated?
        [Display(Name = "Max Tables")] 
        public int MaxCapacity { get; set; }    // number of guests the restaurant is allowing for for this service/sitting, different to the number of seats in the restaurant (just show a message box on allocation page saying "you're at max capacity for this sitting, continue assignment?")

        [Required(ErrorMessage = "Please select a Service State.")]
        [Display(Name = "Service State")] 
        public ServiceState State { get; set; }

        [Display(Name = "Max Pax")] 
        public int MaxPax { get => MaxCapacity * 4; }
        [Display(Name = "Current Pax")] 
        public int CurrentPax { get => Bookings.Where(b => b.Status != Status.Pending && b.Status != Status.Cancelled && b.Status != Status.NoShow).Sum(b => b.Guests); }
        public int UnassignedPax { get => Bookings.Where(b => b.Status == Status.Pending).Sum(b => b.Guests); }
        public int Vacancies { get => MaxPax - CurrentPax; }
        public int AssignedTableCount { get => Bookings.Where(b => b.Status != Status.Pending && b.Status != Status.Cancelled && b.Status != Status.NoShow).Sum(b => b.Tables.Count); }
        /*public int AssignedTableCount
        {
            get
            {
                int count = 0;
                foreach (var b in Bookings)
                {
                    if (b.Status != Status.Pending && b.Status != Status.Cancelled && b.Status != Status.NoShow)
                    {
                        count += b.Tables.Count;
                    }
                }
                return count;
            }
        }*/
        public int Unassigned { get => Bookings.Count(b => b.Status == Status.Pending); }
        public int Assigned { get => Bookings.Count(b => b.Status != Status.Pending && b.Status != Status.Cancelled && b.Status != Status.NoShow); }
        public int Cancelled { get => Bookings.Count(b => b.Status == Status.Cancelled); }

        public string WordDate { get => Date.ToLongDateString(); }
        public string MealType { get => Sitting.MealType.ToString(); }

        public List<Booking> Bookings { get; set; } = new List<Booking>();

        public List<Area> Areas { get; set; } = new List<Area>();
    }
}
