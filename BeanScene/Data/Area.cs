using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public class Area
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please enter a name.")]
        [Display(Name = "Area Name")] 
        public string Name { get; set; }
        [Display(Name = "Seat Capacity")]
        public int SeatCapacity { get => Tables.Sum(t => t.Seats); }
        [Display(Name = "Table Capacity")]
        public int TableCapacity { get => Tables.Count; }
           
        public List<Service> Services { get; set; } = new List<Service>();
        public List<Table> Tables { get; set; } = new List<Table>();

        [Display(Name = "Table Numbers")]
        public string StringTables
        {
            get
            {
                var tableNumbers = "";
                foreach (var t in Tables)
                {
                    if (tableNumbers != "")
                    {
                        tableNumbers += ", ";
                    }
                    tableNumbers += $"{t.Prefix}-{t.Id}";
                }
                return tableNumbers;
            }
        }
    }
}
