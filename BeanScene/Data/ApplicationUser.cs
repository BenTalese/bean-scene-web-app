using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BeanScene.Data
{
    public enum Role { Manager, Employee, Member }

    public class ApplicationUser : IdentityUser
    {
        //TODO: Add list to hold previous 5 passwords
    }
}
