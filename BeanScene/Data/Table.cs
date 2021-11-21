using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public class Table
    {
        public int Id { get; set; }
        public string Prefix { get; set; }
        public int Seats { get; set; }
        public string Name { get{ return $"{Prefix}-{Id}"; } }
        public List<Booking> Bookings { get; set; } = new List<Booking>();
    }
}
