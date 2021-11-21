using BeanScene.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.Allocation
{
    public class Select
    {
        public int TotalTableCapacity { get; set; }
        public List<int> Years { get; set; } = new List<int>();
        public List<DateTime> MonthsWithYears { get; set; } = new List<DateTime>();
        public List<DateTime> Dates { get; set; } = new List<DateTime>();
        public List<Service> Services { get; set; } = new List<Service>();
    }
}
