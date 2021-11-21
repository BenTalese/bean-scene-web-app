using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Areas.Admin.Models.Staff
{
    public class Manage
    {
        public IEnumerable<IdentityUser> Managers { get; set; }
        public IEnumerable<IdentityUser> Staff { get; set; }
    }
}
