using BeanScene.Data;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.Allocation
{
    public class Index
    {
        public List<Booking> Bookings { get; set; } = new List<Booking>();
        public List<Area> Areas { get; set; } = new List<Area>();
        public List<Service> Services { get; set; } = new List<Service>();
        public Service Service { get; set; }
        public DateTime EarliestStartTime { get; set; }
        public DateTime LatestEndTime { get; set; }
    }
}
