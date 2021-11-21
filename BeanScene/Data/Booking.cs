using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public enum Source { App,Website,Email,Phone,InPerson }
    public enum Status { Pending,Approved,Seated,Complete,NoShow,Cancelled }
    public class Booking
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please select a time.")]
        [DataType(DataType.Time)]
        [Display(Name = "Booking Start Time")] 
        public DateTime StartTime { get; set; }
        public int Duration { get; set; } = 90; // in minutes
        public DateTime EndTime { get => StartTime.AddMinutes(Duration); }
        public bool AdditionalTimeRequested { get; set; }
        [Required(ErrorMessage = "Please enter number of guests.")]
        public int Guests { get; set; }
        public string Notes { get; set; }
        public Source Source { get; set; }
        public Status Status { get; set; }

        public string WordDate { get => StartTime.ToLongDateString(); }
        public string ShortTime { get => StartTime.ToShortTimeString(); }

        public Service Service { get; set; }
        public Customer Customer { get; set; }
        public List<Table> Tables { get; set; } = new List<Table>();

        public string Table { get; set; }   // temporary quick implementation for table/reservation tracking
    }
}
