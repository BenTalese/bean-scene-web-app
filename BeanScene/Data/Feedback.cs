using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public enum Reason { Booking,Waitstaff,Bar,Kitchen,Other }
    public class Feedback
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public Reason Reason { get; set; }
        public string Comments { get; set; }
        public int Rating { get; set; }
        public bool FollowUpRequested { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
    }
}
